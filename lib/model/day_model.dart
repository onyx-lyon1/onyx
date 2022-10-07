import 'package:oloid2/model/event_model.dart';

class DayModel {
  List<EventModel> events;
  final DateTime date;

  DayModel(this.date, this.events);
}
