import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

Future<void> hiveInit({String? path}) async {
  Hive.registerAdapter(AuthenticationModelAdapter());

  Hive.registerAdapter(DayModelAdapter());
  Hive.registerAdapter(DayModelWrapperAdapter());
  Hive.registerAdapter(EventModelAdapter());

  Hive.registerAdapter(GradeModelAdapter());
  Hive.registerAdapter(TeacherModelAdapter());
  Hive.registerAdapter(SemestreModelAdapter());
  Hive.registerAdapter(SemestreModelWrapperAdapter());
  Hive.registerAdapter(SchoolSubjectModelAdapter());
  Hive.registerAdapter(SchoolSubjectModelWrapperAdapter());

  Hive.registerAdapter(EmailModelAdapter());
  Hive.registerAdapter(MailBoxModelAdapter());
  Hive.registerAdapter(MailBoxWrapperAdapter());

  Hive.registerAdapter(SettingsModelAdapter());
  Hive.registerAdapter(FunctionalitiesAdapter());
  Hive.registerAdapter(ThemeModeEnumAdapter());

  Hive.registerAdapter(IzlyCredentialAdapter());
  Hive.registerAdapter(IzlyQrCodeModelAdapter());
  Hive.registerAdapter(IzlyQrCodeModelWrapperAdapter());
  if (path != null) {
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
