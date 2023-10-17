import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/notifications/notifications_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';

Future<void> emailNotificationLogic(SettingsModel settings) async {
  if (settings.newMailNotification) {
    if (await CacheService.exist<List<MailBox>>()) {
      List<MailBox> mailBoxes = (await CacheService.get<List<MailBox>>())!;
      List<Mail> email = mailBoxes
          .firstWhere(
              (element) => element.specialMailBox == SpecialMailBox.inbox)
          .emails;

      Credential creds = (await CacheService.get<Credential>(
          secureKey: await CacheService.getEncryptionKey(false)))!;
      Lyon1MailClient mail = await MailLogic.connect(
          username: creds.username, password: creds.password);
      List<Mail> newMails = (await MailLogic.load(
              mailClient: mail, emailNumber: 20, blockTrackers: true))
          .emails;
      for (var i in newMails) {
        if (!i.isRead &&
            !email.any((element) {
              return element == i;
            })) {
          await NotificationLogic.showNotification(
              title: "Nouveau mail",
              body:
                  "Vous avez un nouveau mail de ${i.sender} \n\n ${i.excerpt}",
              payload: "newMail");
        }
      }
      int index = mailBoxes.indexWhere(
          (element) => element.specialMailBox == SpecialMailBox.inbox);
      if (index != -1) {
        mailBoxes[index].emails = newMails;
      }

      await CacheService.set<List<MailBox>>(mailBoxes);
    }
  }
}
