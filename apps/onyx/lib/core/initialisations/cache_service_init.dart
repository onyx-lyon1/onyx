import 'package:izlyclient/izlyclient.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/settings/settings_export.dart';

Future<void> hiveInit({String? path}) async {
  CacheService.registerAdapter<SettingsModel>(SettingsModelMapper.fromMap);

  CacheService.registerAdapter<IzlyCredential>(IzlyCredentialMapper.fromMap);
  CacheService.registerAdapter<IzlyQrCode>(IzlyQrCodeMapper.fromMap);
  CacheService.registerAdapter<PlatCrous>(PlatCrousMapper.fromMap);
  CacheService.registerAdapter<RestaurantModel>(RestaurantModelMapper.fromMap);
  CacheService.registerAdapter<IzlyPaymentModel>(
      IzlyPaymentModelMapper.fromMap);

  //TOMUSS
  CacheService.registerAdapter<Enumeration>(EnumerationMapper.fromMap);
  CacheService.registerAdapter<Grade>(GradeMapper.fromMap);
  CacheService.registerAdapter<Presence>(PresenceMapper.fromMap);
  // CacheService.registerAdapter<>( ,PresenceColorMapper.);
  CacheService.registerAdapter<Semester>(SemesterMapper.fromMap);
  CacheService.registerAdapter<StageCode>(StageCodeMapper.fromMap);
  CacheService.registerAdapter<Teacher>(TeacherMapper.fromMap);
  CacheService.registerAdapter<TeachingUnit>(TeachingUnitMapper.fromMap);
  CacheService.registerAdapter<TomussText>(TomussTextMapper.fromMap);
  CacheService.registerAdapter<Upload>(UploadMapper.fromMap);
  CacheService.registerAdapter<URL>(URLMapper.fromMap);

  //CAS
  CacheService.registerAdapter<Credential>(CredentialMapper.fromMap);

  //CALENDAR
  CacheService.registerAdapter<Agenda>(AgendaMapper.fromMap);
  CacheService.registerAdapter<Day>(DayMapper.fromMap);
  CacheService.registerAdapter<Event>(EventMapper.fromMap);

  //MAIL
  CacheService.registerAdapter<Action>(ActionMapper.fromMap);
  CacheService.registerAdapter<Mail>(MailMapper.fromMap);
  CacheService.registerAdapter<MailBox>(MailBoxMapper.fromMap);

  CacheService.init(cachePath: path, permanentPath: "/tmp/onyx/perma");
}
