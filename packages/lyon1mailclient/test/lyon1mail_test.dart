import 'package:dotenv/dotenv.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:test/test.dart';

void main() {
  late Lyon1MailClient mailClient;
  DotEnv env = DotEnv(includePlatformEnvironment: true);
  late MailBox inbox;

  Future<void> sendDummyMail(final String recipientEmail) async {
    await mailClient.addAction(
        Action(
          type: ActionType.send,
          mail: Mail.forSending(
            receiver: recipientEmail,
            subject: 'test',
            body: 'bodytest',
          ),
        ),
        autoDoAction: false);
    await mailClient.doActions();
  }

  late String username;
  late String password;
  late String emailAddress;
  setUpAll(() async {
    env.load();

    username = env['USERNAME'] ?? "";
    password = env['PASSWORD'] ?? "";
    emailAddress = env['EMAIL'] ?? "";

    if (username.isEmpty || password.isEmpty) {
      fail("username or password were empty. check your envt variables");
    }
    mailClient = Lyon1MailClient(username, password);
    mailClient.cleanActions();
    await mailClient.login();
    inbox = (await mailClient.getMailboxes()).firstWhere(
        (element) => element.specialMailBox == SpecialMailBox.inbox);
    await mailClient.logout();
  });

  test('login then logout', () async {
    await mailClient.login();
    await mailClient.logout();
  });

  test('fetchMessages 10 emails while being logged in', () async {
    await mailClient.login();
    final List<Mail> mails = (await mailClient.fetchMessages(10)) ?? [];
    expect(mails.length, equals(10));
    await mailClient.logout();
  });

  test('get mailboxes', () async {
    await mailClient.login();
    final List<MailBox> mailboxes = await mailClient.getMailboxes();
    expect(mailboxes.length, greaterThan(0));
    await mailClient.logout();
  });

  test('get sent email', () async {
    await mailClient.login();
    final List<MailBox> mailboxes = await mailClient.getMailboxes();
    final MailBox sentMailbox = mailboxes
        .firstWhere((mailbox) => mailbox.specialMailBox == SpecialMailBox.sent);
    final List<Mail> mails =
        (await mailClient.fetchMessages(10, mailboxName: sentMailbox.name)) ??
            [];
    expect(mails.length, greaterThan(0));
  });

  test('fetch 10 messages without being logged in', () async {
    await mailClient.logout();
    expect((await mailClient.fetchMessages(10)) == null, equals(true));
  });

  test('toggle read status of latest email', () async {
    await mailClient.login();
    final List<Mail> mails = (await mailClient.fetchMessages(10)) ?? [];

    final bool isFirstMailSeen = mails.first.isRead;

    if (mails.first.isRead) {
      await mailClient.addAction(
          Action(
              type: ActionType.markAsUnread,
              mail: mails.first,
              fromMailBox: inbox),
          autoDoAction: false);
    } else {
      await mailClient.addAction(
          Action(
              type: ActionType.markAsRead,
              mail: mails.first,
              fromMailBox: inbox),
          autoDoAction: false);
    }
    await mailClient.doActions();
    expect(((await mailClient.fetchMessages(10)) ?? []).first.isRead,
        !isFirstMailSeen);
    expect(await mailClient.getActions(), []);

    if (mails.first.isRead) {
      await mailClient.addAction(
          Action(
              type: ActionType.markAsRead,
              mail: mails.first,
              fromMailBox: inbox),
          autoDoAction: false);
    } else {
      await mailClient.addAction(
          Action(
              type: ActionType.markAsUnread,
              mail: mails.first,
              fromMailBox: inbox),
          autoDoAction: false);
    }
    await mailClient.doActions();
    expect(await mailClient.getActions(), []);
    await mailClient.logout();
  });

  test('toggle flag status of latest email', () async {
    await mailClient.login();
    final List<Mail> mails = (await mailClient.fetchMessages(10)) ?? [];

    final bool isFirstMailFlaged = mails.first.isFlagged;

    if (isFirstMailFlaged) {
      await mailClient.addAction(
          Action(
              type: ActionType.unflag, mail: mails.first, fromMailBox: inbox),
          autoDoAction: false);
    } else {
      await mailClient.addAction(
          Action(type: ActionType.flag, mail: mails.first, fromMailBox: inbox),
          autoDoAction: false);
    }
    await mailClient.doActions();

    expect(((await mailClient.fetchMessages(10)) ?? []).first.isFlagged,
        !isFirstMailFlaged);
    expect(await mailClient.getActions(), []);

    if (isFirstMailFlaged) {
      await mailClient.addAction(
          Action(type: ActionType.flag, mail: mails.first, fromMailBox: inbox),
          autoDoAction: false);
    } else {
      await mailClient.addAction(
          Action(
              type: ActionType.unflag, mail: mails.first, fromMailBox: inbox),
          autoDoAction: false);
    }
    await mailClient.doActions();
    expect(await mailClient.getActions(), []);
    await mailClient.logout();
  });

  test('send one email to self', () async {
    await mailClient.login();
    await sendDummyMail(emailAddress);
    expect(await mailClient.getActions(), []);

    await mailClient.login();
    final List<Mail> mailsBeforeDeletion =
        (await mailClient.fetchMessages(1)) ?? [];
    expect(mailsBeforeDeletion.isNotEmpty, true);

    final int latestMessageId = mailsBeforeDeletion.first.id!;
    await mailClient.addAction(
        Action(
            type: ActionType.delete,
            mail: mailsBeforeDeletion.first,
            fromMailBox: inbox),
        autoDoAction: false);
    await mailClient.doActions();
    expect(await mailClient.getActions(), []);

    final List<Mail> mailsAfterDeletion =
        (await mailClient.fetchMessages(1)) ?? [];
    expect(mailsAfterDeletion.isNotEmpty, true);
    expect(mailsAfterDeletion.first.id != latestMessageId, true);
    await mailClient.logout();
  });

  test('send one email to another person', () async {
    await mailClient.login();
    await sendDummyMail(env['OTHER_EMAIL']!);
    await mailClient.logout();
  });

  test('reply one email to self', () async {
    await mailClient.login();
    await sendDummyMail(emailAddress);
    expect(await mailClient.getActions(), []);

    await mailClient.login();
    final List<Mail> mailsBeforeDeletion =
        (await mailClient.fetchMessages(1)) ?? [];
    expect(mailsBeforeDeletion.isNotEmpty, true);

    await mailClient.addAction(
        Action(
            type: ActionType.reply,
            originalMessageId: mailsBeforeDeletion.first.id!,
            mail: Mail.forReplying(
                body: "response body", mail: mailsBeforeDeletion.first),
            replyAll: false,
            fromMailBox: inbox),
        autoDoAction: false);
    await mailClient.doActions();
    expect(await mailClient.getActions(), []);

    final int latestMessageId = mailsBeforeDeletion.first.id!;
    await mailClient.addAction(
        Action(
            type: ActionType.delete,
            mail: mailsBeforeDeletion.first,
            fromMailBox: inbox),
        autoDoAction: false);
    await mailClient.doActions();
    expect(await mailClient.getActions(), []);

    final List<Mail> mailsAfterDeletion =
        (await mailClient.fetchMessages(1)) ?? [];
    expect(mailsAfterDeletion.isNotEmpty, true);
    expect(mailsAfterDeletion.first.id == latestMessageId, true);
    expect(
        mailsAfterDeletion.first.body.contains("bodytest"),
        //bodytest is what was writter in the first sent mail
        true);
    await mailClient.logout();
  });

  test('forward one email to self', () async {
    await mailClient.login();
    await sendDummyMail(emailAddress);
    expect(await mailClient.getActions(), []);

    await mailClient.login();
    final List<Mail> mailsBeforeDeletion =
        (await mailClient.fetchMessages(1)) ?? [];
    expect(mailsBeforeDeletion.isNotEmpty, true);

    await mailClient.addAction(
        Action(
            type: ActionType.forward,
            mail: Mail.forForwarding(
              body: "transfer body",
              receiver: emailAddress,
              mail: mailsBeforeDeletion.first,
            ),
            originalMessageId: mailsBeforeDeletion.first.id!,
            fromMailBox: inbox),
        autoDoAction: false);
    await mailClient.doActions();
    expect(await mailClient.getActions(), []);

    final int latestMessageId = mailsBeforeDeletion.first.id!;
    await mailClient.addAction(
        Action(
            type: ActionType.delete,
            mail: mailsBeforeDeletion.first,
            fromMailBox: inbox),
        autoDoAction: false);
    await mailClient.doActions();
    expect(await mailClient.getActions(), []);

    final List<Mail> mailsAfterDeletion =
        (await mailClient.fetchMessages(1)) ?? [];
    expect(mailsAfterDeletion.isNotEmpty, true);
    expect(mailsAfterDeletion.first.id == latestMessageId, true);
    expect(
        mailsAfterDeletion.first.body.contains(mailsBeforeDeletion.first.body
            .substring(
                0, mailsBeforeDeletion.first.body.length - 1)), //remove \r
        true);
    await mailClient.logout();
  });

  test('resolve contact', () async {
    await mailClient.login();
    Address? email = (await mailClient.resolveContact(username)).first;
    expect(email.email, emailAddress);
    await mailClient.logout();
  });

  test('delete latest email', () async {
    await mailClient.login();
    await sendDummyMail(
        emailAddress); // to make sure we dont delete important mails :)

    final List<Mail> mailsBeforeDeletion =
        (await mailClient.fetchMessages(1)) ?? [];
    expect(mailsBeforeDeletion.isNotEmpty, true);

    final int latestMessageId = mailsBeforeDeletion.first.id!;
    await mailClient.addAction(
        Action(
            type: ActionType.delete,
            mail: mailsBeforeDeletion.first,
            fromMailBox: inbox),
        autoDoAction: false);
    await mailClient.doActions();
    expect(await mailClient.getActions(), []);

    final List<Mail> mailsAfterDeletion =
        (await mailClient.fetchMessages(1)) ?? [];
    expect(mailsAfterDeletion.isNotEmpty, true);
    expect(mailsAfterDeletion.first.id != latestMessageId, true);
    await mailClient.logout();
  });
}
