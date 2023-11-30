import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';

Future<void> hiveInit({String? path}) async {
  Hive.registerAdapter(FunctionalitiesAdapter());
  Hive.registerAdapter(ThemeModeEnumAdapter());
  Hive.registerAdapter(SettingsModelAdapter());
  Hive.registerAdapter(ThemeSettingsModelAdapter());

  IzlyClient.registerAdapters();
  Lyon1TomussClient.registerAdapters();
  Lyon1CasClient.registerAdapters(initHive: false);
  Lyon1AgendaClient.registerAdapters();
  Lyon1MailClient.registerAdapters(initHive: false);

  if (path != null || kIsWeb) {
    Hive.init(path);
  } else {
    await Hive.initFlutter();
  }
}

Future<void> hiveReset({String? path}) async {
  hiveInit(path: path);
  await Hive.deleteBoxFromDisk('settings');
  await Hive.deleteBoxFromDisk('authentication');
  await Hive.deleteBoxFromDisk('tomuss');
  await Hive.deleteBoxFromDisk('agenda');
  await Hive.deleteBoxFromDisk('mails');
}
