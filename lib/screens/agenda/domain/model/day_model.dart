// ignore_for_file: hash_and_equals

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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayModel &&
          runtimeType == other.runtimeType &&
          listEquals(events, other.events) &&
          date.isAtSameMomentAs(other.date);

  @override
  String toString() {
    return 'DayModel{events: $events, date: $date}';
  }
}
