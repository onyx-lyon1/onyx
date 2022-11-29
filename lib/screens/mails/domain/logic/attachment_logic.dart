import 'dart:io';

import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/screens/mails/mails_export.dart';
import 'package:path_provider/path_provider.dart';

class AttachmentLogic {
  static Future<String> getAttachmentLocalPath(
      {required EmailModel email,
      required Lyon1Mail mailClient,
      required int emailNumber,
      required String fileName}) async {
    if (email.rawMail == null) {
      List<EmailModel> mails = await EmailLogic.load(
          mailClient: mailClient, emailNumber: emailNumber);
      email = mails.firstWhere((element) => element.id == email.id);
    }
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    if (await file.exists()) {
      return file.path;
    } else {
      List<int> attachment = email.rawMail!.getAttachment(fileName);
      await file.writeAsBytes(attachment);
      return file.path;
    }
  }
}
