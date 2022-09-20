// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 2)
class SettingsModel {
  @HiveField(0)
  late bool keepMeLoggedIn;

  @HiveField(1)
  late bool forceGreen;
  @HiveField(2)
  late bool darkMode;
  @HiveField(3)
  late bool newGradeNotification;

  @HiveField(4)
  late bool showHiddenUE;

  @HiveField(5)
  late bool fetchAgendaAuto;

  @HiveField(6)
  late bool showMiniCalendar;

  @HiveField(7)
  late String agendaURL;

  @HiveField(8)
  late bool newMailNotification;

  @HiveField(9)
  late bool blockTrackers;

  SettingsModel({
    this.keepMeLoggedIn = true,
    this.forceGreen = false,
    this.darkMode = true,
    this.newGradeNotification = false,
    this.showHiddenUE = false,
    this.fetchAgendaAuto = true,
    this.showMiniCalendar = true,
    this.agendaURL = "",
    this.newMailNotification = false,
    this.blockTrackers = true,
  });

  void copy(SettingsModel s) {
    keepMeLoggedIn = s.keepMeLoggedIn;
    forceGreen = s.forceGreen;
    darkMode = s.darkMode;
    newGradeNotification = s.newGradeNotification;
    showHiddenUE = s.showHiddenUE;
    fetchAgendaAuto = s.fetchAgendaAuto;
    agendaURL = s.agendaURL;
    newMailNotification = s.newMailNotification;
    blockTrackers = s.blockTrackers;
  }

  SettingsModel copyWith({
    bool? keepMeLoggedIn,
    bool? forceGreen,
    bool? darkMode,
    bool? newGradeNotification,
    bool? showHiddenUE,
    bool? fetchAgendaAuto,
    bool? showMiniCalendar,
    String? agendaURL,
    bool? newMailNotification,
    bool? blockTrackers,
  }) {
    return SettingsModel(
      keepMeLoggedIn: keepMeLoggedIn ?? this.keepMeLoggedIn,
      forceGreen: forceGreen ?? this.forceGreen,
      darkMode: darkMode ?? this.darkMode,
      newGradeNotification: newGradeNotification ?? this.newGradeNotification,
      showHiddenUE: showHiddenUE ?? this.showHiddenUE,
      fetchAgendaAuto: fetchAgendaAuto ?? this.fetchAgendaAuto,
      showMiniCalendar: showMiniCalendar ?? this.showMiniCalendar,
      agendaURL: agendaURL ?? this.agendaURL,
      newMailNotification: newMailNotification ?? this.newMailNotification,
      blockTrackers: blockTrackers ?? this.blockTrackers,
    );
  }

  @override
  String toString() {
    return 'SettingsModel(keepMeLoggedIn: $keepMeLoggedIn, forceGreen: $forceGreen, darkMode: $darkMode, newGradeNotification: $newGradeNotification, showHiddenUE: $showHiddenUE, fetchAgendaAuto: $fetchAgendaAuto, showMiniCalendar: $showMiniCalendar, agendaURL: $agendaURL, newMailNotification: $newMailNotification, blockTrackers: $blockTrackers)';
  }
}
