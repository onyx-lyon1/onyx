class SettingsModel {
  late String username;
  late String password;
  late bool keepMeLoggedIn = true;

  late bool forceGreen = false;
  late bool darkMode = true;
  late bool newGradeNotification = false;
  late bool showHiddenUE = false;

  late bool fetchAgendaAuto = true;
  late bool showMiniCalendar = true;
  late String agendaURL = "";

  late bool newMailNotification = false;
  late bool blockTrackers = true;

  SettingsModel(this.username, this.password);

  void copy(SettingsModel s) {
    username = s.username;
    password = s.password;
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
}
