import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:enough_mail/enough_mail.dart';
import 'package:enough_mail_html/enough_mail_html.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'generated/mail.g.dart';

@CopyWith()
@HiveType(typeId: 5)
class Mail extends Equatable {
  late final MimeMessage? rawMail;

  @HiveField(0)
  late final String subject;
  @HiveField(1)
  late final String sender;
  @HiveField(2)
  late final String excerpt;
  @HiveField(3)
  late final String body;
  @HiveField(10, defaultValue: "")
  late final String blackBody;
  @HiveField(4)
  late final int? id;
  @HiveField(5)
  late final bool isRead;
  @HiveField(6)
  late final bool isFlagged;
  @HiveField(7)
  late final DateTime date;
  @HiveField(8)
  late final String receiver;
  @HiveField(9)
  late final List<String> attachments;

  late final List<File> attachmentsFiles;

  Mail.fromRaw(this.rawMail, {bool removeTrackingImages = false}) {
    subject = rawMail!.decodeSubject() ?? "";
    sender = rawMail!.fromEmail ?? "n/a";
    isRead = rawMail!.hasFlag(MessageFlags.seen);
    date = rawMail!.decodeDate() ?? DateTime.now();
    isFlagged = rawMail!.isFlagged;

    body = rawMail!.transformToHtml(
      blockExternalImages: removeTrackingImages,
      emptyMessageText: 'Le message est vide',
      enableDarkMode: false,
    );
    blackBody = rawMail!.transformToHtml(
      blockExternalImages: removeTrackingImages,
      emptyMessageText: 'Le message est vide',
      enableDarkMode: true,
    );
    excerpt = HtmlToPlainTextConverter.convert(body)
        .replaceAll("\n", "")
        .substring(
            0,
            min(
                HtmlToPlainTextConverter.convert(body)
                    .replaceAll("\n", "")
                    .length,
                100));
    id = rawMail!.sequenceId;
    receiver = rawMail!.to!
        .map((e) => e.email)
        .toList()
        .join(", "); //.substring(0, receiver.length - 2);
    if (rawMail!.hasAttachments()) {
      attachments = rawMail!.allPartsFlat
          .where((element) => element.decodeFileName() != null)
          .map((e) => e.decodeFileName())
          .toList()
          .cast<String>();
    } else {
      attachments = [];
    }
    attachmentsFiles = [];
  }

  Mail({
    required this.subject,
    required this.sender,
    required this.excerpt,
    required this.isRead,
    required this.date,
    required this.body,
    this.blackBody = "",
    required this.id,
    required this.receiver,
    required this.attachments,
    required this.isFlagged,
    this.attachmentsFiles = const [],
    this.rawMail,
  });

  Mail.forSending({
    required this.subject,
    required this.body,
    required this.receiver,
    this.attachmentsFiles = const [],
  }) {
    sender = "";
    excerpt = HtmlToPlainTextConverter.convert(body)
        .replaceAll("\n", "")
        .substring(
            0,
            min(
                HtmlToPlainTextConverter.convert(body)
                    .replaceAll("\n", "")
                    .length,
                100));
    isRead = false;
    date = DateTime.now();
    blackBody = body;
    id = null;
    attachments = attachmentsFiles.map((e) => e.path.split("/").last).toList();
    isFlagged = false;
    rawMail = null;
  }

  Mail.forReplying({
    required this.body,
    required Mail mail,
    this.attachmentsFiles = const [],
  }) {
    receiver = mail.sender;
    sender = mail.receiver;
    subject = "";
    excerpt = HtmlToPlainTextConverter.convert(body)
        .replaceAll("\n", "")
        .substring(
            0,
            min(
                HtmlToPlainTextConverter.convert(body)
                    .replaceAll("\n", "")
                    .length,
                100));
    isRead = false;
    date = DateTime.now();
    blackBody = body;
    id = null;
    attachments = attachmentsFiles.map((e) => e.path.split("/").last).toList();
    isFlagged = false;
    rawMail = null;
  }

  Mail.forForwarding({
    required this.body,
    required this.receiver,
    required Mail mail,
    this.attachmentsFiles = const [],
  }) {
    sender = mail.receiver;
    subject = "";
    excerpt = HtmlToPlainTextConverter.convert(body)
        .replaceAll("\n", "")
        .substring(
            0,
            min(
                HtmlToPlainTextConverter.convert(body)
                    .replaceAll("\n", "")
                    .length,
                100));
    isRead = false;
    date = DateTime.now();
    blackBody = body;
    id = null;
    attachments = attachmentsFiles.map((e) => e.path.split("/").last).toList();
    isFlagged = false;
    rawMail = null;
  }

/*
  List<String> get getRecipients {
    const List<String> recipients = [];
    for (MailAddress m in _originalMessage!.cc ?? []) {
      recipients.add(m.email);
    }
    return recipients;
  }
*/

  List<int> getAttachment(String fileName) {
    assert(rawMail != null);
    final List<MimePart> parts = rawMail!.allPartsFlat;
    for (final MimePart mp in parts) {
      if (mp.decodeFileName() == fileName) {
        Uint8List? content = mp.decodeContentBinary();
        if (content == null) {
          throw Exception("Unable to get attachment");
        }
        return content.toList();
      }
    }
    throw Exception("Unable to get attachment");
  }

  @override
  List<Object?> get props => [
        subject,
        sender,
        excerpt,
        body,
        blackBody,
        id,
        isRead,
        isFlagged,
        date,
        receiver,
        attachments,
      ];

  @override
  bool? get stringify => true;
}
