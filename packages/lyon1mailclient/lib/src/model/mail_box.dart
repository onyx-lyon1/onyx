import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:enough_mail/enough_mail.dart' as enough_mail;
import 'package:enough_mail/highlevel.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:lyon1mailclient/src/model/flag_converter.dart';

part 'generated/mail_box.g.dart';

@CopyWith()
@HiveType(typeId: 19)
class MailBox extends Equatable {
  @HiveField(0)
  late final String name;
  @HiveField(1)
  late final SpecialMailBox? specialMailBox;
  @HiveField(2)
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

  @override
  List<Object?> get props => [name, specialMailBox, emails];

  @override
  bool? get stringify => true;
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
