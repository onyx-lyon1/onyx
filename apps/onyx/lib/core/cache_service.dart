import 'dart:convert';

import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  static List<int>? secureKey;
  static BiometricStorageFile? _storageFile;
  static bool? _isBiometricEnabled;

  static Future<E?> get<E>({int index = 0, List<int>? secureKey}) async {
    // print("getting cache for $E, with key : $secureKey");
    try {
      Box<E> box = await Hive.openBox<E>(
        "cached_$E",
        encryptionCipher: (secureKey != null) ? HiveAesCipher(secureKey) : null,
        crashRecovery: false,
      );
      return box.get("cache$index");
    } catch (e) {
      if (kDebugMode) {
        print("error while getting cache for $E: $e");
      }
      return null;
    }
  }

  static Future<void> set<E>(E data,
      {int index = 0, List<int>? secureKey}) async {
    // print("settings cache for $E, with key : $secureKey");
    Box box = await Hive.openBox<E>(
      "cached_$E",
      encryptionCipher: (secureKey != null) ? HiveAesCipher(secureKey) : null,
      crashRecovery: false,
    );
    await box.put("cache$index", data);
  }

  static Future<bool> exist<E>({int index = 0, List<int>? secureKey}) async {
    Box box = await Hive.openBox<E>(
      "cached_$E",
      encryptionCipher: (secureKey != null) ? HiveAesCipher(secureKey) : null,
      crashRecovery: false,
    );
    return box.containsKey("cache$index");
  }

  static Future<void> reset<E>() async {
    await Hive.deleteBoxFromDisk("cached_$E");
  }

  static Future<List<int>> getEncryptionKey(bool biometricAuth,
      {bool autoRetry = true}) async {
    if (secureKey != null) {
      return secureKey!;
    }
    if (_storageFile == null ||
        (_isBiometricEnabled != null && _isBiometricEnabled != biometricAuth)) {
      _isBiometricEnabled = biometricAuth;
      if (biometricAuth) {
        final canAuthentificate = await BiometricStorage().canAuthenticate();
        if (canAuthentificate != CanAuthenticateResponse.success) {
          throw "unable to store secret securly : $canAuthentificate";
        }
      }
      if (_storageFile != null) await _storageFile!.delete();
      _storageFile = await BiometricStorage().getStorage(
          "encryptionKey_${(biometricAuth) ? "biometric" : "password"}",
          options: StorageFileInitOptions(
            androidBiometricOnly: false,
            authenticationValidityDurationSeconds: 0,
            //because we store the key in cache ourself
            authenticationRequired: biometricAuth,
          ));
    }

    try {
      String? data = await _storageFile!.read();
      if (data == null) {
        data = base64Url.encode((Hive.generateSecureKey()));
        await _storageFile!.write(data);
      }
      secureKey = base64Url.decode(data);
      return base64Url.decode(data);
    } on AuthException catch (exception) {
      if (kDebugMode) {
        print("error while getting encryption key : $exception");
      }
      if (autoRetry && exception.code == AuthExceptionCode.userCanceled) {
        return getEncryptionKey(biometricAuth, autoRetry: autoRetry);
      }
      rethrow;
    }
  }
}
