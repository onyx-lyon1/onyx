// The original content is temporarily commented out to allow generating a self-contained demo - feel free to uncomment later.

// import 'dart:io';
//
// import 'package:desktop_window/desktop_window.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:onyx/app.dart';
// import 'package:onyx/core/bloc_logger.dart';
// import 'package:onyx/core/initialisations/initialisations_export.dart';
// import 'package:onyx/screens/notifications/notifications_export.dart';
// import 'package:onyx/screens/settings/settings_export.dart';
// import 'package:onyx/screens/settings/states/theme_cubit.dart';
// import 'package:workmanager/workmanager.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
//     Workmanager().initialize(workmanagerHandler, isInDebugMode: kDebugMode);
//     Workmanager().registerPeriodicTask("updateChecking", "check update",
//         frequency: const Duration(hours: 1),
//         constraints: Constraints(networkType: NetworkType.connected));
//     await NotificationLogic.init();
//   }
//
//   await hiveInit();
//
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//
//   if (!kIsWeb && (Platform.isLinux || Platform.isWindows || Platform.isMacOS)) {
//     //an iphone se size
//     // await DesktopWindow.setWindowSize(const Size(375, 667));
//     // a ipad size
//     // await DesktopWindow.setWindowSize(const Size(2048 / 2, 2732 / 2));
//     //my galaxy note 9 size (divised by four for usability on my computer)
//     await DesktopWindow.setWindowSize(const Size(1440 / 4, 2960 / 4));
//   }
//
//   EquatableConfig.stringify = true;
//
//   Bloc.observer = BlocLogger();
//
//   //Load theme and settings
//   ThemeSettingsModel theme = await ThemeCubit().init();
//   SettingsModel settings = await SettingsCubit().load();
//
//   runApp(OnyxApp(theme: theme, settings: settings));
// }
//

import 'package:flutter/material.dart';
import 'package:onyx/src/rust/api/simple.dart';
import 'package:onyx/src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
        body: Center(
          child: Text(
              'Action: Call Rust `greet("Tom")`\nResult: `${greet(name: "Tom")}`'),
        ),
      ),
    );
  }
}
