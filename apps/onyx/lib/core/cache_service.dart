import 'dart:convert';
import 'dart:io';

import 'package:biometric_storage/biometric_storage.dart';
import 'package:encrypt/encrypt.dart';
import 'package:onyx/core/res.dart';
import 'package:path_provider/path_provider.dart';

class CacheService {
  static String? _secureKey;
  static BiometricStorageFile? _storageFile;
  static bool? _isBiometricEnabled;
  static String cachePath = "";
  static String permanentPath = "";

  static final Map<Type, Function> _adapters =
      {}; //function not typed because could take Map or List

  static void init({String? cachePath, String? permanentPath}) async {
    CacheService.cachePath =
        cachePath ?? (await getApplicationCacheDirectory()).path;
    CacheService.permanentPath =
        permanentPath ?? (await getApplicationDocumentsDirectory()).path;
    //create folder if not exist
    Directory(CacheService.cachePath).createSync(recursive: true);
    Directory(CacheService.permanentPath).createSync(recursive: true);
    _adapters[List<int>] = (data) => data.cast<int>();
    _adapters[List<double>] = (data) => data.cast<double>();
    _adapters[List<String>] = (data) => data.cast<String>();
    _adapters[List<bool>] = (data) => data.cast<bool>();
    _adapters[List<num>] = (data) => data.cast<num>();
    _adapters[List<Record>] = (data) => data.cast<Record>();
  }

  static void registerAdapter<T>(T? Function(Map<String, dynamic>) fromJson) {
    if (!_adapters.keys.contains(T)) {
      _adapters[T] = fromJson;
      _adapters[List<T>] = listParser<T>;
    }
  }

  static List<E> listParser<E>(List jsonData) {
    return jsonData
        .map((e) => _adapters[E]!((e is String) ? jsonDecode(e) : e))
        .cast<E>()
        .toList();
  }

  static E? get<E>({int index = 0, String? secureKey, bool permanent = false}) {
    try {
      File file = File(
          "${(permanent) ? permanentPath : cachePath}/${E.toString()}_$index.data");
      if (!file.existsSync()) return null;
      String data = file.readAsStringSync();
      if (secureKey != null) {
        final key = Key.fromBase64(secureKey);
        File ivFile = File("${file.path}.iv");
        if (!ivFile.existsSync()) return null;
        final iv = IV.fromBase64(ivFile.readAsStringSync());
        final encrypter = Encrypter(AES(key));
        data = encrypter.decrypt64(data, iv: iv);
        //remove begin \" and end \" from string
        data = data.substring(1, data.length - 1).replaceAll("\\", "");
      }
      if (_adapters.keys.contains(E)) {
        return _adapters[E]!(jsonDecode(data));
      }
      return jsonDecode(data);
    } catch (e) {
      Res.logger.e("error while getting cache for $E: $e");
      reset<E>();
      return null;
    }
  }

  static void set<E>(E data,
      {int index = 0, String? secureKey, bool permanent = false}) {
    try {
      File file = File(
          "${(permanent) ? permanentPath : cachePath}/${E.toString()}_$index.data");
      if (!file.existsSync()) file.createSync(recursive: true);
      String dataString = jsonEncode(data);
      if (secureKey != null) {
        final key = Key.fromBase64(secureKey);
        final encryptor = Encrypter(AES(key));
        final iv = IV.fromSecureRandom(16);
        dataString = encryptor.encrypt(dataString, iv: iv).base64;
        File ivFile = File("${file.path}.iv");
        if (!ivFile.existsSync()) ivFile.createSync(recursive: true);
        ivFile.writeAsStringSync(iv.base64);
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
          "${(permanent) ? permanentPath : cachePath}/${E.toString()}_$index.data");
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
              element.path.contains("${E.toString()}_") &&
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
              element.path.contains("") && element.path.endsWith(".data"))
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
              element.path.contains("") && element.path.endsWith(".data"))
          .toList();
      for (var element in files) {
        element.deleteSync();
      }
    }
  }

  static Future<bool> toggleBiometricAuth(bool biometricAuth) async {
    String key = await getEncryptionKey(!biometricAuth);
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
    await _storageFile!.write(key);
    return true;
  }

  static Future<String> getEncryptionKey(bool biometricAuth,
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
        data = Key.fromSecureRandom(32).base64;
        await _storageFile!.write(data);
      }
      _secureKey = data;
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
