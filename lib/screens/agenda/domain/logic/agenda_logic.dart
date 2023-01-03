import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class AgendaLogic {
  static Future<List<DayModel>> load(
      {required Lyon1Agenda agendaClient,
      required SettingsModel settings,
      DateTime? maxDate}) async {
    if (Res.mock) {
      return dayModelListMock;
    }
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
    if (Res.mock) {
      return dayModelListMock;
    }
    await hiveInit(path: path);
    if (await CacheService.exist<DayModelWrapper>()) {
      return (await CacheService.get<DayModelWrapper>())!.dayModels;
    } else {
      return [];
    }
  }

  static final List<DayModel> dayModelListMock = [
    DayModel(DateTime(2022, 9, 1), [
      EventModel(
          location: "Déambu",
          description: "mockDescription1",
          teacher: "mockTeacher1",
          summary: "mockSummary1",
          start: DateTime(2022, 9, 1, 8),
          end: DateTime(2022, 9, 1, 9),
          eventLastModified: DateTime(2022, 9, 1)),
      EventModel(
          location: "Thémis",
          description: "mockDescription2",
          teacher: "mockTeacher2",
          summary: "mockSummary2",
          start: DateTime(2022, 9, 1, 9),
          end: DateTime(2022, 9, 1, 10),
          eventLastModified: DateTime(2022, 9, 1)),
      EventModel(
          location: "Nautibus",
          description: "mockDescription3",
          teacher: "mockTeacher3",
          summary: "mockSummary3",
          start: DateTime(2022, 9, 1, 10),
          end: DateTime(2022, 9, 1, 11),
          eventLastModified: DateTime(2022, 9, 1)),
    ]),
    DayModel(DateTime(2022, 9, 2), [
      EventModel(
          location: "quai 43",
          description: "mockDescription4",
          teacher: "mockTeacher4",
          summary: "mockSummary4",
          start: DateTime(2022, 9, 1, 11),
          end: DateTime(2022, 9, 1, 12),
          eventLastModified: DateTime(2022, 9, 1)),
      EventModel(
          location: "ISTIL",
          description: "mockDescription5",
          teacher: "mockTeacher5",
          summary: "mockSummary5",
          start: DateTime(2022, 9, 1, 12),
          end: DateTime(2022, 9, 1, 13),
          eventLastModified: DateTime(2022, 9, 1)),
      EventModel(
          location: "Forel",
          description: "mockDescription6",
          teacher: "mockTeacher6",
          summary: "mockSummary6",
          start: DateTime(2022, 9, 1, 13),
          end: DateTime(2022, 9, 1, 14),
          eventLastModified: DateTime(2022, 9, 1)),
    ]),
    DayModel(DateTime(2022, 9, 3), [
      EventModel(
          location: "Déambu",
          description: "mockDescription7",
          teacher: "mockTeacher7",
          summary: "mockSummary7",
          start: DateTime(2022, 9, 1, 14),
          end: DateTime(2022, 9, 1, 15),
          eventLastModified: DateTime(2022, 9, 1)),
      EventModel(
          location: "Thémis",
          description: "mockDescription8",
          teacher: "mockTeacher8",
          summary: "mockSummary8",
          start: DateTime(2022, 9, 1, 15),
          end: DateTime(2022, 9, 1, 16),
          eventLastModified: DateTime(2022, 9, 1)),
      EventModel(
          location: "Nautibus",
          description: "mockDescription9",
          teacher: "mockTeacher9",
          summary: "mockSummary9",
          start: DateTime(2022, 9, 1, 16),
          end: DateTime(2022, 9, 1, 17),
          eventLastModified: DateTime(2022, 9, 1)),
    ]), for (int i = 4; i < 300; i++)
        DayModel(
            DateTime(
                    DateTime.now().year + ((DateTime.now().month < 6) ? -1 : 0),
                    9)
                .add(
              Duration(days: i),
            ),
            []),
  ];
}
