class Lyon1MailClientConfig {
  static const String base = "univ-lyon1.fr";

  static const String imapHost = "accesbv.$base";
  static const int imapPort = 993;
  static const bool imapSecure = true;

  static const String smtpHost = "smtpbv.$base";
  static const int smtpPort = 587;
  static const bool smtpSecure = false;
}
