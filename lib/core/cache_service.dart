import 'dart:convert';

import 'package:biometric_storage/biometric_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/core/res.dart';

class CacheService {
  static Future<E?> get<E>({int index = 0, List<int>? secureKey}) async {
    try {
      Box<E> box = await Hive.openBox<E>("cached_$E",
          encryptionCipher:
              (secureKey != null) ? HiveAesCipher(secureKey) : null);
      return box.get("cache$index");
    } catch (e) {
      return null;
    }
  }

  static Future<void> set<E>(E data,
      {int index = 0, List<int>? secureKey}) async {
    Box box = await Hive.openBox<E>("cached_$E",
        encryptionCipher:
            (secureKey != null) ? HiveAesCipher(secureKey) : null);
    box.put("cache$index", data);
  }

  static Future<bool> exist<E>({int index = 0, List<int>? secureKey}) async {
    Box box = await Hive.openBox<E>("cached_$E",
        encryptionCipher:
            (secureKey != null) ? HiveAesCipher(secureKey) : null);
    return box.containsKey("cache$index");
  }

  static Future<void> reset<E>() async {
    await Hive.deleteBoxFromDisk("cached_$E");
  }

  static Future<bool> existEncryptionKey(bool biometricAuth) async {
    if (biometricAuth) {
      final canAuthentificate = await BiometricStorage().canAuthenticate();
      if (canAuthentificate != CanAuthenticateResponse.success) {
        throw "unable to store secret securly : $canAuthentificate";
      }
    }
    BiometricStorageFile storageFile = await BiometricStorage().getStorage(
        "encryptionKey_${(biometricAuth) ? "biometric" : "password"})}",
        options: StorageFileInitOptions(
          androidBiometricOnly: true,
          authenticationValidityDurationSeconds: 30,
          authenticationRequired: biometricAuth,
        ));

    String? data = await storageFile.read();
    return data != null;
  }

  static Future<List<int>> getEncryptionKey(bool biometricAuth) async {
    if (Res.secureKey != null) {
      return Res.secureKey!;
    }
    if (biometricAuth) {
      final canAuthentificate = await BiometricStorage().canAuthenticate();
      if (canAuthentificate != CanAuthenticateResponse.success) {
        throw "unable to store secret securly : $canAuthentificate";
      }
    }
    BiometricStorageFile storageFile = await BiometricStorage().getStorage(
        "encryptionKey_${(biometricAuth) ? "biometric" : "password"})}",
        options: StorageFileInitOptions(
          androidBiometricOnly: true,
          authenticationValidityDurationSeconds: 30,
          authenticationRequired: biometricAuth,
        ));

    String? data = await storageFile.read();
    if (data == null) {
      data = base64Url.encode((Hive.generateSecureKey()));
      await storageFile.write(data);
    }
    Res.secureKey = base64Url.decode(data);
    return base64Url.decode(data);
  }
}
