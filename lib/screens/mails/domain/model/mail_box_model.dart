import 'package:enough_mail/enough_mail.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/screens/mails/mails_export.dart';

part 'mail_box_model.g.dart';

@HiveType(typeId: 19)
class MailBoxModel {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late SpecialMailBox? specialMailBox;
  @HiveField(2)
  late List<EmailModel> emails;

  MailBoxModel({
    required this.name,
    required this.emails,
    this.specialMailBox,
  });

  static MailBoxModel fromMailLib(Mailbox mailbox) {
    SpecialMailBox? specialMailBox;
    for (final MailboxFlag flag in mailbox.flags) {
      switch (flag) {
        case MailboxFlag.inbox:
          specialMailBox = SpecialMailBox.inbox;
          break;
        case MailboxFlag.sent:
          specialMailBox = SpecialMailBox.sent;
          break;
        case MailboxFlag.trash:
          specialMailBox = SpecialMailBox.trash;
          break;
        case MailboxFlag.flagged:
          specialMailBox = SpecialMailBox.flagged;
          break;
        case MailboxFlag.archive:
          specialMailBox = SpecialMailBox.archive;
          break;
        default:
          specialMailBox = null;
          break;
      }
    }
    return MailBoxModel(
      name: mailbox.name,
      emails: [],
      specialMailBox: specialMailBox,
    );
  }
}

@HiveType(typeId: 20)
enum SpecialMailBox {
  @HiveField(0)
  inbox,
  @HiveField(1)
  sent,
  @HiveField(2)
  trash,
  @HiveField(3)
  flagged,
  @HiveField(4)
  archive,
}
