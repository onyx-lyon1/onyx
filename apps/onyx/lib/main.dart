import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    // a ipad size
    // await DesktopWindow.setWindowSize(const Size(2048 / 2, 2732 / 2));
    //my galaxy note 9 size (divised by four for usability on my computer)
    await DesktopWindow.setWindowSize(const Size(1440 / 4, 2960 / 4));
  }

  EquatableConfig.stringify = true;

  runApp(const OnyxApp());
}
