// ignore_for_file: unnecessary_overrides

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventModel &&
          runtimeType == other.runtimeType &&
          location == other.location &&
          description == other.description &&
          teacher == other.teacher &&
          summary == other.summary &&
          start.isAtSameMomentAs(other.start) &&
          end.isAtSameMomentAs(other.end);

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() {
    return 'EventModel{location: $location, description: $description, teacher: $teacher, summary: $summary, start: $start, end: $end, eventLastModified: $eventLastModified}';
  }
}
