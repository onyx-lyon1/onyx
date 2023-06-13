import 'package:flutter/foundation.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/extensions/mail_box_extension.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/core/res.dart';

class MailLogic {
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

  static Future<MailBox> load(
      {required Lyon1Mail mailClient,
      required int emailNumber,
      required bool blockTrackers,
      MailBox? mailBox}) async {
    if (Res.mock) {
      return mailboxesMock.first;
    }

    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        throw Exception("Login failed");
      }
    }
    final List<Mail>? emailOpt = await mailClient.fetchMessages(
      emailNumber,
      mailboxName: mailBox?.name,
      mailboxFlags: mailBox?.specialMailBox?.toMailBoxTag(),
      removeTrackingImages: blockTrackers,
    );
    mailBox ??= MailBox(
        name: "Boite de réception",
        specialMailBox: SpecialMailBox.inbox,
        emails: const []);
    if (emailOpt == null || emailOpt.isEmpty) {
      if (kDebugMode) {
        print("no Mails");
      }
    } else {
      mailBox = mailBox.copyWith(emails: emailOpt);
    }
    return mailBox;
  }

  static Future<List<MailBox>> cacheLoad(String path) async {
    if (Res.mock) {
      return mailboxesMock;
    }
    hiveInit(path: path);
    if (await CacheService.exist<MailBoxList>()) {
      return (await CacheService.get<MailBoxList>())!.mailBoxes;
    } else {
      return [];
    }
  }

  static List<MailBox> mailboxesMock = [
    MailBox(name: "INBOX", emails: emailListMock),
    MailBox(name: "SENT", emails: emailListMock),
    MailBox(name: "DRAFT", emails: emailListMock),
    MailBox(name: "TRASH", emails: emailListMock),
    MailBox(name: "SPAM", emails: emailListMock),
    MailBox(name: "ARCHIVE", emails: emailListMock),
  ];

  static const List<String> mockAddresses = [
    "mockaddress1@univ-lyon1.fr",
    "mockaddress2@univ-lyon1.fr",
    "mockaddress3@univ-lyon1.fr",
    "mockaddress4@univ-lyon1.fr",
    "mockaddress5@univ-lyon1.fr",
  ];

  static final List<Mail> emailListMock = [
    Mail(
        subject: "subjectMock1",
        sender: "senderMock1",
        excerpt: "excerptMock1",
        isRead: false,
        date: DateTime(2022, 9, 1, 8),
        body: "bodyMock1",
        blackBody: "blackBodyMock1",
        id: 1,
        receiver: "receiverMock1",
        attachments: const [
          "attachmentMock1",
          "attachmentMock2"
        ],
        isFlagged: false),
    Mail(
        subject: "subjectMock2",
        sender: "senderMock2",
        excerpt: "excerptMock2",
        isRead: true,
        date: DateTime(2022, 9, 1, 9),
        body: "bodyMock2",
        blackBody: "blackBodyMock2",
        id: 2,
        receiver: "receiverMock2",
        attachments: const [
          "attachmentMock1",
          "attachmentMock2"
        ],
        isFlagged: true),
    Mail(
        subject: "subjectMock3",
        sender: "senderMock3",
        excerpt: "excerptMock3",
        isRead: false,
        date: DateTime(2022, 9, 1, 10),
        body: "bodyMock3",
        blackBody: "blackBodyMock3",
        id: 3,
        receiver: "receiverMock3",
        attachments: const [
          "attachmentMock1",
          "attachmentMock2"
        ],
        isFlagged: false),
    Mail(
        subject: "subjectMock4",
        sender: "senderMock4",
        excerpt: "excerptMock4",
        isRead: true,
        date: DateTime(2022, 9, 1, 11),
        body: "bodyMock4",
        blackBody: "blackBodyMock4",
        id: 4,
        receiver: "receiverMock4",
        attachments: const [
          "attachmentMock1",
          "attachmentMock2"
        ],
        isFlagged: true),
    Mail(
        subject: "subjectMock5",
        sender: "senderMock5",
        excerpt: "excerptMock5",
        isRead: false,
        date: DateTime(2022, 9, 1, 12),
        body: "bodyMock5",
        blackBody: "blackBodyMock5",
        id: 5,
        receiver: "receiverMock5",
        attachments: const [
          "attachmentMock1",
          "attachmentMock2"
        ],
        isFlagged: false),
  ];
}
