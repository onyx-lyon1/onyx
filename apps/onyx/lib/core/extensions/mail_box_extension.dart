import 'package:flutter/material.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';

extension MailBoxExtension on MailBox {
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
