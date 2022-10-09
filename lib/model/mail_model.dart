import 'package:lyon1mail/lyon1mail.dart' as lyon1mail;
import 'package:hive_flutter/hive_flutter.dart';

part 'mail_model.g.dart';

@HiveType(typeId: 5)
class EmailModel {
  @HiveField(0)
  final String subject;
  @HiveField(1)
  final String sender;
  @HiveField(2)
  final String excerpt;
  @HiveField(3)
  final String body;
  @HiveField(4)
  final int? id;
  @HiveField(5)
  final bool isRead;
  @HiveField(6)
  final DateTime date;
  @HiveField(7)
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
