// ignore_for_file: unnecessary_overrides

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailModel &&
          runtimeType == other.runtimeType &&
          subject == other.subject &&
          sender == other.sender &&
          excerpt == other.excerpt &&
          body == other.body &&
          id == other.id &&
          isRead == other.isRead &&
          date == other.date &&
          receiver == other.receiver;

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() {
    return 'EmailModel{subject: $subject, sender: $sender, excerpt: $excerpt, body: $body, id: $id, isRead: $isRead, date: $date, receiver: $receiver}';
  }
}
