
import 'package:hive_flutter/adapters.dart';

part 'event_model.g.dart';

@HiveType(typeId: 3)
class EventModel {
  @HiveField(0)
  final String location;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String teacher;
  @HiveField(3)
  final String summary;

  @HiveField(4)
  final DateTime start;
  @HiveField(5)
  final DateTime end;
  @HiveField(6)
  final DateTime eventLastModified;

  EventModel({
    required this.location,
    required this.description,
    required this.teacher,
    required this.summary,
    required this.start,
    required this.end,
    required this.eventLastModified,
  });
}
