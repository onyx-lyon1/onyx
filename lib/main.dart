import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oloid2/functionalities/background_notifications/background_tasks.dart';
import 'package:oloid2/functionalities/background_notifications/notification_service.dart';
import 'package:oloid2/others/hive_init.dart';
import 'package:workmanager/workmanager.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid || Platform.isIOS) {
    Workmanager()
        .initialize(callbackDispatcher, isInDebugMode: kDebugMode);
    Workmanager().registerPeriodicTask("updateChecking", "check update",
        frequency: const Duration(hours: 1),
        constraints: Constraints(networkType: NetworkType.connected));
  }
  await NotificationService.init();

  await hiveInit();

  final deviceInfo = await DeviceInfoPlugin().deviceInfo;
  final int androidSdkVersion =
      deviceInfo is AndroidDeviceInfo ? deviceInfo.version.sdkInt : 0;

  runApp(OloidApp(
    androidSdkVersion: androidSdkVersion,
  ));
}
