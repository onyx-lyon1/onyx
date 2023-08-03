import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';

class AgendaParser {
  Future<Agenda?> parseICS(final String icsString) async {
    if (icsString.isEmpty) return null;

    final ICalendar iCal = ICalendar.fromString(icsString);
    final dynamic icsJSON = iCal.toJson()['data'];
    List<Day> days = [];
    for (final dynamic eventJSON in icsJSON) {
      Event event = Event.fromJSON(eventJSON);
      int index = days.indexWhere((element) =>
          element.date.day == event.start.day &&
          element.date.month == event.start.month &&
          element.date.year == event.start.year);
      if (index != -1) {
        days[index].events.add(event);
      } else {
        days.add(Day(
            DateTime(event.start.year, event.start.month, event.start.day),
            [event]));
      }
    }
    List<Day> tmpDays = [];
    for (var i in days) {
      List<Event> events = [];
      for (var e in i.events) {
        if (events.indexWhere((element) => element.start == e.start) == -1) {
          //on dégage les doublons
          events.add(e);
        }
      }
      events.sort((a, b) => a.start.compareTo(b.start));
      tmpDays.add(i.copyWith(events: events));
    }
    days = tmpDays;
    days.sort((a, b) => a.date.compareTo(b.date));
    if (days.isEmpty) return null;
    for (DateTime i = days.first.date;
        i.isBefore(days.last.date);
        i = i.add(const Duration(days: 1))) {
      int index = days.indexWhere((element) =>
          element.date.toLocal().day == i.day &&
          element.date.toLocal().month == i.month &&
          element.date.toLocal().year == i.year);
      if (index == -1) {
        days.insert(
            days.indexWhere((element) =>
                    element.date.toLocal().day ==
                        i.subtract(const Duration(days: 1)).day &&
                    element.date.toLocal().month ==
                        i.subtract(const Duration(days: 1)).month &&
                    element.date.toLocal().year ==
                        i.subtract(const Duration(days: 1)).year) +
                1,
            Day(i, []));
      }
    }

    return Agenda(days);
  }
}
