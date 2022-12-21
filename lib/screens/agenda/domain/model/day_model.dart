import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/screens/agenda/agenda_export.dart';

part 'day_model.g.dart';

@HiveType(typeId: 1)
class DayModel {
  @HiveField(0)
  List<EventModel> events;
  @HiveField(1)
  final DateTime date;

  DayModel(this.date, this.events);

  @override
  String toString() {
    return 'DayModel{events: $events, date: $date}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayModel &&
          runtimeType == other.runtimeType &&
          listEquals(events, other.events) &&
          date == other.date;

  @override
  int get hashCode => events.hashCode ^ date.hashCode;
}
