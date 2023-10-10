import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';

part 'generated/settings_model.g.dart';

@CopyWith()
@HiveType(typeId: 7)
class SettingsModel extends Equatable {
  @HiveField(15, defaultValue: true)
  final bool firstLogin;
  @HiveField(16, defaultValue: false)
  final bool biometricAuth;

  //tomuss
  @HiveField(1)
  final bool forceGreen;
  @HiveField(2)
  final ThemeModeEnum themeMode;
  @HiveField(3)
  final bool newGradeNotification;
  @HiveField(4)
  final bool showHiddenUE;
  @HiveField(14, defaultValue: 7)
  final int recentGradeDuration;

  //agenda
  @HiveField(5)
  final bool fetchAgendaAuto;
  @HiveField(6)
  final bool showMiniCalendar;
  @HiveField(7)
  final bool calendarUpdateNotification;
  @HiveField(8)
  final int? agendaId;
  @HiveField(19, defaultValue: 5)
  final int agendaWeekLength;
  @HiveField(20, defaultValue: 0)
  final int agendaWeekReference;
  @HiveField(21, defaultValue: [6, 7])
  final List<int> agendaDisabledDays;

  @HiveField(22, defaultValue: false)
  final bool agendaPageTopToBottom;

  //Mail
  @HiveField(9)
  final bool newMailNotification;
  @HiveField(10)
  final bool blockTrackers;
  @HiveField(11)
  final bool forcedMailTheme;

  @HiveField(12, defaultValue: [
    Functionalities.tomuss,
    Functionalities.agenda,
    Functionalities.mail,
    Functionalities.settings,
    Functionalities.izly,
    Functionalities.map,
  ])
  final List<Functionalities> enabledFunctionalities;
  @HiveField(13, defaultValue: [])
  final List<Functionalities> disabledFunctionalities;

  @HiveField(17, defaultValue: false)
  final bool mock;

  @HiveField(18, defaultValue: false)
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
    this.agendaWeekReference = 1,
    this.agendaDisabledDays = const [6, 7],
    this.agendaPageTopToBottom = false,
  });

  @override
  List<Object?> get props => [
        forceGreen,
        themeMode,
        newGradeNotification,
        showHiddenUE,
        fetchAgendaAuto,
        showMiniCalendar,
        calendarUpdateNotification,
        agendaId,
        newMailNotification,
        blockTrackers,
        forcedMailTheme,
        enabledFunctionalities,
        disabledFunctionalities,
        recentGradeDuration,
        firstLogin,
        biometricAuth,
        mock,
        shownAgendaPopup,
        agendaWeekLength,
        agendaWeekReference,
        agendaDisabledDays,
        agendaPageTopToBottom
      ];

  @override
  bool? get stringify => true;
}
