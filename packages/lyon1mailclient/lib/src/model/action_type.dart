import 'package:dart_mappable/dart_mappable.dart';

part 'action_type.mapper.dart';

@MappableEnum()
enum ActionType {
  @MappableValue(000)
  archive,
  @MappableValue(100)
  markAsRead,
  @MappableValue(200)
  markAsUnread,
  @MappableValue(300)
  move,
  @MappableValue(400)
  send,
  @MappableValue(500)
  reply,
  @MappableValue(700)
  forward,
  @MappableValue(800)
  delete,
  @MappableValue(900)
  flag,
  @MappableValue(1000)
  unflag,
}
