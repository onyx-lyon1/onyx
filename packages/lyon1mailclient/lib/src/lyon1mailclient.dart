// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:io';

import 'package:enough_mail/enough_mail.dart';
import 'package:hive/hive.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:requests_plus/requests_plus.dart';
import 'package:collection/collection.dart';

import 'config/config.dart';

class Lyon1MailClient {
  late ImapClient _client;
  late SmtpClient _smtpClient;
  late String _username;
  late String _password;
  late String _corsProxyUrl;
  late Address emailAddress;

  Lyon1MailClient(final String username, final String password,
      {String corsProxyUrl = ""}) {
    _client = ImapClient(isLogEnabled: false);
    _smtpClient = SmtpClient("univ-lyon1.fr");
    _username = username;
    _password = password;
    if (!corsProxyUrl.endsWith("/") && corsProxyUrl.isNotEmpty) {
      throw Exception("proxyUrl must end with /");
    }
    _corsProxyUrl = corsProxyUrl;
  }

  static void registerAdapters({bool initHive = true}) {
    Hive.registerAdapter(ActionAdapter());
    Hive.registerAdapter(ActionListAdapter());
    Hive.registerAdapter(ActionTypeAdapter());
    Hive.registerAdapter(MailAdapter());
    Hive.registerAdapter(MailBoxAdapter());
    Hive.registerAdapter(MailBoxListAdapter());
    Hive.registerAdapter(SpecialMailBoxAdapter());
    if (initHive) Hive.init(Directory.current.path);
  }

  Future<bool> login() async {
    await _client.connectToServer(
        Lyon1MailClientConfig.imapHost, Lyon1MailClientConfig.imapPort,
        isSecure: Lyon1MailClientConfig.imapSecure);
    await _client.login(_username, _password);

    // smtp client
    await _smtpClient.connectToServer(
        Lyon1MailClientConfig.smtpHost, Lyon1MailClientConfig.smtpPort,
        isSecure: Lyon1MailClientConfig.smtpSecure);

    await _smtpClient.ehlo();
    await _smtpClient.startTls();
    await _smtpClient.authenticate(_username, _password, AuthMechanism.login);

    await RequestsPlus.post(
      Lyon1MailClientConfig.loginUrl,
      corsProxyUrl: _corsProxyUrl,
      headers: makeHeader(
        referer:
            'https://mail.univ-lyon1.fr/owa/auth/logon.aspx?replaceCurrent=1&url=https%3a%2f%2fmail.univ-lyon1.fr%2fowa',
        accept:
            'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
        connection: 'keep-alive',
        contentType: 'application/x-www-form-urlencoded',
      ),
      body: {
        "destination": Lyon1MailClientConfig.baseWebUrl
            .substring(0, Lyon1MailClientConfig.baseWebUrl.length - 1),
        // remove trailing slash
        "flags": "4",
        "forcedownlevel": "0",
        "username": _username,
        "password": _password,
        "passwordText": "",
        "isUtf8": "1"
      },
    );
    await RequestsPlus.get(
      "https://mail.univ-lyon1.fr/owa/",
      corsProxyUrl: _corsProxyUrl,
    ); //get canary cookies
    emailAddress = (await resolveContact(_username)).first;
    return _client.isLoggedIn;
  }

  Future<List<MailBox>> getMailboxes() async {
    List<Mailbox> mailboxes = await _client.listMailboxes();
    //remove all mailboxes that are not an email folder
    mailboxes.removeWhere(
        (element) => !element.flags.contains(MailboxFlag.hasNoChildren));
    List<MailBox> mailBoxList =
        mailboxes.map((e) => MailBox.fromMailLib(e)).toList();
    if (mailBoxList.indexWhere((element) => element.name == "Boîte d'envoi") ==
        -1) {
      mailBoxList.add(MailBox(name: "Boîte d'envoi", emails: const []));
    }
    return mailBoxList;
  }

  Future<List<Mailbox>> getRawMailboxes() async {
    List<Mailbox> mailboxes = await _client.listMailboxes();
    //remove all mailboxes that are not an email folder
    mailboxes.removeWhere(
        (element) => !element.flags.contains(MailboxFlag.hasNoChildren));
    return mailboxes;
  }

