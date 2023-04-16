import 'package:hive_flutter/adapters.dart';
import 'package:onyx/screens/mails/mails_export.dart';

part 'action_model.g.dart';

@HiveType(typeId: 23)
class ActionModel {
  @HiveField(0)
  final ActionType type;
  @HiveField(1)
  final MailBoxModel fromMailBox;
  @HiveField(4)
  final EmailModel? email;
  @HiveField(5)
  final int? originalMessageId;
  @HiveField(6)
  final bool? replyAll;
  @HiveField(7)
  final int? emailNumber;
  @HiveField(8)
  final MailBoxModel? destinationMailBox;

  ActionModel({
    required this.type,
    required this.fromMailBox,
    this.email,
    this.originalMessageId,
    this.replyAll,
    this.emailNumber,
    this.destinationMailBox,
  });

  @override
  String toString() {
    return 'ActionModel{type: $type, mailBox: $fromMailBox, email: $email, originalMessageId: $originalMessageId, replyAll: $replyAll, emailNumber: $emailNumber, destinationMailBox: $destinationMailBox}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActionModel &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          fromMailBox == other.fromMailBox &&
          email == other.email &&
          originalMessageId == other.originalMessageId &&
          replyAll == other.replyAll &&
          emailNumber == other.emailNumber &&
          destinationMailBox == other.destinationMailBox;

  @override
  int get hashCode =>
      type.hashCode ^
      fromMailBox.hashCode ^
      email.hashCode ^
      originalMessageId.hashCode ^
      replyAll.hashCode ^
      emailNumber.hashCode ^
      destinationMailBox.hashCode;
}
