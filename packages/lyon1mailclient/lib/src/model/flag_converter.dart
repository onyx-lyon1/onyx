import 'package:enough_mail/enough_mail.dart';
import 'package:lyon1mailclient/src/model/mail_box.dart';

extension SpecialFlagConverter on SpecialMailBox {
  MailboxFlag? toMailboxFlag() {
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

extension FlagConverter on MailboxFlag {
  SpecialMailBox? toSpecialMailBox() {
    switch (this) {
      case MailboxFlag.inbox:
        return SpecialMailBox.inbox;
      case MailboxFlag.sent:
        return SpecialMailBox.sent;
      case MailboxFlag.trash:
        return SpecialMailBox.trash;
      case MailboxFlag.flagged:
        return SpecialMailBox.flagged;
      case MailboxFlag.archive:
        return SpecialMailBox.archive;
      case MailboxFlag.marked:
        return null;
      case MailboxFlag.unMarked:
        break;
      case MailboxFlag.hasChildren:
        break;
      case MailboxFlag.hasNoChildren:
        break;
      case MailboxFlag.noSelect:
        break;
      case MailboxFlag.select:
        break;
      case MailboxFlag.noInferior:
        break;
      case MailboxFlag.subscribed:
        break;
      case MailboxFlag.remote:
        break;
      case MailboxFlag.nonExistent:
        break;
      case MailboxFlag.all:
        break;
      case MailboxFlag.drafts:
        break;
      case MailboxFlag.junk:
        break;
      case MailboxFlag.virtual:
        break;
    }
    return null;
  }
}
