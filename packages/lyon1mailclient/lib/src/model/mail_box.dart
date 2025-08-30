import 'package:dart_mappable/dart_mappable.dart';
import 'package:enough_mail/enough_mail.dart' as enough_mail;
import 'package:enough_mail/highlevel.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';

part 'generated/mail_box.mapper.dart';

@MappableClass()
class MailBox with MailBoxMappable {
  late final String name;
  late final SpecialMailBox? specialMailBox;
  late final List<Mail> emails;

  MailBox({
    required this.name,
    required this.emails,
    this.specialMailBox,
  });

  Future<enough_mail.Mailbox?> toMailLib(Lyon1MailClient mailClient) async {
    List<enough_mail.Mailbox> mailboxes = await mailClient.getRawMailboxes();
    for (var mailbox in mailboxes) {
      for (var flag in mailbox.flags) {
        if (flag.toSpecialMailBox() == specialMailBox) {
          return mailbox;
        }
      }
    }
    int index = mailboxes.indexWhere((element) => element.name == name);
    if (index == -1) {
      return null;
    }
    return mailboxes[index];
  }

  MailBox.fromMailLib(Mailbox mailbox) {
    name = mailbox.name;
    emails = [];
    bool specialNotSet = true;
    for (final MailboxFlag flag in mailbox.flags) {
      switch (flag) {
        case MailboxFlag.inbox:
          specialNotSet = false;
          specialMailBox = SpecialMailBox.inbox;
          break;
        case MailboxFlag.sent:
          specialNotSet = false;
          specialMailBox = SpecialMailBox.sent;
          break;
        case MailboxFlag.trash:
          specialNotSet = false;
          specialMailBox = SpecialMailBox.trash;
          break;
        case MailboxFlag.flagged:
          specialNotSet = false;
          specialMailBox = SpecialMailBox.flagged;
          break;
        case MailboxFlag.archive:
          specialNotSet = false;
          specialMailBox = SpecialMailBox.archive;
          break;
        default:
          break;
      }
    }
    if (specialNotSet) {
      specialMailBox = null;
    }
  }
}

enum SpecialMailBox {
  inbox,
  sent,
  trash,
  flagged,
  archive,
}
