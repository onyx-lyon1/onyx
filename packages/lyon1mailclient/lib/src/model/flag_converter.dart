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
    return null;
  }
}
