class SettingsModel {
  late String username;
  late String password;
  late bool keepMeLoggedIn = true;

  late bool forceGreen = false;
  late bool darkMode = true;
  late bool newGradeNotification = false;
  late bool showHiddenUE = false;

  late bool fetchAgendaAuto = true;
  late String agendaURL = "";

  late bool newMailNotification = false;
  late bool blockTrackers = true;

  SettingsModel(this.username, this.password);
}