  Future<List<Mail>?> fetchMessages(
    int end, {
    int? start,
    bool unreadOnly = false,
    bool hasAttachmentOnly = false,
    String? mailboxName,
    MailboxFlag? mailboxFlags,
    bool removeTrackingImages = false,
  }) async {
    if (!_client.isLoggedIn) {
      return null;
    }

    Mailbox mailbox;
    if (mailboxFlags != null) {
      List<Mailbox> mailboxes = await _client.listMailboxes();
      mailbox = mailboxes
          .firstWhere((element) => element.flags.contains(mailboxFlags));
    } else if (mailboxName == null) {
      mailbox = await _client.selectInbox();
    } else {
      List<Mailbox> mailboxes = await _client.listMailboxes();
      mailbox = mailboxes.firstWhere((element) => element.name == mailboxName);
    }
    await _client.selectMailbox(mailbox);
    if (mailbox.messagesExists <= 0) {
      return [];
    }

    if (mailbox.messagesExists - end + 1 <= 0) {
      end = mailbox.messagesExists;
      // throw "Wrong number of message to fetch";
    }

    if (start != null) {
      if (start < 0 || start > mailbox.messagesExists - end + 1) {
        start = 0;
        //throw "Wrong number of message to fetch";
      }
    }

    final MessageSequence fetchSequence = MessageSequence();
    fetchSequence.addRange(mailbox.messagesExists - (start ?? 0),
        mailbox.messagesExists - end + 1);

    final SearchImapResult? unseenSearch = !unreadOnly
        ? null
        : await _client.searchMessages(searchCriteria: 'UNSEEN');

    final List<Mail> mails = [];
    final fetchResult = await _client.fetchMessages(
        unseenSearch?.matchingSequence ?? fetchSequence,
        '(FLAGS INTERNALDATE RFC822.SIZE ENVELOPE BODY.PEEK[])');
    for (final MimeMessage email in fetchResult.messages) {
      mails
          .add(Mail.fromRaw(email, removeTrackingImages: removeTrackingImages));
    }
    if (mailbox.name.contains("Boîte d'envoi")) {
      Box<ActionList> actionsBox = await Hive.openBox<ActionList>("cached_0");
      ActionList actionList =
          actionsBox.get("cache0") ?? ActionList(action: []);
      for (Action action in actionList.action) {
        switch (action.type) {
          case ActionType.send:
          case ActionType.forward:
          case ActionType.reply:
            mails.add(Mail.fromRaw(await _buildSendEmail(
                recipients: [Address(action.mail.receiver, "")],
                subject: action.mail.subject,
                body: action.mail.body,
                attachments: action.mail.attachmentsFiles)));
            break;
          default:
            break;
        }
      }
    }

    return mails.reversed
        .where((mail) => mail.attachments.isNotEmpty || !hasAttachmentOnly)
        .toList();
  }

  Future<bool> _sendEmail({
    required List<Address> recipients,
    required String subject,
    required String body,
    List<File>? attachments,
    bool appendToSent = true,
  }) async {
    MimeMessage message = await _buildSendEmail(
      recipients: recipients,
      subject: subject,
      body: body,
      attachments: attachments,
    );
    final SmtpResponse response = await _smtpClient.sendMessage(
      message,
      recipients: recipients.map((e) => MailAddress(e.name, e.email)).toList(),
    );

    if (appendToSent) {
      final sentMailBox = (await getRawMailboxes()).firstWhereOrNull(
          (element) => element.flags.contains(MailboxFlag.sent));
      print(sentMailBox);
      if (sentMailBox != null) {
        // await _client.selectMailbox(sentMailBox);
        await _client.appendMessage(
          message,
          targetMailboxPath: sentMailBox.path,
          flags: [MessageFlags.seen],
        );
      }
    }

    return response.isOkStatus;
  }

  Future<MimeMessage> _buildSendEmail({
    required List<Address> recipients,
    required String subject,
    required String body,
    List<File>? attachments,
  }) async {
    final MessageBuilder messageBuilder =
        MessageBuilder.prepareMultipartAlternativeMessage()
          ..subject = subject
          ..from = [MailAddress(emailAddress.name, emailAddress.email)]
          ..to = recipients.map((e) => MailAddress(e.name, e.email)).toList();
    messageBuilder.addTextHtml(body);
    for (final File attachment in attachments ?? []) {
      await messageBuilder.addFile(
        attachment,
        MediaType.guessFromFileName(attachment.path.split("/").last),
      );
    }
    return messageBuilder.buildMimeMessage();
  }

