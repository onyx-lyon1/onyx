import 'package:izlyclient/izlyclient.dart' as izly;
import 'package:lyon1agendaclient/lyon1agendaclient.dart' as agenda;
import 'package:lyon1casclient/lyon1casclient.dart' as cas;
import 'package:lyon1examenclient/lyon1examenclient.dart' as examen;
import 'package:lyon1mailclient/lyon1mailclient.dart' as mailclient;
import 'package:lyon1tomussclient/lyon1tomussclient.dart' as tomuss;
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart' as core;
import 'package:onyx/core/screens/home/state/home_cubit.dart' as home;
import 'package:onyx/screens/mails/states/email_send_cubit.dart' as mail;
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polytechcolloscopeclient/polytechcolloscopeclient.dart' as polytech;
import 'package:sembast/sembast_io.dart';

Future<Database> initSembastDb([String? dbDirPath]) async {
  String path;
  if (dbDirPath == null) {
    final dir = await getApplicationDocumentsDirectory();
    path = dir.path;
  } else {
    path = dbDirPath;
  }
  final dbPath = join(path, 'onyx.db');
  final db = await databaseFactoryIo.openDatabase(dbPath);
  CacheService.db = db;

  // Settings mappers
  ThemeSettingsModelMapper.ensureInitialized();
  ThemeModeEnumMapper.ensureInitialized();
  SettingsModelMapper.ensureInitialized();

  // Core mappers
  core.FunctionalitiesMapper.ensureInitialized();

  // Home state mappers
  home.HomeStateMapper.ensureInitialized();
  home.HomeStatusMapper.ensureInitialized();

  // Email mappers
  mail.EmailSendStateMapper.ensureInitialized();
  mail.EmailSendStatusMapper.ensureInitialized();

  // Izly client mappers
  izly.CbModelMapper.ensureInitialized();
  izly.IzlyCredentialMapper.ensureInitialized();
  izly.IzlyPaymentModelMapper.ensureInitialized();
  izly.IzlyPaymentModelListMapper.ensureInitialized();
  izly.IzlyQrCodeMapper.ensureInitialized();
  izly.IzlyQrCodeListMapper.ensureInitialized();
  izly.MenuCrousMapper.ensureInitialized();
  izly.MenuTypeMapper.ensureInitialized();
  izly.PlatCrousMapper.ensureInitialized();
  izly.RestaurantModelMapper.ensureInitialized();
  izly.RestaurantListModelMapper.ensureInitialized();
  izly.CrousTypeMapper.ensureInitialized();

  // Agenda client mappers
  agenda.AgendaMapper.ensureInitialized();
  agenda.AgendaResourceMapper.ensureInitialized();
  agenda.DayMapper.ensureInitialized();
  agenda.EventMapper.ensureInitialized();

  // CAS client mappers
  cas.CredentialMapper.ensureInitialized();

  // Examen client mappers
  examen.ExamenListModelMapper.ensureInitialized();
  examen.ExamenModelMapper.ensureInitialized();

  // Mail client mappers
  mailclient.ActionMapper.ensureInitialized();
  mailclient.ActionListMapper.ensureInitialized();
  mailclient.ActionTypeMapper.ensureInitialized();
  mailclient.AddressMapper.ensureInitialized();
  mailclient.MailMapper.ensureInitialized();
  mailclient.MailBoxMapper.ensureInitialized();
  mailclient.MailBoxListMapper.ensureInitialized();
  mailclient.SpecialMailBoxMapper.ensureInitialized();

  // Tomuss client mappers
  tomuss.EnumerationMapper.ensureInitialized();
  tomuss.GradeMapper.ensureInitialized();
  tomuss.PresenceMapper.ensureInitialized();
  tomuss.PresenceColorMapper.ensureInitialized();
  tomuss.SemesterMapper.ensureInitialized();
  tomuss.SemesterListMapper.ensureInitialized();
  tomuss.StageCodeMapper.ensureInitialized();
  tomuss.StudentMapper.ensureInitialized();
  tomuss.TeacherMapper.ensureInitialized();
  tomuss.TeachingUnitMapper.ensureInitialized();
  tomuss.TeachingUnitListMapper.ensureInitialized();
  tomuss.TomussTextMapper.ensureInitialized();
  tomuss.UploadMapper.ensureInitialized();
  tomuss.URLMapper.ensureInitialized();

  // Polytech colloscope client mappers
  polytech.KholleMapper.ensureInitialized();
  polytech.StudentMapper.ensureInitialized();
  polytech.StudentColloscopeMapper.ensureInitialized();
  polytech.YearMapper.ensureInitialized();

  return db;
}
