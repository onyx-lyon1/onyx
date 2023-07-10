import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:lyon1casclient/lyon1_cas.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';

Future<void> hiveInit({String? path}) async {
  Hive.registerAdapter(FunctionalitiesAdapter());
  Hive.registerAdapter(ThemeModeEnumAdapter());
  Hive.registerAdapter(SettingsModelAdapter());

  IzlyClient.registerAdapters();
  Dartus.registerAdapters();
  Lyon1Cas.registerAdapters(initHive: false);
  Lyon1Agenda.registerAdapters();
  Lyon1Mail.registerAdapters(initHive: false);

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
