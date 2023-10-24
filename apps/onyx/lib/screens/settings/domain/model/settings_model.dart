import 'package:dart_mappable/dart_mappable.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';

part 'settings_model.mapper.dart';

@MappableClass()
class SettingsModel with SettingsModelMappable {
  final bool firstLogin;
  final bool biometricAuth;

  //tomuss
  final bool forceGreen;
  final ThemeModeEnum themeMode;
  final bool newGradeNotification;
  final bool showHiddenUE;
  final int recentGradeDuration;

  //agenda
  final bool fetchAgendaAuto;
  final bool showMiniCalendar;
  final bool calendarUpdateNotification;
  final int? agendaId;
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

  const SettingsModel({
    this.biometricAuth = false,
    this.forceGreen = false,
    this.themeMode = ThemeModeEnum.system,
    this.newGradeNotification = true,
    this.showHiddenUE = false,
    this.fetchAgendaAuto = true,
    this.showMiniCalendar = true,
    this.calendarUpdateNotification = true,
    this.agendaId,
    this.newMailNotification = true,
    this.blockTrackers = true,
    this.forcedMailTheme = true,
    this.shownAgendaPopup = false,
    this.enabledFunctionalities = const [
      Functionalities.tomuss,
      Functionalities.agenda,
      Functionalities.mail,
      Functionalities.settings,
      Functionalities.izly,
      Functionalities.map,
    ],
    this.disabledFunctionalities = const [],
    this.recentGradeDuration = 7,
    this.firstLogin = true,
    this.mock = false,
    this.agendaWeekLength = 5,
    this.agendaWeekReference = 0,
    this.agendaDisabledDays = const [6, 7],
    this.agendaPageTopToBottom = false,
    this.agendaWeekRerenceAlignement = 0,
  });
}
