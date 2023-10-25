import 'package:izlyclient/izlyclient.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class AgendaLogic {
  static Future<List<Day>> load(
      {required Lyon1AgendaClient agendaClient,
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

  static Future<List<Day>> getCache(String? path) async {
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

  static Future<List<Day>> addRestaurant(List<Day> days) async {
    //clean the agenda
    for (int i = 0; i < days.length; i++) {
      days[i] = days[i].copyWith(
          events: days[i]
              .events
              .where((element) => element.menuCrous == null)
              .toList());
    }
    List<RestaurantModel> restaurant = await IzlyClient.getRestaurantCrous();
    CacheService.set<List<RestaurantModel>>(restaurant);
    List<Event> menuToAdd = [];
    for (var resto in restaurant) {
      if (await IzlyLogic.isRestaurantFavourite(resto)) {
        for (var menu in resto.menus) {
          //find the free lunch time in the user agenda
          DateTime startLimit;
          DateTime endLimit;
          switch (menu.type) {
            case MenuType.matin:
              startLimit = menu.date.shrink(3).add(const Duration(hours: 7));
              endLimit = menu.date.shrink(3).add(const Duration(hours: 10));
              break;
            case MenuType.midi:
              startLimit = menu.date.shrink(3).add(const Duration(hours: 11));
              endLimit = menu.date.shrink(3).add(const Duration(hours: 14));
              break;
            case MenuType.soir:
              startLimit = menu.date.shrink(3).add(const Duration(hours: 18));
              endLimit = menu.date.shrink(3).add(const Duration(hours: 21));
              break;
          }
          startLimit = startLimit.subtract(const Duration(minutes: 1));
          endLimit = endLimit.add(const Duration(minutes: 1));
          int dayIndex = days.indexWhere((element) =>
              element.date.shrink(3).isAtSameMomentAs(menu.date.shrink(3)));
          if (dayIndex != -1) {
            Day day = days[dayIndex];
            if (day.events.isNotEmpty) {
              List<({DateTime start, DateTime end})> pause = [
                (start: day.date, end: day.events.first.start)
              ];
              for (var i = 0; i < day.events.length - 1; i++) {
                pause.add(
                    (start: day.events[i].end, end: day.events[i + 1].start));
              }
              pause.add((
                start: day.events.last.end,
                end: day.date.add(const Duration(days: 1))
              ));
              pause.removeWhere((element) =>
                  element.end.difference(element.start).inHours < 1);
              for (var i in pause) {
                bool startOk = i.start.isAfter(startLimit) &&
                    i.start.add(const Duration(hours: 1)).isBefore(endLimit);
                bool stopOk = i.end.isBefore(endLimit) &&
                    i.end
                        .subtract(const Duration(hours: 1))
                        .isAfter(startLimit);
                bool inTimeSlot =
                    startLimit.isAfter(i.start) && endLimit.isBefore(i.end);
                if (startOk || stopOk || inTimeSlot) {
                  DateTime start =
                      startLimit.add(const Duration(minutes: 1, hours: 1));
                  DateTime end =
                      endLimit.subtract(const Duration(minutes: 1, hours: 1));
                  if (startOk && stopOk) {
                    if (startLimit.difference(i.start) <
                        endLimit.difference(i.end)) {
                      start = i.start;
                      end = start.add(const Duration(hours: 1));
                    } else {
                      end = i.end;
                      start = end.subtract(const Duration(hours: 1));
                    }
                  } else if (startOk) {
                    start = i.start;
                    end = start.add(const Duration(hours: 1));
                  } else if (stopOk) {
                    end = i.end;
                    start = end.subtract(const Duration(hours: 1));
                  }
                  menuToAdd.add((Event(
                      location: resto.name,
                      menuCrous: menu,
                      teacher: "",
                      description: "",
                      name: menu.type.toString(),
                      start: start,
                      end: end,
                      eventLastModified: DateTime.now())));
                  break;
                }
              }
            } else {
              menuToAdd.add((Event(
                  location: resto.name,
                  menuCrous: menu,
                  teacher: "",
                  description: "",
                  name: menu.type.toString(),
                  start: startLimit.add(const Duration(minutes: 1)),
                  end: endLimit.subtract(const Duration(minutes: 1)),
                  eventLastModified: DateTime.now())));
            }
          }
        }
      }
    }

    //add the new menu to the clean agenda
    for (var menu in menuToAdd) {
      int dayIndex = days.indexWhere((element) =>
          element.date.shrink(3).isAtSameMomentAs(menu.start.shrink(3)));
      if (dayIndex != -1) {
        days[dayIndex].events.add(menu);
        days[dayIndex].events.sort((a, b) => a.start.compareTo(b.start));
      }
    }
    return days;
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
