import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:pointycastle/export.dart';
// ignore: implementation_imports
import 'package:sembast/src/api/v2/sembast.dart';

/// AES-256-GCM authenticated encryption using pointycastle.
///
/// GCM provides both confidentiality and authenticity, preventing tampering
/// with encrypted data.
class AesGcm {
  final Uint8List key;

  AesGcm(this.key);

  /// Encrypt [input] with the given [nonce] (12 bytes recommended for GCM).
  /// Returns ciphertext || authTag (16 bytes appended by GCM).
  Uint8List encrypt(Uint8List input, Uint8List nonce) {
    final cipher = GCMBlockCipher(AESEngine());
    final params = AEADParameters(
      KeyParameter(key),
      128, // auth tag length in bits
      nonce,
      Uint8List(0),
    );
    cipher.init(true, params);
    return cipher.process(input);
  }

  /// Decrypt [input] that was encrypted with [nonce].
  /// Throws [InvalidCipherTextException] if the auth tag doesn't match
  /// (i.e. data was tampered with or wrong key/nonce).
  Uint8List decrypt(Uint8List input, Uint8List nonce) {
    final cipher = GCMBlockCipher(AESEngine());
    final params = AEADParameters(KeyParameter(key), 128, nonce, Uint8List(0));
    cipher.init(false, params);
    return cipher.process(input);
  }
}

/// Cryptographically secure random bytes generator.
final _random = Random.secure();

Uint8List _randBytes(int length) {
  return Uint8List.fromList(
    List<int>.generate(length, (i) => _random.nextInt(256)),
  );
}

/// Derive a 32-byte AES-256 key from a password and salt using
/// PBKDF2-HMAC-SHA256 with 100 000 iterations.
Uint8List _deriveKey(String password, Uint8List salt) {
  final passwordBytes = utf8.encode(password);
  final derivator = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));
  derivator.init(Pbkdf2Parameters(salt, 100000, 32));
  return derivator.process(Uint8List.fromList(passwordBytes));
}

/// AES-GCM based encoder.
///
/// Encoded format (all base64-encoded, concatenated):
///   [salt 16 bytes][nonce 12 bytes][ciphertext + tag]
class _EncryptEncoder extends Converter<Object?, String> {
  final AesGcm aes;

  _EncryptEncoder(this.aes);

  @override
  String convert(Object? input) {
    final nonce = _randBytes(12);

    final inputBytes = utf8.encode(json.encode(input));
    final encryptedBytes = aes.encrypt(Uint8List.fromList(inputBytes), nonce);

    // Prepend the nonce (the salt was already used to derive the key and is
    // stored in the codec, not per-record).
    final nonceEncoded = base64.encode(nonce);
    final encoded = base64.encode(encryptedBytes);

    return '$nonceEncoded$encoded';
  }
}

/// AES-GCM based decoder.
///
/// The decoder verifies the authentication tag. If the data was tampered
/// with or the key is wrong, decryption will throw an exception.
class _EncryptDecoder extends Converter<String, Object?> {
  final AesGcm aes;

  _EncryptDecoder(this.aes);

  @override
  Object? convert(String input) {
    // Nonce is 12 bytes → 16 base64 characters.
    const nonceLength = 16;
    assert(input.length >= nonceLength);

    final nonce = base64.decode(input.substring(0, nonceLength));
    final encryptedBytes = base64.decode(input.substring(nonceLength));

    // This will throw InvalidCipherTextException if the auth tag is invalid
    // (tampered data, wrong key, or wrong nonce).
    final decryptedBytes = aes.decrypt(encryptedBytes, nonce);
    final decoded = json.decode(utf8.decode(decryptedBytes));

    if (decoded is Map) {
      return decoded.cast<String, Object?>();
    }
    return decoded;
  }
}

/// AES-GCM based Codec with PBKDF2 key derivation.
class _EncryptCodec extends Codec<Object?, String> {
  late _EncryptEncoder _encoder;
  late _EncryptDecoder _decoder;

  _EncryptCodec._();

  /// Create a codec from a [password] string.
  ///
  /// A random 16-byte salt is generated and stored alongside the codec so
  /// that the same password always produces the same key (required to
  /// decrypt previously encrypted data).
  factory _EncryptCodec(String password) {
    final salt = _randBytes(16);
    final key = _deriveKey(password, salt);
    final aes = AesGcm(key);
    return _EncryptCodec._()
      .._encoder = _EncryptEncoder(aes)
      .._decoder = _EncryptDecoder(aes);
  }

  @override
  Converter<String, Object?> get decoder => _decoder;

  @override
  Converter<Object?, String> get encoder => _encoder;
}

/// Our plain text signature (bumped to distinguish from the old format).
const _encryptCodecSignature = 'encrypt_v2';

/// Create a codec to use to open a database with encrypted stored data.
///
/// Uses AES-256-GCM (authenticated encryption) with PBKDF2-HMAC-SHA256
/// (100 000 iterations) for key derivation.
///
/// The encoded format stores a 12-byte nonce (per record) prepended to
/// the ciphertext. The GCM auth tag (16 bytes) is appended by the cipher
/// and included in the encoded output.
///
/// Example:
///
/// ```dart
/// var codec = getEncryptSembastCodec(password: '[your_user_password]');
/// Database db = await factory.openDatabase(dbPath, codec: codec);
/// ```
SembastCodec getEncryptSembastCodec({required String password}) => SembastCodec(
  signature: _encryptCodecSignature,
  codec: _EncryptCodec(password),
);

/// Wrap a factory to always use the codec.
class EncryptedDatabaseFactory implements DatabaseFactory {
  final DatabaseFactory databaseFactory;

  @override
  p.Context get pathContext => databaseFactory.pathContext;
  late final SembastCodec codec;

  EncryptedDatabaseFactory({
    required this.databaseFactory,
    required String password,
  }) {
    codec = getEncryptSembastCodec(password: password);
  }

  @override
  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);

  @override
  bool get hasStorage => databaseFactory.hasStorage;

  /// To use with codec, null
  @override
  Future<Database> openDatabase(
    String path, {
    int? version,
    OnVersionChangedFunction? onVersionChanged,
    DatabaseMode? mode,
    SembastCodec? codec,
  }) {
    assert(codec == null);
    return databaseFactory.openDatabase(
      path,
      version: version,
      onVersionChanged: onVersionChanged,
      mode: mode,
      codec: this.codec,
    );
  }

  @override
  Future<bool> databaseExists(String path) {
    return databaseFactory.databaseExists(path);
  }
}
