import 'package:flutter/material.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/theme/theme_export.dart';

extension PresenceColorConverter on PresenceColor {
  Color toColor() {
    switch (this) {
      case PresenceColor.green:
        return GradeColor.seenGreen;
      case PresenceColor.red:
        return GradeColor.unseenRed;
      case PresenceColor.unset:
        return Colors.transparent;
    }
  }
}