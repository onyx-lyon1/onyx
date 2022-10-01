import 'package:lyon1mail/lyon1mail.dart' as lyon1mail;

class EmailModel {
  final String subject;
  final String sender;
  final String excerpt;
  final String body;
  final int? id;
  final bool isRead;
  final DateTime date;
  final String receiver;

  EmailModel(
      {required this.subject,
      required this.sender,
      required this.excerpt,
      required this.isRead,
      required this.date,
      required this.body,
      required this.id,
      required this.receiver});

  static EmailModel fromMailLib(lyon1mail.Mail mail) {
    return EmailModel(
        subject: mail.getSubject(),
        sender: mail.getSender(),
        excerpt: mail.getBody(excerpt: true),
        isRead: mail.isSeen(),
        date: mail.getDate(),
        body: mail.getBody(excerpt: false),
        id: mail.getSequenceId(),
        receiver: "me");
  }
}
