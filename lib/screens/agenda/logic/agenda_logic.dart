import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class AgendaLogic {
  static Future<List<Day>> load(
      {required Lyon1Agenda agendaClient,
      required SettingsModel settings,
      DateTime? maxDate}) async {
    if (Res.mock) {
      return dayListMock;
    }
    Agenda? agendaOpt;
    try {
      agendaOpt = await agendaClient.getAgenda(
          id: (settings.fetchAgendaAuto) ? null : settings.agendaId);
      if (agendaOpt == null || agendaOpt.days.isEmpty) {
        throw Exception("Agenda is empty");
      }
    } catch (e) {
      throw Exception("Error while fetching agenda: $e");
    }
    return agendaOpt.days;
  }

  static Future<List<Day>> getCache(String path) async {
    if (Res.mock) {
      return dayListMock;
    }
    await hiveInit(path: path);
    if (await CacheService.exist<Agenda>()) {
      return (await CacheService.get<Agenda>())!.days;
    } else {
      return [];
    }
  }

  static final List<Day> dayListMock = [
    Day(DateTime(2022, 9, 1), [
      Event(
          location: "Déambu",
          description: "mockDescription1",
          teacher: "mockTeacher1",
          name: "mockname1",
          start: DateTime(2022, 9, 1, 8),
          end: DateTime(2022, 9, 1, 9),
          eventLastModified: DateTime(2022, 9, 1)),
      Event(
          location: "Thémis",
          description: "mockDescription2",
          teacher: "mockTeacher2",
          name: "mockname2",
          start: DateTime(2022, 9, 1, 9),
          end: DateTime(2022, 9, 1, 10),
          eventLastModified: DateTime(2022, 9, 1)),
      Event(
          location: "Nautibus",
          description: "mockDescription3",
          teacher: "mockTeacher3",
          name: "mockname3",
          start: DateTime(2022, 9, 1, 10),
          end: DateTime(2022, 9, 1, 11),
          eventLastModified: DateTime(2022, 9, 1)),
    ]),
    Day(DateTime(2022, 9, 2), [
      Event(
          location: "quai 43",
          description: "mockDescription4",
          teacher: "mockTeacher4",
          name: "mockname4",
          start: DateTime(2022, 9, 1, 11),
          end: DateTime(2022, 9, 1, 12),
          eventLastModified: DateTime(2022, 9, 1)),
      Event(
          location: "ISTIL",
          description: "mockDescription5",
          teacher: "mockTeacher5",
          name: "mockname5",
          start: DateTime(2022, 9, 1, 12),
          end: DateTime(2022, 9, 1, 13),
          eventLastModified: DateTime(2022, 9, 1)),
      Event(
          location: "Forel",
          description: "mockDescription6",
          teacher: "mockTeacher6",
          name: "mockname6",
          start: DateTime(2022, 9, 1, 13),
          end: DateTime(2022, 9, 1, 14),
          eventLastModified: DateTime(2022, 9, 1)),
    ]),
    Day(DateTime(2022, 9, 3), [
      Event(
          location: "Déambu",
          description: "mockDescription7",
          teacher: "mockTeacher7",
          name: "mockname7",
          start: DateTime(2022, 9, 1, 14),
          end: DateTime(2022, 9, 1, 15),
          eventLastModified: DateTime(2022, 9, 1)),
      Event(
          location: "Thémis",
          description: "mockDescription8",
          teacher: "mockTeacher8",
          name: "mockname8",
          start: DateTime(2022, 9, 1, 15),
          end: DateTime(2022, 9, 1, 16),
          eventLastModified: DateTime(2022, 9, 1)),
      Event(
          location: "Nautibus",
          description: "mockDescription9",
          teacher: "mockTeacher9",
          name: "mockname9",
          start: DateTime(2022, 9, 1, 16),
          end: DateTime(2022, 9, 1, 17),
          eventLastModified: DateTime(2022, 9, 1)),
    ]),
    for (int i = 4; i < 300; i++)
      Day(
          DateTime(DateTime.now().year + ((DateTime.now().month < 6) ? -1 : 0),
                  9)
              .add(
            Duration(days: i),
          ),
          const []),
  ];
}
