import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onyx/app.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/screens/notifications/notifications_export.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // debugRepaintRainbowEnabled = true;
  // debugRepaintTextRainbowEnabled = true;

  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    Workmanager().initialize(backgroundLogic, isInDebugMode: kDebugMode);
    Workmanager().registerPeriodicTask("updateChecking", "check update",
        frequency: const Duration(hours: 1),
        constraints: Constraints(networkType: NetworkType.connected));
    await NotificationLogic.init();
  }
  await hiveInit();

  final deviceInfo = await DeviceInfoPlugin().deviceInfo;
  final int androidSdkVersion =
      deviceInfo is AndroidDeviceInfo ? deviceInfo.version.sdkInt : 0;

  if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS || kIsWeb) {
    await Firebase.initializeApp();
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
  runApp(OnyxApp(
    androidSdkVersion: androidSdkVersion,
  ));
}
