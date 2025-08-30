import 'dart:convert';

import 'package:biometric_storage/biometric_storage.dart';
import 'package:onyx/core/initialisations/sembast_init.dart';
import 'package:onyx/core/res.dart';
import 'package:sembast/sembast_io.dart';

import 'encrypt_codec.dart';

class CacheService {
  static List<int>? secureKey;
  static BiometricStorageFile? _storageFile;
  static bool? _isBiometricEnabled;
  static Database? _db;

  static Future<Database> _getDb({List<int>? secureKey}) async {
    _db ??= await initSembastDb();
    if (secureKey != null) {
      // Utilisation du codec d'encryption Sembast (Salsa20)
      final codec = getEncryptSembastCodec(
        password: base64Url.encode(secureKey),
      );
      return await databaseFactoryIo.openDatabase(_db!.path, codec: codec);
    }
    return _db!;
  }

  static StoreRef<String, dynamic> _getStore<E>() {
    return StoreRef<String, dynamic>('cached_${E.toString()}');
  }

  static Future<E?> get<E>({int index = 0, List<int>? secureKey}) async {
    try {
      final db = await _getDb(secureKey: secureKey);
      final store = _getStore<E>();
      return await store.record('cache$index').get(db) as E?;
    } catch (e) {
      Res.logger.e("error while getting cache for $E: $e");
      await reset<E>(secureKey: secureKey);
      return null;
    }
  }

  static Future<void> set<E>(
    E data, {
    int index = 0,
    List<int>? secureKey,
  }) async {
    try {
      final db = await _getDb(secureKey: secureKey);
      final store = _getStore<E>();
      await store.record('cache$index').put(db, data);
    } catch (e) {
      Res.logger.e("error while setting cache for $E: $e");
      await reset<E>(secureKey: secureKey);
    }
  }

  static Future<bool> exist<E>({int index = 0, List<int>? secureKey}) async {
    try {
      final db = await _getDb(secureKey: secureKey);
      final store = _getStore<E>();
      return await store.record('cache$index').exists(db);
    } catch (e) {
      Res.logger.e("error while checking existence of cache for $E: $e");
      await reset<E>(secureKey: secureKey);
      return false;
    }
  }

  static Future<void> reset<E>({List<int>? secureKey}) async {
    try {
      final db = await _getDb(secureKey: secureKey);
      final store = _getStore<E>();
      // Supprime tous les enregistrements du store
      await store.drop(db);
    } catch (e) {
      Res.logger.e("error while resetting cache for $E: $e");
    }
  }

  static Future<bool> toggleBiometricAuth(bool biometricAuth) async {
    List<int> key = await getEncryptionKey(!biometricAuth);
    _isBiometricEnabled = biometricAuth;
    if (biometricAuth) {
      final canAuthentificate = await BiometricStorage().canAuthenticate();
      if (canAuthentificate != CanAuthenticateResponse.success) {
        throw "unable to store secret securly : $canAuthentificate";
      }
    }
    if (_storageFile != null) await _storageFile!.delete();
    _storageFile = await BiometricStorage().getStorage(
      "encryptionKey_${(biometricAuth) ? "secure" : "lesssecure"}",
      options: StorageFileInitOptions(
        androidBiometricOnly: true,
        authenticationValidityDurationSeconds: 10,
        authenticationRequired: biometricAuth,
      ),
    );
    await _storageFile!.write(base64Encode(key));
    return true;
  }

  static Future<List<int>> getEncryptionKey(
    bool biometricAuth, {
    bool autoRetry = false,
  }) async {
    if (_isBiometricEnabled != null && _isBiometricEnabled != biometricAuth) {
      await toggleBiometricAuth(biometricAuth);
    }
    if (secureKey != null) {
      return secureKey!;
    }
    if (_isBiometricEnabled ?? false) {
      final canAuthentificate = await BiometricStorage().canAuthenticate();
      if (canAuthentificate != CanAuthenticateResponse.success) {
        throw "unable to store secret securly : $canAuthentificate";
      }
    }
    _storageFile = await BiometricStorage().getStorage(
      "encryptionKey_${(biometricAuth) ? "secure" : "lesssecure"}",
      options: StorageFileInitOptions(
        androidBiometricOnly: true,
        authenticationValidityDurationSeconds: 10,
        authenticationRequired: biometricAuth,
      ),
    );

    try {
      String? data = await _storageFile!.read();
      if (data == null) {
        // Générer une clé aléatoire (32 bytes)
        final key = List<int>.generate(
          32,
          (i) => i * DateTime.now().millisecondsSinceEpoch % 256,
        );
        data = base64Encode(key);
        await _storageFile!.write(data);
      }
      secureKey = base64Url.decode(data);
      return secureKey!;
    } on AuthException catch (exception) {
      Res.logger.e("error while getting encryption key : $exception");
      if (autoRetry && exception.code == AuthExceptionCode.userCanceled) {
        return getEncryptionKey(biometricAuth, autoRetry: autoRetry);
      }
      rethrow;
    }
  }
}
