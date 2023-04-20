import 'package:enough_mail/enough_mail.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/screens/mails/mails_export.dart';

part 'generated/mail_box_model.g.dart';

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
    //print("Mailbox : ${mailbox.name}, ${mailbox.flags}, ${mailbox}");
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
        case MailboxFlag.marked:
          // TODO: Handle this case.
          break;
        case MailboxFlag.unMarked:
          // TODO: Handle this case.
          break;
        case MailboxFlag.hasChildren:
          // TODO: Handle this case.
          break;
        case MailboxFlag.hasNoChildren:
          // TODO: Handle this case.
          break;
        case MailboxFlag.noSelect:
          // TODO: Handle this case.
          break;
        case MailboxFlag.select:
          // TODO: Handle this case.
          break;
        case MailboxFlag.noInferior:
          // TODO: Handle this case.
          break;
        case MailboxFlag.subscribed:
          // TODO: Handle this case.
          break;
        case MailboxFlag.remote:
          // TODO: Handle this case.
          break;
        case MailboxFlag.nonExistent:
          // TODO: Handle this case.
          break;
        case MailboxFlag.all:
          // TODO: Handle this case.
          break;
        case MailboxFlag.drafts:
          // TODO: Handle this case.
          break;
        case MailboxFlag.junk:
          // TODO: Handle this case.
          break;
        case MailboxFlag.virtual:
          // TODO: Handle this case.
          break;
      }
    }
    return MailBoxModel(
      name: mailbox.name,
      emails: [],
      specialMailBox: specialMailBox,
    );
  }

  @override
  String toString() {
    return 'MailBoxModel{name: $name, specialMailBox: $specialMailBox, emails: ${emails.length}}';
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
