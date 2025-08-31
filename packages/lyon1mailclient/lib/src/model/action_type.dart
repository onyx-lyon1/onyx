import 'package:dart_mappable/dart_mappable.dart';

part 'generated/action_type.mapper.dart';

@MappableEnum()
enum ActionType {
  archive,
  markAsRead,
  markAsUnread,
  move,
  send,
  reply,
  forward,
  delete,
  flag,
  unflag,
}
