import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

Future<void> hiveInit({String? path}) async {
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
  await Hive.deleteBoxFromDisk('cached_colloscope_data');
}
