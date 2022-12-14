import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:lyon1mail/lyon1mail.dart' as lyon1mail;

part 'email_model.g.dart';

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
  bool isRead;
  @HiveField(6)
  bool isFlagged;
  @HiveField(7)
  final DateTime date;
  @HiveField(8)
  final String receiver;
  @HiveField(9)
  final List<String> attachments;

  Mail? rawMail;

  EmailModel(
      {required this.subject,
      required this.sender,
      required this.excerpt,
      required this.isRead,
      required this.date,
      required this.body,
      required this.id,
      required this.receiver,
      required this.attachments,
      required this.isFlagged,
      this.rawMail});

  static EmailModel fromMailLib(lyon1mail.Mail mail) {
    return EmailModel(
      subject: mail.getSubject,
      sender: mail.getSender,
      excerpt: mail.getBody(excerpt: true),
      isRead: mail.isSeen,
      date: mail.getDate,
      body: mail.getBody(excerpt: false),
      id: mail.getSequenceId,
      receiver: "me",
      attachments: mail.getAttachmentsNames,
      isFlagged: mail.isFlagged,
      rawMail: mail,
    );
  }


  @override
  String toString() {
    return 'EmailModel{subject: $subject, sender: $sender, excerpt: $excerpt, body: $body, id: $id, isRead: $isRead, isFlagged: $isFlagged, date: $date, receiver: $receiver, attachments: $attachments, rawMail: $rawMail}';
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
          receiver == other.receiver &&
          listEquals(attachments, other.attachments) &&
          isFlagged == other.isFlagged &&
          rawMail == other.rawMail;

  @override
  int get hashCode =>
      subject.hashCode ^
      sender.hashCode ^
      excerpt.hashCode ^
      body.hashCode ^
      id.hashCode ^
      isRead.hashCode ^
      date.hashCode ^
      receiver.hashCode ^
      attachments.hashCode ^
      isFlagged.hashCode ^
      rawMail.hashCode;
}
