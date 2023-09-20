class Lyon1MailClientConfig {
  static const String base = "univ-lyon1.fr";

  static const String imapHost = "accesbv.$base";
  static const int imapPort = 993;
  static const bool imapSecure = true;

  static const String smtpHost = "smtpbv.$base";
  static const int smtpPort = 587;
  static const bool smtpSecure = false;

  static const String darkReaderScript =
      """<script src="https://cdn.jsdelivr.net/npm/darkreader/darkreader.min.js"></script>
    <script>
        DarkReader.enable({
            brightness: 100,
            contrast: 90,
            sepia: 10
        });
        // DarkReader.disable();
    </script>""";
}
