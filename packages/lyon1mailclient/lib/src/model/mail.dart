import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:enough_mail/enough_mail.dart';
import 'package:enough_mail_html/enough_mail_html.dart';
import 'package:equatable/equatable.dart';
import 'package:lyon1mailclient/src/config/config.dart';

part 'generated/mail.g.dart';

@CopyWith()
// ignore: must_be_immutable
class Mail extends Equatable {
  late final MimeMessage? rawMail;

  late final String subject;
  late final String sender;
  late final String excerpt;
  late final String body;
  late final int? id;
  late final bool isRead;
  late final bool isFlagged;
  late final DateTime date;
  late final String receiver;
  late final List<String> attachments;

  late List<File> attachmentsFiles;

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

  String getThemedBody(
      {String? bgColor, String? textColor, required bool isDarkMode}) {
    final String themeScript =
        """<script>${Lyon1MailClientConfig.darkReaderScript}</script>
    <script>
        DarkReader.enable({
        mode: ${(isDarkMode) ? "1" : "0"},
        brightness: 100,
        contrast: 100,
        sepia: 0,
        ${(isDarkMode && bgColor != null) ? "darkSchemeBackgroundColor: '$bgColor'," : ""}
        ${(isDarkMode && textColor != null) ? "darkSchemeTextColor: '$textColor'," : ""}
        ${(!isDarkMode && bgColor != null) ? "lightSchemeBackgroundColor: '$bgColor'," : ""}
        ${(!isDarkMode && textColor != null) ? "lightSchemeTextColor: '$textColor'," : ""}
    });
        // DarkReader.disable();
    </script>""";

    int index = body.indexOf("</head>");
    if (index != -1) {
      return "${body.substring(0, index)}\n$themeScript\n${body.substring(index)}";
    } else {
      return "$body\n$themeScript";
    }
  }

  @override
  List<Object?> get props => [
        subject,
        sender,
        excerpt,
        body,
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
