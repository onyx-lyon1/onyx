import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/functionalities/background_notifications/background_tasks.dart';
import 'package:oloid2/model/authentication.dart';
import 'package:oloid2/model/day_model.dart';
import 'package:oloid2/model/event_model.dart';
import 'package:oloid2/model/grade_model.dart';
import 'package:oloid2/model/mail_model.dart';
import 'package:oloid2/model/settings.dart';
import 'package:oloid2/model/teacher_model.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/model/text_model.dart';
import 'package:oloid2/model/wrapper/day_model_wrapper.dart';
import 'package:oloid2/model/wrapper/email_model_wrapper.dart';
import 'package:oloid2/model/wrapper/teaching_unit_model_wrapper.dart';
import 'package:workmanager/workmanager.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.registerAdapter(AuthenticationAdapter());
  Hive.registerAdapter(DayModelAdapter());
  Hive.registerAdapter(DayModelWrapperAdapter());
  Hive.registerAdapter(EventModelAdapter());
  Hive.registerAdapter(GradeModelAdapter());
  Hive.registerAdapter(EmailModelAdapter());
  Hive.registerAdapter(EmailModelWrapperAdapter());
  Hive.registerAdapter(SettingsModelAdapter());
  Hive.registerAdapter(TeacherModelAdapter());
  Hive.registerAdapter(TeachingUnitModelAdapter());
  Hive.registerAdapter(TeachingUnitModelWrapperAdapter());
  Hive.registerAdapter(TextModelAdapter());

  if (Platform.isAndroid || Platform.isIOS) {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    Workmanager().registerPeriodicTask("notesChecking", "check new notes",
        frequency: const Duration(minutes: 15),
        constraints: Constraints(networkType: NetworkType.connected));
    Workmanager().registerPeriodicTask(
        "agendaChecking", "check new agenda events",
        frequency: const Duration(minutes: 15),
        constraints: Constraints(networkType: NetworkType.connected));
    Workmanager().registerPeriodicTask("mailChecking", "check new emails",
        frequency: const Duration(minutes: 15),
        constraints: Constraints(networkType: NetworkType.connected));
  }

  final deviceInfo = await DeviceInfoPlugin().deviceInfo;
  final int androidSdkVersion =
      deviceInfo is AndroidDeviceInfo ? deviceInfo.version.sdkInt! : 0;

  await Hive.initFlutter();
  runApp(OloidApp(
    androidSdkVersion: androidSdkVersion,
  ));
}
