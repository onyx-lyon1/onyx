import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';

part 'generated/action.mapper.dart';

@MappableClass()
class Action with ActionMappable {
  final ActionType type;
  final MailBox? fromMailBox;
  final Mail mail;
  final int? originalMessageId;
  final bool? replyAll;
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
}
