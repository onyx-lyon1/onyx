import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:oloid2/core/cache_service.dart';
import 'package:oloid2/core/initialisations/initialisations_export.dart';
import 'package:oloid2/screens/agenda/agenda_export.dart';
import 'package:oloid2/screens/settings/settings_export.dart';

class AgendaLogic {
  static Future<List<DayModel>> load(
      {required Lyon1Agenda agendaClient,
      required SettingsModel settings,
      DateTime? maxDate}) async {
    Agenda? agendaOpt;
    try {
      agendaOpt = await agendaClient.getAgenda(
          url: (settings.fetchAgendaAuto) ? "" : settings.agendaURL);
      if (agendaOpt == null || agendaOpt.events.isEmpty) {
        throw Exception("Agenda is empty");
      }
    } catch (e) {
      throw Exception("Error while fetching agenda: $e");
    }
    final Agenda agenda = agendaOpt;

    List<DayModel> tmpDayModels = [];

    for (final Event e in agenda.events) {
      EventModel event = EventModel(
          summary: "summary",
          description: e.name,
          end: e.end.toLocal(),
          eventLastModified: e.lastModified.toLocal(),
          location: e.location,
          start: e.start.toLocal(),
          teacher: e.teacher);

      int index = tmpDayModels.indexWhere((element) =>
          element.date.toLocal().day == e.start.toLocal().day &&
          element.date.toLocal().month == e.start.toLocal().month &&
          element.date.toLocal().year == e.start.toLocal().year);

      if (index != -1) {
        tmpDayModels[index].events.add(event);
      } else {
        tmpDayModels.add(DayModel(
            DateTime(e.start.toLocal().year, e.start.toLocal().month,
                e.start.toLocal().day),
            [event]));
      }
    }
    for (var i in tmpDayModels) {
      List<EventModel> events = [];
      for (var e in i.events) {
        if (events.indexWhere((element) => element.start == e.start) == -1) {
          events.add(e);
        }
      }
      i.events = events;
      i.events.sort((a, b) => a.start.compareTo(b.start));
    }
    tmpDayModels.sort((a, b) => a.date.compareTo(b.date));
    DateTime first = tmpDayModels.first.date;
    DateTime last = tmpDayModels.last.date;
    for (DateTime i = first;
        i.isBefore(last);
        i = i.add(const Duration(days: 1))) {
      int index = tmpDayModels.indexWhere((element) =>
          element.date.toLocal().day == i.day &&
          element.date.toLocal().month == i.month &&
          element.date.toLocal().year == i.year);
      if (index == -1) {
        tmpDayModels.insert(
            tmpDayModels.indexWhere((element) =>
                    element.date.toLocal().day ==
                        i.subtract(const Duration(days: 1)).day &&
                    element.date.toLocal().month ==
                        i.subtract(const Duration(days: 1)).month &&
                    element.date.toLocal().year ==
                        i.subtract(const Duration(days: 1)).year) +
                1,
            DayModel(i, []));
      }
    }
    return tmpDayModels;
  }

  static Future<List<DayModel>> getCache(String path) async {
    await hiveInit(path: path);
    print("before exist");
    if (await CacheService.exist<DayModelWrapper>()) {
      print("le cache agenda existe");
      List<DayModel> dayModels =
          (await CacheService.get<DayModelWrapper>())!.dayModels;
      print("le cache agenda a été récupéré");
      return dayModels;
    } else {
      return [];
    }
  }
}
