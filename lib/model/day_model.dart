import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/model/event_model.dart';

part 'day_model.g.dart';

@HiveType(typeId: 2)
class DayModel {
  @HiveField(0)
  List<EventModel> events;
  @HiveField(1)
  final DateTime date;

  DayModel(this.date, this.events);
}
