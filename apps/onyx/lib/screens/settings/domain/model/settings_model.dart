import 'package:dart_mappable/dart_mappable.dart';
import 'package:onyx/core/res.dart';

part 'generated/settings_model.mapper.dart';

const List<Functionalities> defaultEnabledFunctionalities = [
  Functionalities.mail,
  Functionalities.tomuss,
  Functionalities.agenda,
  Functionalities.settings,
  Functionalities.izly,
  Functionalities.examen,
  Functionalities.map,
];

const List<Functionalities> defaultDisabledFunctionalities = [];

@MappableClass()
class SettingsModel with SettingsModelMappable {
  final bool firstLogin;
  final bool biometricAuth;

  //tomuss
  final bool forceGreen;
  final bool newGradeNotification;
  final bool showHiddenUE;
  final int recentGradeDuration;

  //agenda
  final bool fetchAgendaAuto;
  final bool showMiniCalendar;
  final bool calendarUpdateNotification;
  final int? agendaId;
  final List<int> agendaIds;
  final int agendaWeekLength;
  final int agendaWeekReference;

  final int agendaWeekRerenceAlignement;

  final List<int> agendaDisabledDays;

  final bool agendaPageTopToBottom;

  //Mail
  final bool newMailNotification;
  final bool blockTrackers;
  final bool forcedMailTheme;

  final List<Functionalities> enabledFunctionalities;

  final List<Functionalities> disabledFunctionalities;

  final bool mock;

  final bool shownAgendaPopup;

  // Colloscope
  final int colloscopeOverrideStudentId;
  final int colloscopeOverrideYearId;
  final bool? colloscopeEnabled;
  final bool examenAddToAgenda;

  final String? language;

  final bool izlyNotification;

  const SettingsModel({
    this.biometricAuth = false,
    this.forceGreen = false,
    this.newGradeNotification = true,
    this.showHiddenUE = false,
    this.fetchAgendaAuto = true,
    this.showMiniCalendar = true,
    this.calendarUpdateNotification = true,
    this.agendaIds = const [],
    this.newMailNotification = true,
    this.blockTrackers = true,
    this.forcedMailTheme = true,
    this.shownAgendaPopup = false,
    this.enabledFunctionalities = defaultEnabledFunctionalities,
    this.disabledFunctionalities = defaultDisabledFunctionalities,
    this.recentGradeDuration = 7,
    this.firstLogin = true,
    this.mock = false,
    this.agendaWeekLength = 5,
    this.agendaWeekReference = 0,
    this.agendaDisabledDays = const [6, 7],
    this.agendaPageTopToBottom = false,
    this.agendaWeekRerenceAlignement = 0,
    this.colloscopeOverrideStudentId = -1,
    this.colloscopeOverrideYearId = 0,
    this.colloscopeEnabled,
    this.agendaId,
    this.examenAddToAgenda = true,
    this.language,
    this.izlyNotification = true,
  });
}
