// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/model/mail_model.dart';

class EmailBackend {
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
    final Option<List<Mail>> emailOpt =
        await mailClient.fetchMessages(emailNumber);
    if (emailOpt.isNone()) {
      if (kDebugMode) {
        print("no emails");
      }
    } else {
      for (final Mail mail in emailOpt.toIterable().first) {
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
        required List<EmailModel> emailsComplete
      }) async {
    if (!mailClient.isAuthenticated) {
      if (!await mailClient.login()) {
        throw Exception("Login failed");
      }
    }
    if (kDebugMode) {
      print(email);
      print("replyAll: $replyAll");
      print("replyOriginalMessageId: $replyOriginalMessageId");
    }
    if (replyOriginalMessageId != null) {
      try {
        await mailClient.fetchMessages(emailNumber);
        print("presend");
        print(
            "original message id: $replyOriginalMessageId, subject: ${email.subject}, body: ${email.body}, replyAll: ${replyAll ?? false}, sender: ${mailClient.emailAddress}");

        await mailClient.reply(
          originalMessageId: replyOriginalMessageId,
          subject: email.subject,
          body: emailsComplete
              .where((element) => element.id == replyOriginalMessageId)
              .first
              .body,
          replyAll: replyAll ?? false,
          sender: mailClient.emailAddress,
        );
      } catch (e) {
        throw Exception("Reply failed");
      }
    } else {
      try {
        List<Address> recipients = [];
        if (email.receiver.contains("@") &&
            email.receiver.contains(".")) {
          for (var i in email.receiver.split(",")) {
            recipients.add(Address(i, i));
          }
        } else {
          Address resolvedAddress = Address(email.receiver, "");
          recipients.add(resolvedAddress);
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