  Future<MimeMessage> _buildReply({
    bool replyAll = false,
    required int originalMessageId,
    required String body,
    List<File>? attachments,
  }) async {
    final MimeMessage originalMessage = (await _client.fetchMessage(
            originalMessageId,
            '(FLAGS INTERNALDATE RFC822.SIZE ENVELOPE BODY.PEEK[])'))
        .messages
        .first;
    final MessageBuilder messageBuilder = MessageBuilder.prepareReplyToMessage(
      originalMessage,
      MailAddress(emailAddress.name, emailAddress.email),
      replyAll: replyAll,
      quoteOriginalText: true,
      replyToSimplifyReferences: true,
    );
    final textPlain = messageBuilder.getTextPlainPart()!;
    textPlain.text = '$body\r\n${textPlain.text}';
    if (messageBuilder.getTextHtmlPart() != null) {
      final textHtml = messageBuilder.getTextHtmlPart()!;
      textHtml.text = '<p>$body</p>\r\n${textHtml.text}';
    }

    for (final File attachment in attachments ?? []) {
      await messageBuilder.addFile(
        attachment,
        MediaType.guessFromFileName(attachment.path.split("/").last),
      );
    }
    return messageBuilder.buildMimeMessage();
  }

  Future<bool> _reply({
    bool replyAll = false,
    required int originalMessageId,
    required String body,
    List<File>? attachments,
  }) async {
    final SmtpResponse response = await _smtpClient.sendMessage(
      (await _buildReply(
        replyAll: replyAll,
        originalMessageId: originalMessageId,
        body: body,
        attachments: attachments,
      )),
    );

    return response.isOkStatus;
  }

  Future<MimeMessage> _buildForward({
    required int originalMessageId,
    required String? body,
    required List<Address> recipients,
    List<File>? attachments,
  }) async {
    final MimeMessage originalMessage = (await _client.fetchMessage(
            originalMessageId,
            '(FLAGS INTERNALDATE RFC822.SIZE ENVELOPE BODY.PEEK[])'))
        .messages
        .first;
    final MessageBuilder messageBuilder = MessageBuilder.prepareForwardMessage(
      originalMessage,
      from: MailAddress(emailAddress.name, emailAddress.email),
      quoteMessage: true,
      forwardAttachments: true,
    );
    if (body != null) {
      final textPlain = messageBuilder.getTextPlainPart()!;
      textPlain.text = '$body\r\n${textPlain.text}';
      if (messageBuilder.getTextHtmlPart() != null) {
        final textHtml = messageBuilder.getTextHtmlPart()!;
        textHtml.text = '<p>$body</p>\r\n${textHtml.text}';
      }
    }

    messageBuilder.to =
        recipients.map((e) => MailAddress(e.name, e.email)).toList();

    for (final File attachment in attachments ?? []) {
      await messageBuilder.addFile(
        attachment,
        MediaType.guessFromFileName(attachment.path.split("/").last),
      );
    }
    return messageBuilder.buildMimeMessage();
  }

  Future<bool> _forward({
    required int originalMessageId,
    required String? body,
    required List<Address> recipients,
    List<File>? attachments,
  }) async {
    final SmtpResponse response = await _smtpClient.sendMessage(
      (await _buildForward(
        originalMessageId: originalMessageId,
        body: body,
        recipients: recipients,
        attachments: attachments,
      )),
    );
    return response.isOkStatus;
  }

  Future<MessageSequence> _idToSequence(final int id) async {
    if (!_client.isLoggedIn) {
      throw "Not logged in";
    }
    final MessageSequence sequence = MessageSequence();
    sequence.add(id);
    return sequence;
  }

  Future<List<Address>> resolveContact(String query) async {
    Iterable<Cookie> cookies =
        (await RequestsPlus.getStoredCookies(Lyon1MailClientConfig.baseWebUrl))
            .values;
    final response = await RequestsPlus.post(
      Lyon1MailClientConfig.contactUrl,
      corsProxyUrl: _corsProxyUrl,
      headers: makeHeader(
        canary: cookies.firstWhere((element) {
          return element.name == "X-OWA-CANARY";
        }).value,
        action: 'FindPeople',
      ),
      body: makeQuerry(query),
      bodyEncoding: RequestBodyEncoding.JSON,
    );
    if (response.json()['Body']['ResponseClass'] == "Success") {
      List<Address> addresses = [];
      for (var item in response.json()['Body']['ResultSet']) {
        addresses.add(Address(
          (item['EmailAddress'] ?? {})['EmailAddress'] ?? "",
          (item['GivenName'] ?? "") + " " + (item['Surname'] ?? ""),
        ));
      }
      return addresses;
    }
    return [];
  }

  Future<void> _delete(final int id) async {
    final MessageSequence sequence = await _idToSequence(id);
    _client.markDeleted(sequence);
    _client.expunge();
  }

  Future<void> _markAsRead(final int id) async {
    final MessageSequence sequence = await _idToSequence(id);
    _client.markSeen(sequence);
  }

