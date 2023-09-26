import 'package:enough_mail/enough_mail.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart' show SpecialMailBox;

extension SpecialMailBoxExtension on SpecialMailBox {
  MailboxFlag toMailBoxTag() {
    switch (this) {
      case SpecialMailBox.inbox:
        return MailboxFlag.inbox;
      case SpecialMailBox.sent:
        return MailboxFlag.sent;
      case SpecialMailBox.trash:
        return MailboxFlag.trash;
      case SpecialMailBox.flagged:
        return MailboxFlag.flagged;
      case SpecialMailBox.archive:
        return MailboxFlag.archive;
    }
  }
}
