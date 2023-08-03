import 'package:hive/hive.dart';

part 'generated/action_type.g.dart';

@HiveType(typeId: 22)
enum ActionType {
  @HiveField(0)
  archive,
  @HiveField(1)
  markAsRead,
  @HiveField(2)
  markAsUnread,
  @HiveField(3)
  move,
  @HiveField(4)
  send,
  @HiveField(5)
  reply,
  @HiveField(7)
  forward,
  @HiveField(8)
  delete,
  @HiveField(9)
  flag,
  @HiveField(10)
  unflag,
}