  Future<void> _markAsUnread(final int id) async {
    final MessageSequence sequence = await _idToSequence(id);
    _client.markUnseen(sequence);
  }

  Future<void> _markAsFlagged(final int id) async {
    final MessageSequence sequence = await _idToSequence(id);
    _client.markFlagged(sequence);
  }

  Future<void> _unMarkAsFlagged(final int id) async {
    final MessageSequence sequence = await _idToSequence(id);
    _client.markUnflagged(sequence);
  }

  Future<void> logout() async {
    await _client.logout();
    await _smtpClient.disconnect();
    await RequestsPlus.get(
      Lyon1MailClientConfig.logoutUrl,
      corsProxyUrl: _corsProxyUrl,
      headers: makeHeader(),
    );
  }

  Future<void> _move(
      {required int id, required MailBox from, required MailBox to}) async {
    final MessageSequence sequence = await _idToSequence(id);
    await _client.selectMailbox((await from.toMailLib(this))!);
    await _client.move(sequence, targetMailbox: (await to.toMailLib(this))!);
  }

  Future<void> _createFolder(String name) async {
    await _client.createMailbox(name);
  }

  Future<void> addAction(Action action, {bool autoDoAction = true}) async {
    Box<ActionList> box = await Hive.openBox<ActionList>("cached_0");
    ActionList wrapper = box.get("cache0") ?? ActionList(action: []);
    if (!wrapper.action.contains(action)) {
      wrapper.action.add(action);
      await box.put("cache0", wrapper);
      if (autoDoAction) {
        await doActions();
      }
    }
  }

  Future<void> removeAction(Action action) async {
    Box<ActionList> box = await Hive.openBox<ActionList>("cached_0");
    ActionList wrapper = box.get("cache0") ?? ActionList(action: []);
    while (wrapper.action.contains(action)) {
      wrapper.action.remove(action);
    }
    await box.put("cache0", wrapper);
  }

  Future<void> cleanActions() async {
    await Hive.deleteBoxFromDisk("cached_0");
  }

  Future<List<Action>> getActions() async {
    Box<ActionList> box = await Hive.openBox<ActionList>("cached_0");
    return List.from(box.get("cache0")?.action ?? []);
  }

  Future<void> doActions() async {
    final List<Action> actions = await getActions();
    if (actions.isEmpty) return;
    for (Action action in actions) {
      if (action.fromMailBox != null) {
        await _client
            .selectMailbox((await action.fromMailBox!.toMailLib(this))!);
        await fetchMessages(1);
      }
      try {
        switch (action.type) {
          case ActionType.archive:
            List<MailBox> mailboxes = await getMailboxes();
            int mailboxIndex = mailboxes.indexWhere(
                (element) => element.name.toLowerCase().contains("archive"));
            if (mailboxIndex == -1) {
              _createFolder("Archive");
              mailboxes = await getMailboxes();
              mailboxIndex = mailboxes.indexWhere(
                  (element) => element.name.toLowerCase().contains("archive"));
            }
            _move(
                id: action.mail.id!,
                from: action.fromMailBox!,
                to: mailboxes[mailboxIndex]);
            break;
          case ActionType.move:
            _move(
                id: action.mail.id!,
                from: action.fromMailBox!,
                to: action.destinationMailBox!);
            break;
          case ActionType.markAsUnread:
            _markAsUnread(action.mail.id!);
            break;
          case ActionType.markAsRead:
            _markAsRead(action.mail.id!);
            break;
          case ActionType.send:
            _sendEmail(
                recipients: [Address(action.mail.receiver, "")],
                subject: action.mail.subject,
                body: action.mail.body,
                attachments: action.mail.attachmentsFiles);
            break;
          case ActionType.reply:
            _reply(
                originalMessageId: action.originalMessageId!,
                body: action.mail.body,
                replyAll: action.replyAll!,
                attachments: action.mail.attachmentsFiles);
            break;
          case ActionType.forward:
            _forward(
                originalMessageId: action.originalMessageId!,
                body: action.mail.body,
                recipients: [Address(action.mail.receiver, "")]);
            break;
          case ActionType.delete:
            _delete(action.mail.id!);
            break;
          case ActionType.flag:
            _markAsFlagged(action.mail.id!);
            break;
          case ActionType.unflag:
            _unMarkAsFlagged(action.mail.id!);
            break;
        }
        removeAction(action);
      } catch (e) {
        print(e);
      }
    }
  }

  bool get isAuthenticated => _client.isLoggedIn;
}
