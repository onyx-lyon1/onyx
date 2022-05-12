import 'package:flutter/material.dart';

import 'home.dart';
import 'model/day.dart';
import 'model/email.dart';
import 'model/settings.dart';
import 'model/teaching_unit.dart';
import 'theme/theme.dart';

class OloidApp extends StatefulWidget {
  const OloidApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return OloidAppState();
  }
}

class OloidAppState extends State<OloidApp> {
  final SettingsModel settings = SettingsModel('', '');
  final List<TeachingUnitModel> teachingUnits = [];
  final List<DayModel> days = [];
  final List<EmailModel> emails = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oloid 2.0',
      debugShowCheckedModeBanner: false,
      themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: OloidTheme.lighTheme(),
      darkTheme: OloidTheme.darkTheme(),
      home: Home(settings, (SettingsModel settings) {
        setState(() {});
      }),
    );
  }
}
