import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onyx/app.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/screens/notifications/notifications_export.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(OloidApp(
    androidSdkVersion: androidSdkVersion,
  ));
}
