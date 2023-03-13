import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/mails/mails_export.dart';

class EmailLogic {
  static Future<Lyon1Mail> connect(
      {required String username, required String password}) async {
    Lyon1Mail mailClient = Lyon1Mail(username, password);
    if (Res.mock) {
      return mailClient;
    }
    if (!await mailClient.login()) {
      throw Exception("Login failed");
    }
    return mailClient;
  }

  static Future<List<EmailModel>> load(
      {required Lyon1Mail mailClient, required int emailNumber}) async {
    if (Res.mock) {
      return emailListMock;
    }
    List<EmailModel> tmpEmailsComplete = [];
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        throw Exception("Login failed");
      }
    }
    final List<Mail>? emailOpt = await mailClient.fetchMessages(emailNumber);
    if (emailOpt == null || emailOpt.isEmpty) {
      if (kDebugMode) {
        print("no emails");
      }
    } else {
      for (final Mail mail in emailOpt) {
        if (!tmpEmailsComplete.any((element) =>
            element.date == mail.getDate &&
            element.body == mail.getBody(excerpt: false))) {
          tmpEmailsComplete.add(EmailModel.fromMailLib(mail));
        }
      }
    }
    return tmpEmailsComplete;
  }

  static Future<bool> send(
      {required Lyon1Mail mailClient,
      required EmailModel email,
      int? originalMessageId,
      bool? replyAll,
      bool forward = false,
      bool reply = false,
      required int emailNumber,
      required List<EmailModel> emailsComplete}) async {
    if (Res.mock) {
      return true;
    }
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        throw Exception("Login failed");
      }
    }
    if (reply) {
      try {
        await mailClient.fetchMessages(emailNumber);
        await mailClient.reply(
          originalMessageId: originalMessageId!,
          body: email.body,
          replyAll: replyAll ?? false,
        );
      } catch (e) {
        throw Exception("Reply failed");
      }
    } else if (forward) {
      try {
        List<Address> recipients = [];
        if (email.receiver.contains("@") && email.receiver.contains(".")) {
          for (var i in email.receiver.split(",")) {
            recipients.add(Address(i, i));
          }
        } else {
          recipients
              .add((await mailClient.resolveContact(email.receiver)).first);
        }
        await mailClient.fetchMessages(emailNumber);
        await mailClient.forward(
          originalMessageId: originalMessageId!,
          body: email.body,
          recipient: recipients,
          attachments: email.attachments.map((e) => File(e)).toList(),
        );
      } catch (e) {
        throw Exception("Reply failed");
      }
    } else {
      try {
        List<Address> recipients = [];
        if (email.receiver.contains("@") && email.receiver.contains(".")) {
          for (var i in email.receiver.split(",")) {
            recipients.add(Address(i, i));
          }
        } else {
          recipients
              .add((await mailClient.resolveContact(email.receiver)).first);
        }
        await mailClient.sendEmail(
          sender: mailClient.emailAddress,
          recipients: recipients,
          subject: email.subject,
          body: email.body,
          attachments: email.attachments.map((e) => File(e)).toList(),
        );
      } catch (e) {
        if (kDebugMode) {
          print("mail send failed : $e");
        }
        throw Exception("Send failed");
      }
    }
    return true;
  }

  static Future<List<EmailModel>> cacheLoad(String path) async {
    if (Res.mock) {
      return emailListMock;
    }
    hiveInit(path: path);
    if (await CacheService.exist<EmailModelWrapper>()) {
      return (await CacheService.get<EmailModelWrapper>())!.emailModels;
    } else {
      return [];
    }
  }

  static const List<String> mockAddresses = [
    "mockaddress1@univ-lyon1.fr",
    "mockaddress2@univ-lyon1.fr",
    "mockaddress3@univ-lyon1.fr",
    "mockaddress4@univ-lyon1.fr",
    "mockaddress5@univ-lyon1.fr",
  ];

  static final List<EmailModel> emailListMock = [
    EmailModel(
        subject: "subjectMock1",
        sender: "senderMock1",
        excerpt: "excerptMock1",
        isRead: false,
        date: DateTime(2022, 9, 1, 8),
        body: "bodyMock1",
        id: 1,
        receiver: "receiverMock1",
        attachments: ["attachmentMock1", "attachmentMock2"],
        isFlagged: false),
    EmailModel(
        subject: "subjectMock2",
        sender: "senderMock2",
        excerpt: "excerptMock2",
        isRead: true,
        date: DateTime(2022, 9, 1, 9),
        body: "bodyMock2",
        id: 2,
        receiver: "receiverMock2",
        attachments: ["attachmentMock1", "attachmentMock2"],
        isFlagged: true),
    EmailModel(
        subject: "subjectMock3",
        sender: "senderMock3",
        excerpt: "excerptMock3",
        isRead: false,
        date: DateTime(2022, 9, 1, 10),
        body: "bodyMock3",
        id: 3,
        receiver: "receiverMock3",
        attachments: ["attachmentMock1", "attachmentMock2"],
        isFlagged: false),
    EmailModel(
        subject: "subjectMock4",
        sender: "senderMock4",
        excerpt: "excerptMock4",
        isRead: true,
        date: DateTime(2022, 9, 1, 11),
        body: "bodyMock4",
        id: 4,
        receiver: "receiverMock4",
        attachments: ["attachmentMock1", "attachmentMock2"],
        isFlagged: true),
    EmailModel(
        subject: "subjectMock5",
        sender: "senderMock5",
        excerpt: "excerptMock5",
        isRead: false,
        date: DateTime(2022, 9, 1, 12),
        body: "bodyMock5",
        id: 5,
        receiver: "receiverMock5",
        attachments: ["attachmentMock1", "attachmentMock2"],
        isFlagged: false),
  ];
}
