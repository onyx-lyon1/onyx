import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 7)
class SettingsModel {
  @HiveField(0)
  late bool keepMeLoggedIn;

  //tomuss
  @HiveField(1)
  late bool forceGreen;
  @HiveField(2)
  late ThemeModeEnum themeMode;
  @HiveField(3)
  late bool newGradeNotification;
  @HiveField(4)
  late bool showHiddenUE;

  //agenda
  @HiveField(5)
  late bool fetchAgendaAuto;
  @HiveField(6)
  late bool showMiniCalendar;
  @HiveField(7)
  late bool calendarUpdateNotification;
  @HiveField(8)
  late int? agendaId;

  //email
  @HiveField(9)
  late bool newMailNotification;
  @HiveField(10)
  late bool blockTrackers;
  @HiveField(11)
  late bool darkerMail;

  @HiveField(12, defaultValue: [
    Functionalities.tomuss,
    Functionalities.agenda,
    Functionalities.mail,
    Functionalities.settings,
    Functionalities.izly,
    Functionalities.map,
  ])
  late List<Functionalities> enabledFunctionalities;
  @HiveField(13, defaultValue: [])
  late List<Functionalities> disabledFunctionalities;

  SettingsModel({
    this.keepMeLoggedIn = true,
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
    this.darkerMail = true,
    this.enabledFunctionalities = const [
      Functionalities.tomuss,
      Functionalities.agenda,
      Functionalities.mail,
      Functionalities.settings,
      Functionalities.izly,
      Functionalities.map,
    ],
    this.disabledFunctionalities = const [],
  });

  SettingsModel copyWith({
    bool? keepMeLoggedIn,
    bool? forceGreen,
    ThemeModeEnum? themeMode,
    bool? newGradeNotification,
    bool? showHiddenUE,
    bool? fetchAgendaAuto,
    bool? showMiniCalendar,
    bool? calendarUpdateNotification,
    int? agendaId,
    bool? newMailNotification,
    bool? blockTrackers,
    bool? darkerMail,
    List<Functionalities>? enabledFunctionalities,
    List<Functionalities>? disabledFunctionalities,
  }) {
    return SettingsModel(
      keepMeLoggedIn: keepMeLoggedIn ?? this.keepMeLoggedIn,
      forceGreen: forceGreen ?? this.forceGreen,
      themeMode: themeMode ?? this.themeMode,
      newGradeNotification: newGradeNotification ?? this.newGradeNotification,
      showHiddenUE: showHiddenUE ?? this.showHiddenUE,
      fetchAgendaAuto: fetchAgendaAuto ?? this.fetchAgendaAuto,
      calendarUpdateNotification:
          calendarUpdateNotification ?? this.calendarUpdateNotification,
      showMiniCalendar: showMiniCalendar ?? this.showMiniCalendar,
      agendaId: agendaId ?? this.agendaId,
      newMailNotification: newMailNotification ?? this.newMailNotification,
      blockTrackers: blockTrackers ?? this.blockTrackers,
      darkerMail: darkerMail ?? this.darkerMail,
      enabledFunctionalities:
          enabledFunctionalities ?? this.enabledFunctionalities,
      disabledFunctionalities:
          disabledFunctionalities ?? this.disabledFunctionalities,
    );
  }

  @override
  String toString() {
    return 'SettingsModel{keepMeLoggedIn: $keepMeLoggedIn, forceGreen: $forceGreen, themeMode: $themeMode, newGradeNotification: $newGradeNotification, showHiddenUE: $showHiddenUE, fetchAgendaAuto: $fetchAgendaAuto, showMiniCalendar: $showMiniCalendar, calendarUpdateNotification: $calendarUpdateNotification, agendaURL: $agendaId, newMailNotification: $newMailNotification, blockTrackers: $blockTrackers, darkerMail: $darkerMail enabledFunctionalities: $enabledFunctionalities, disabledFunctionalities: $disabledFunctionalities}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsModel &&
          runtimeType == other.runtimeType &&
          keepMeLoggedIn == other.keepMeLoggedIn &&
          forceGreen == other.forceGreen &&
          themeMode == other.themeMode &&
          newGradeNotification == other.newGradeNotification &&
          showHiddenUE == other.showHiddenUE &&
          fetchAgendaAuto == other.fetchAgendaAuto &&
          showMiniCalendar == other.showMiniCalendar &&
          calendarUpdateNotification == other.calendarUpdateNotification &&
          agendaId == other.agendaId &&
          newMailNotification == other.newMailNotification &&
          blockTrackers == other.blockTrackers &&
          darkerMail == other.darkerMail &&
          enabledFunctionalities == other.enabledFunctionalities &&
          disabledFunctionalities == other.disabledFunctionalities;

  @override
  int get hashCode =>
      keepMeLoggedIn.hashCode ^
      forceGreen.hashCode ^
      themeMode.hashCode ^
      newGradeNotification.hashCode ^
      showHiddenUE.hashCode ^
      fetchAgendaAuto.hashCode ^
      showMiniCalendar.hashCode ^
      calendarUpdateNotification.hashCode ^
      agendaId.hashCode ^
      newMailNotification.hashCode ^
      blockTrackers.hashCode ^
      darkerMail.hashCode ^
      enabledFunctionalities.hashCode ^
      disabledFunctionalities.hashCode;
}
