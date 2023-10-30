import 'package:lyon1mailclient/lyon1mailclient.dart';

void main() async {
  final Lyon1MailClient mailClient =
      Lyon1MailClient("p1234567", "a_valid_password", cachePath: "/tmp/onyx/cache");

  if (!await mailClient.login()) {
    // handle gracefully
  }

  final List<Mail>? emailOpt = await mailClient.fetchMessages(15);
  if (emailOpt == null || emailOpt.isEmpty) {
    // No emails
  }

  for (final Mail mail in emailOpt!) {
    print(
        "${mail.sender} sent ${mail.subject} @${mail.date.toIso8601String()}");
    print("\tseen: ${mail.isRead}");
    print("\t${mail.excerpt}");
    print("\thasPJ: ${mail.attachments.isNotEmpty}");
    for (var fname in mail.attachments) {
      print("\t\t$fname");
    }
  }

  await mailClient.logout();
}
