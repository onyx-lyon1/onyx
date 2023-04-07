import 'dart:io';

import 'package:enough_mail/enough_mail.dart';
import 'package:flutter/foundation.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/extensions/mail_box_extension.dart';
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

  static Future<MailBoxModel> load(
      {required Lyon1Mail mailClient,
      required int emailNumber,
      required bool blockTrackers,
      MailBoxModel? mailBox}) async {
    if (Res.mock) {
      return mailboxesMock.first;
    }

    List<EmailModel> tmpEmailsComplete = [];
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        throw Exception("Login failed");
      }
    }
    final List<Mail>? emailOpt = await mailClient.fetchMessages(emailNumber,
        mailboxName: mailBox?.name,
        mailboxFlags: mailBox?.specialMailBox?.toMailBoxTag());
    mailBox ??= MailBoxModel(
        name: "Boite de réception",
        specialMailBox: SpecialMailBox.inbox,
        emails: []);
    if (emailOpt == null || emailOpt.isEmpty) {
      if (kDebugMode) {
        print("no emails");
      }
    } else {
      for (final Mail mail in emailOpt) {
        // if (!tmpEmailsComplete.any((element) =>
        //    element.date == mail.getDate &&
        //   element.body == mail.getBody(excerpt: false))) {
        tmpEmailsComplete
            .add(await compute(EmailModel.fromMailLib, [mail, blockTrackers]));
        //}
      }
      mailBox.emails = tmpEmailsComplete;
    }

    return mailBox;
  }

  static Future<void> archiveEmail(
      {required Lyon1Mail mailClient,
      required EmailModel email,
      required MailBoxModel from}) async {
    if (Res.mock) {
      return;
    }
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        throw Exception("Login failed");
      }
    }
    List<Mailbox> mailboxes = await mailClient.getMailboxes();
    int fromMailboxIndex =
        mailboxes.indexWhere((element) => element.name == from.name);
    int mailboxIndex = mailboxes.indexWhere(
        (element) => element.name.toLowerCase().contains("archive"));
    if (mailboxIndex == -1) {
      mailClient.createFolder("Archive");
      mailboxes = await mailClient.getMailboxes();
      mailboxIndex = mailboxes.indexWhere(
          (element) => element.name.toLowerCase().contains("archive"));
    }
    await mailClient.move(
        id: email.id!,
        to: mailboxes[mailboxIndex],
        from: mailboxes[fromMailboxIndex]);
  }

  static Future<void> moveEmail(
      {required Lyon1Mail mailClient,
      required EmailModel email,
      required MailBoxModel destinationMailbox,
      required MailBoxModel from}) async {
    if (Res.mock) {
      return;
    }
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        throw Exception("Login failed");
      }
    }
    List<Mailbox> mailboxes = await mailClient.getMailboxes();
    int destinationMailboxIndex = mailboxes
        .indexWhere((element) => element.name == destinationMailbox.name);
    int fromMailboxIndex =
        mailboxes.indexWhere((element) => element.name == from.name);
    await mailClient.move(
        id: email.id!,
        to: mailboxes[destinationMailboxIndex],
        from: mailboxes[fromMailboxIndex]);
  }

  static Future<List<MailBoxModel>> getMailboxes(
      {required Lyon1Mail mailClient}) async {
    if (Res.mock) {
      return mailboxesMock;
    }
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        throw Exception("Login failed");
      }
    }
    return (await mailClient.getMailboxes())
        .map((e) => MailBoxModel.fromMailLib(e))
        .toList();
  }

  static Future<bool> send({
    required Lyon1Mail mailClient,
    required EmailModel email,
    int? originalMessageId,
    bool? replyAll,
    bool forward = false,
    bool reply = false,
    int? emailNumber,
    MailBoxModel? from,
  }) async {
    assert((reply || forward) ==
        (originalMessageId != null &&
            emailNumber !=
                null)); //assert that we are replying or forwarding if we have the original message id and the email number
    if (Res.mock) {
      return true;
    }
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        throw Exception("Login failed");
      }
    }
    if (reply || forward) {
      await mailClient.selectMailbox((await mailBoxToMailLib(
          mailClient: mailClient, mailBoxModel: from!))!);
    }
    if (reply) {
      try {
        await mailClient.fetchMessages(emailNumber!);
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
        await mailClient.fetchMessages(emailNumber!);
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

  static Future<List<MailBoxModel>> cacheLoad(String path) async {
    if (Res.mock) {
      return mailboxesMock;
    }
    hiveInit(path: path);
    if (await CacheService.exist<MailBoxWrapper>()) {
      return (await CacheService.get<MailBoxWrapper>())!.mailBoxes;
    } else {
      return [];
    }
  }

  static Future<void> addAction(ActionModel action) async {
    if (kDebugMode) {
      print("add action : $action");
    }
    ActionModelWrapper wrapper = await CacheService.get<ActionModelWrapper>() ??
        ActionModelWrapper(action: []);
    if (!wrapper.action.contains(action)) {
      wrapper.action.add(action);
      await CacheService.set<ActionModelWrapper>(wrapper);
    }
  }

  static Future<void> removeAction(ActionModel action) async {
    if (kDebugMode) {
      print("remove action : $action");
    }
    ActionModelWrapper wrapper = await CacheService.get<ActionModelWrapper>() ??
        ActionModelWrapper(action: []);
    while (wrapper.action.contains(action)) {
      wrapper.action.remove(action);
    }
    await CacheService.set<ActionModelWrapper>(wrapper);
  }

  static Future<Mailbox?> mailBoxToMailLib(
      {required Lyon1Mail mailClient,
      required MailBoxModel mailBoxModel}) async {
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        throw Exception("Login failed");
      }
    }
    List<Mailbox> mailboxes = await mailClient.getMailboxes();
    int index =
        mailboxes.indexWhere((element) => element.name == mailBoxModel.name);
    if (index == -1) {
      return null;
    }
    return mailboxes[index];
  }

  static List<MailBoxModel> mailboxesMock = [
    MailBoxModel(name: "INBOX", emails: emailListMock),
    MailBoxModel(name: "SENT", emails: emailListMock),
    MailBoxModel(name: "DRAFT", emails: emailListMock),
    MailBoxModel(name: "TRASH", emails: emailListMock),
    MailBoxModel(name: "SPAM", emails: emailListMock),
    MailBoxModel(name: "ARCHIVE", emails: emailListMock),
  ];

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
        blackBody: "blackBodyMock1",
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
        blackBody: "blackBodyMock2",
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
        blackBody: "blackBodyMock3",
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
        blackBody: "blackBodyMock4",
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
        blackBody: "blackBodyMock5",
        id: 5,
        receiver: "receiverMock5",
        attachments: ["attachmentMock1", "attachmentMock2"],
        isFlagged: false),
  ];
}
