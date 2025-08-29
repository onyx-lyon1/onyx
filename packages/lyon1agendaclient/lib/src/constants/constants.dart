class Constants {
  static final String adeWebURL = "https://edt.univ-lyon1.fr/portal/";
  static final String adeResourcesUrl =
      "${adeWebURL}RestApi/portal/projects/$idProject/resourcestree";
  static final String adeTokenUrl =
      "${adeWebURL}RestApi/portal/ssologin";
  static final String adeAuthUrl =
      "${adeWebURL}RestApi/authentication/connecteduser";
  static final String userAgent =
      "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:96.0) Gecko/20100101 Firefox/96.0";
  static final int idProject = 1;
}
