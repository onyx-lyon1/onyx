import 'package:enough_mail/enough_mail.dart';
import 'package:flutter/material.dart';
import 'package:onyx/screens/mails/domain/model/mail_box_model.dart';

extension MailBoxTag on SpecialMailBox {
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

extension MailBoxModelExtension on MailBoxModel {
  IconData toIcon() {
    switch (specialMailBox) {
      case SpecialMailBox.inbox:
        return Icons.inbox;
      case SpecialMailBox.sent:
        return Icons.send;
      case SpecialMailBox.trash:
        return Icons.delete;
      case SpecialMailBox.flagged:
        return Icons.flag;
      case SpecialMailBox.archive:
        return Icons.archive;
      default:
        return Icons.folder;
    }
  }
}
