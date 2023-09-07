import 'dart:io';

import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:path_provider/path_provider.dart';

class AttachmentLogic {
  static Future<File> getAttachmentLocalPath(
      {required Mail email,
      required Lyon1MailClient mailClient,
      required int emailNumber,
      required String fileName,
      required MailBox folder}) async {
    if (email.rawMail == null) {
      List<Mail> mails = (await MailLogic.load(
              mailClient: mailClient,
              emailNumber: emailNumber,
              blockTrackers: false,
              mailBox: folder))
          .emails;
      email = mails.firstWhere((element) => element.id == email.id);
    }
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    if (await file.exists()) {
      return file;
    } else {
      List<int> attachment = email.getAttachment(fileName);
      await file.writeAsBytes(attachment);
      return file;
    }
  }
}
