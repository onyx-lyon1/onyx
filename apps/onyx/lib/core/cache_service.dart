import 'dart:convert';
import 'dart:io';

import 'package:biometric_storage/biometric_storage.dart';
import 'package:encrypt/encrypt.dart';
import 'package:onyx/core/res.dart';
import 'package:path_provider/path_provider.dart';

class CacheService {
  static List<int>? _secureKey;
  static BiometricStorageFile? _storageFile;
  static bool? _isBiometricEnabled;
  static String cachePath = "";
  static String permanentPath = "";

  static final Map<Type, Function(String)> _adapters = {};

  static void init({String? cachePath, String? permanentPath}) async {
    CacheService.cachePath =
        cachePath ?? (await getApplicationCacheDirectory()).path;
    CacheService.permanentPath =
        permanentPath ?? (await getApplicationDocumentsDirectory()).path;
    _adapters[List] = (json) => jsonDecode(json);
  }

  static void registerAdapter<T>(T? Function(String) fromJson) {
    if (!_adapters.keys.contains(T)) {
      _adapters[T] = fromJson;
      _adapters[List<T>] = (json) => listParser<T>(json);
    }
  }

  static List<E> listParser<E>(String jsonData) {
    List<String> datas = jsonDecode(jsonData);
    return datas.map((e) => _adapters[E]!(e)).cast<E>().toList();
  }

  static E? get<E>(
      {int index = 0, List<int>? secureKey, bool permanent = false}) {
    try {
      File file = File(
          "${(permanent) ? permanentPath : cachePath}/cached_${E.toString()}_$index.data");
      if (!file.existsSync()) return null;
      String data = file.readAsStringSync();
      if (secureKey != null) {
        final key = Key.fromUtf8(String.fromCharCodes(secureKey));
        final encrypter = Encrypter(AES(key));
        data = encrypter.decrypt(Encrypted.fromUtf8(data));
      }
      if (_adapters.keys.contains(E)) {
        return _adapters[E]!(data);
      }
      return jsonDecode(data);
    } catch (e) {
      Res.logger.e("error while getting cache for $E: $e");
      reset<E>();
      return null;
    }
  }

  static void set<E>(E data,
      {int index = 0, List<int>? secureKey, bool permanent = false}) {
    try {
      File file = File(
          "${(permanent) ? permanentPath : cachePath}/cached_${E.toString()}_$index.data");
      if (!file.existsSync()) file.createSync(recursive: true);
      String dataString = (data is String) ? data : jsonEncode(data);
      if (secureKey != null) {
        final key = Key.fromUtf8(String.fromCharCodes(secureKey));
        final encryptor = Encrypter(AES(key));
        dataString = encryptor.encrypt(dataString).base64;
      }
      file.writeAsStringSync(dataString);
    } catch (e) {
      Res.logger.e("error while setting cache for $E: $e");
      reset<E>();
    }
  }

  static bool exist<E>({int index = 0, bool permanent = false}) {
    try {
      File file = File(
          "${(permanent) ? permanentPath : cachePath}/cached_${E.toString()}_$index.data");
      return file.existsSync();
    } catch (e) {
      Res.logger.e("error while checking existence of cache for $E: $e");
      reset<E>();
      return false;
    }
  }

  static void reset<E>({bool permanent = false}) {
    try {
      //list files
      Directory directory = Directory((permanent) ? permanentPath : cachePath);
      List<FileSystemEntity> files = directory.listSync();
      //filter files
      files = files
          .where((element) =>
              element.path.contains("cached_${E.toString()}_") &&
              element.path.endsWith(".data"))
          .toList();
      //delete files
      for (var element in files) {
        element.deleteSync();
      }
    } catch (e) {
      Res.logger.e("error while resetting cache for $E: $e");
    }
  }

  static void resetAll({bool cache = true, bool permanent = true}) {
    if (cache) {
      Directory directory = Directory(cachePath);
      List<FileSystemEntity> files = directory.listSync();
      files = files
          .where((element) =>
              element.path.contains("cached_") &&
              element.path.endsWith(".data"))
          .toList();
      for (var element in files) {
        element.deleteSync();
      }
    }
    if (permanent) {
      Directory directory = Directory(permanentPath);
      List<FileSystemEntity> files = directory.listSync();
      files = files
          .where((element) =>
              element.path.contains("cached_") &&
              element.path.endsWith(".data"))
          .toList();
      for (var element in files) {
        element.deleteSync();
      }
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

  static Future<List<int>> getEncryptionKey(bool biometricAuth,
      {bool autoRetry = false}) async {
    if (_isBiometricEnabled != null && _isBiometricEnabled != biometricAuth) {
      await toggleBiometricAuth(biometricAuth);
    }
    if (_secureKey != null) {
      return _secureKey!;
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
        data = Key.fromSecureRandom(1024).base64;
        await _storageFile!.write(data);
      }
      _secureKey = base64Url.decode(data);
      return _secureKey!;
    } on AuthException catch (exception) {
      Res.logger.e("error while getting encryption key : $exception");
      if (autoRetry && exception.code == AuthExceptionCode.userCanceled) {
        return getEncryptionKey(biometricAuth, autoRetry: autoRetry);
      }
      rethrow;
    }
  }
}
