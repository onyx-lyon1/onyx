import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';

part 'generated/action.g.dart';

@CopyWith()
@HiveType(typeId: 23)
class Action extends Equatable {
  @HiveField(0)
  final ActionType type;
  @HiveField(1)
  final MailBox? fromMailBox;
  @HiveField(4)
  final Mail mail;
  @HiveField(5)
  final int? originalMessageId;
  @HiveField(6)
  final bool? replyAll;
  @HiveField(8)
  final MailBox? destinationMailBox;

  Action({
    required this.type,
    required this.mail,
    this.fromMailBox,
    this.originalMessageId,
    this.replyAll,
    this.destinationMailBox,
  }) {
    switch (type) {
      case ActionType.archive:
        assert(fromMailBox != null);
        assert(originalMessageId == null);
        assert(replyAll == null);
        assert(destinationMailBox == null);
        break;
      case ActionType.markAsRead:
        assert(fromMailBox != null);
        assert(originalMessageId == null);
        assert(replyAll == null);
        assert(destinationMailBox == null);
        break;
      case ActionType.markAsUnread:
        assert(fromMailBox != null);
        assert(originalMessageId == null);
        assert(replyAll == null);
        assert(destinationMailBox == null);
        break;
      case ActionType.move:
        assert(fromMailBox != null);
        assert(originalMessageId == null);
        assert(replyAll == null);
        assert(destinationMailBox != null);
        break;
      case ActionType.send:
        assert(fromMailBox == null);
        assert(originalMessageId == null);
        assert(replyAll == null);
        assert(destinationMailBox == null);
        break;
      case ActionType.reply:
        assert(fromMailBox != null);
        assert(originalMessageId != null);
        assert(replyAll != null);
        assert(destinationMailBox == null);
        break;
      case ActionType.forward:
        assert(fromMailBox != null);
        assert(originalMessageId != null);
        assert(replyAll == null);
        assert(destinationMailBox == null);
        break;
      case ActionType.delete:
        assert(fromMailBox != null);
        assert(originalMessageId == null);
        assert(replyAll == null);
        assert(destinationMailBox == null);
        break;
      case ActionType.flag:
        assert(fromMailBox != null);
        assert(originalMessageId == null);
        assert(replyAll == null);
        assert(destinationMailBox == null);
        break;
      case ActionType.unflag:
        assert(fromMailBox != null);
        assert(originalMessageId == null);
        assert(replyAll == null);
        assert(destinationMailBox == null);
        break;
    }
  }

  @override
  List<Object?> get props => [
        type,
        fromMailBox,
        mail,
        originalMessageId,
        replyAll,
        destinationMailBox,
      ];

  @override
  bool? get stringify => true;
}
