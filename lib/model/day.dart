import 'package:oloid2/model/event.dart';

class DayModel {
  List<EventModel> events;
  final DateTime date;

  DayModel(this.date, this.events);
}
