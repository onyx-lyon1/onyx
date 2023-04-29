import 'dart:convert';

import 'package:biometric_storage/biometric_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  static List<int>? secureKey;

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
      print("error while getting cache : $e");
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
    if (secureKey != null) {
      return secureKey!;
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
    secureKey = base64Url.decode(data);
    return base64Url.decode(data);
  }
}
