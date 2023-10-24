import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:path_provider/path_provider.dart';

Future<void> hiveInit({String? path}) async {
  Hive.registerAdapter(
      "SettingsModel", (json) => SettingsModelMapper.fromJson(json));

  Hive.registerAdapter(
      "IzlyCredential", (json) => IzlyCredentialMapper.fromJson(json));
  Hive.registerAdapter("IzlyQrCode", (json) => IzlyQrCodeMapper.fromJson(json));
  Hive.registerAdapter("PlatCrous", (json) => PlatCrousMapper.fromJson(json));
  Hive.registerAdapter(
      "RestaurantModel", (json) => RestaurantModelMapper.fromJson(json));
  Hive.registerAdapter(
      "IzlyPaymentModel", (json) => IzlyPaymentModelMapper.fromJson(json));

  //TOMUSS
  Hive.registerAdapter(
      "Enumeration", (json) => EnumerationMapper.fromJson(json));
  Hive.registerAdapter("Grade", (json) => GradeMapper.fromJson(json));
  Hive.registerAdapter("Presence", (json) => PresenceMapper.fromJson(json));
  // Hive.registerAdapter("PresenceColor", (json) => ,PresenceColorMapper.);
  Hive.registerAdapter("Semester", (json) => SemesterMapper.fromJson(json));
  Hive.registerAdapter("StageCode", (json) => StageCodeMapper.fromJson(json));
  Hive.registerAdapter("Teacher", (json) => TeacherMapper.fromJson(json));
  Hive.registerAdapter(
      "TeachingUnit", (json) => TeachingUnitMapper.fromJson(json));
  Hive.registerAdapter("TomussText", (json) => TomussTextMapper.fromJson(json));
  Hive.registerAdapter("Upload", (json) => UploadMapper.fromJson(json));
  Hive.registerAdapter("URL", (json) => URLMapper.fromJson(json));

  //CAS
  Hive.registerAdapter("Credential", (json) => CredentialMapper.fromJson(json));

  //CALENDAR
  Hive.registerAdapter("Agenda", (json) => AgendaMapper.fromJson(json));
  Hive.registerAdapter("Day", (json) => DayMapper.fromJson(json));
  Hive.registerAdapter("Event", (json) => EventMapper.fromJson(json));

  //MAIL
  Hive.registerAdapter("Action", (json) => ActionMapper.fromJson(json));
  Hive.registerAdapter("Mail", (json) => MailMapper.fromJson(json));
  Hive.registerAdapter("MailBox", (json) => MailBoxMapper.fromJson(json));

  if (path != null || kIsWeb) {
    Hive.defaultDirectory = path;
  } else {
    Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  }
}

void hiveReset({String? path}) {
  hiveInit(path: path);
  //TODO modify dir
  Hive.deleteAllBoxesFromDisk();
}
