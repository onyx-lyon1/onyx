import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/core/res.dart';

part 'generated/settings_model.g.dart';

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
  @HiveField(27, defaultValue: [])
  final List<int> agendaIds;
  @HiveField(19, defaultValue: 5)
  final int agendaWeekLength;
  @HiveField(20, defaultValue: 0)
  final int agendaWeekReference;

  @HiveField(23, defaultValue: 0)
  final int agendaWeekRerenceAlignement;

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

  @HiveField(12, defaultValue: defaultEnabledFunctionalities)
  final List<Functionalities> enabledFunctionalities;

  @HiveField(13, defaultValue: defaultDisabledFunctionalities)
  final List<Functionalities> disabledFunctionalities;

  @HiveField(17, defaultValue: false)
  final bool mock;

  @HiveField(18, defaultValue: false)
  final bool shownAgendaPopup;

  // Colloscope

  @HiveField(24, defaultValue: true)
  final bool colloscopeAutoUpdateAgenda;
  @HiveField(25, defaultValue: 0)
  final int colloscopeOverrideStudentId;
  @HiveField(26, defaultValue: 0)
  final int colloscopeOverrideYearId;
  @HiveField(28, defaultValue: null)
  final bool? colloscopeEnabled;
  @HiveField(29, defaultValue: true)
  final bool examenAddToAgenda;

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
    this.colloscopeAutoUpdateAgenda = true,
    this.colloscopeOverrideStudentId = -1,
    this.colloscopeOverrideYearId = 0,
    this.colloscopeEnabled,
    this.agendaId,
    this.examenAddToAgenda = true,
  });

  @override
  List<Object?> get props => [
        forceGreen,
        newGradeNotification,
        showHiddenUE,
        fetchAgendaAuto,
        showMiniCalendar,
        calendarUpdateNotification,
        agendaIds,
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
        agendaPageTopToBottom,
        agendaWeekRerenceAlignement,
        colloscopeAutoUpdateAgenda,
        colloscopeOverrideStudentId,
        colloscopeOverrideYearId,
        colloscopeEnabled,
        agendaId,
      ];

  @override
  bool? get stringify => true;
}
