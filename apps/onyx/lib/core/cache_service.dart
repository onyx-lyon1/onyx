import 'dart:convert';

import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/core/res.dart';

class CacheService {
  static List<int>? secureKey;
  static BiometricStorageFile? _storageFile;
  static bool? _isBiometricEnabled;

  static Future<E?> get<E>({int index = 0, List<int>? secureKey}) async {
    try {
      Box<E> box = await Hive.openBox<E>(
        "cached_$E",
        encryptionCipher: (secureKey != null) ? HiveAesCipher(secureKey) : null,
        crashRecovery: false,
      );
      return box.get("cache$index");
    } catch (e) {
      Res.logger.e("error while getting cache for $E: $e");
      await reset<E>();
      return null;
    }
  }

  static Future<void> set<E>(E data,
      {int index = 0, List<int>? secureKey}) async {
    try {
      Box box = await Hive.openBox<E>(
        "cached_$E",
        encryptionCipher: (secureKey != null) ? HiveAesCipher(secureKey) : null,
        crashRecovery: false,
      );
      await box.put("cache$index", data);
    } catch (e) {
      if (kDebugMode) {
        Res.logger.e("error while setting cache for $E: $e");
      }
      await reset<E>();
    }
  }

  static Future<bool> exist<E>({int index = 0, List<int>? secureKey}) async {
    try {
      Box box = await Hive.openBox<E>(
        "cached_$E",
        encryptionCipher: (secureKey != null) ? HiveAesCipher(secureKey) : null,
        crashRecovery: false,
      );
      return box.containsKey("cache$index");
    } catch (e) {
      Res.logger.e("error while checking existence of cache for $E: $e");
      await reset<E>();
      return false;
    }
  }

  static Future<void> reset<E>() async {
    await Hive.deleteBoxFromDisk("cached_$E");
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
        data = base64Encode(Hive.generateSecureKey());
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
