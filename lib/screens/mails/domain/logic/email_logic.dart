import 'package:flutter/foundation.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/screens/mails/mails_export.dart';

class EmailLogic {
  static Future<Lyon1Mail> connect(
      {required String username, required String password}) async {
    Lyon1Mail mailClient = Lyon1Mail(username, password);
    if (!await mailClient.login()) {
      throw Exception("Login failed");
    }
    return mailClient;
  }

  static Future<List<EmailModel>> load(
      {required Lyon1Mail mailClient, required int emailNumber}) async {
    List<EmailModel> tmpEmailsComplete = [];
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        throw Exception("Login failed");
      }
    }
    final List<Mail>? emailOpt =
        await mailClient.fetchMessages(emailNumber);
    if (emailOpt == null || emailOpt.isEmpty) {
      if (kDebugMode) {
        print("no emails");
      }
    } else {
      for (final Mail mail in emailOpt) {
        if (!tmpEmailsComplete.any((element) =>
            element.date == mail.getDate() &&
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
      int? replyOriginalMessageId,
      bool? replyAll,
      required int emailNumber,
      required List<EmailModel> emailsComplete}) async {
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        throw Exception("Login failed");
      }
    }
    if (replyOriginalMessageId != null) {
      try {
        await mailClient.fetchMessages(emailNumber);
        await mailClient.reply(
          originalMessageId: replyOriginalMessageId,
          subject: email.subject,
          body: email.body,
          replyAll: replyAll ?? false,
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
        );
      } catch (e) {
        throw Exception("Send failed");
      }
    }
    return true;
  }
}
