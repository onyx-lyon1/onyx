import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/model/authentication.dart';
import 'package:oloid2/model/settings.dart';


import 'app.dart';

void main() async {
  Hive.registerAdapter(AuthenticationAdapter());
  Hive.registerAdapter(SettingsModelAdapter());
  await Hive.initFlutter();
  runApp(const OloidApp());
}
