import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:onyx/app.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/screens/notifications/notifications_export.dart';
import 'package:onyx/screens/settings/domain/model/settings_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // debugRepaintRainbowEnabled = true;
  // debugRepaintTextRainbowEnabled = true;

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    Workmanager().initialize(workmanagerHandler, isInDebugMode: kDebugMode);
    Workmanager().registerPeriodicTask("updateChecking", "check update",
        frequency: const Duration(hours: 1),
        constraints: Constraints(networkType: NetworkType.connected));
    await NotificationLogic.init();
  }
  await hiveInit();

  if (!kIsWeb && (Platform.isLinux || Platform.isWindows || Platform.isMacOS)) {
    //an iphone se size
    // await DesktopWindow.setWindowSize(const Size(375, 667));
    //a ipad size
    // await DesktopWindow.setWindowSize(const Size(1080, 810));
  }

  EquatableConfig.stringify = true;

  if (!kIsWeb) {
    //Code to handle the migration to secured credentials storage
    SettingsModel settings =
        await CacheService.get<SettingsModel>() ?? const SettingsModel();
    bool authFileExist = await File(
            "${(await getApplicationDocumentsDirectory()).path}/authentification.hive")
        .exists();
    if (authFileExist) {
      //migration needed
      Box<Credential> authBox =
          await Hive.openBox<Credential>("authentification");
      if (authBox.containsKey("credential")) {
        Credential? creds = authBox.get("credential");
        if (creds != null) {
          await authBox.deleteFromDisk();
          await CacheService.set<Credential>(creds,
              secureKey:
                  await CacheService.getEncryptionKey(settings.biometricAuth));
        }
      }
      if (await CacheService.exist<IzlyCredential>()) {
        IzlyCredential? creds = await CacheService.get<IzlyCredential>();
        if (creds != null) {
          await CacheService.reset<IzlyCredential>();
          await CacheService.set<IzlyCredential>(creds,
              secureKey:
                  await CacheService.getEncryptionKey(settings.biometricAuth));
        }
      }
    }
  }

  runApp(const OnyxApp());
}
