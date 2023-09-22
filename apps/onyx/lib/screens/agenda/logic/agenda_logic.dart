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

  static Future<void> addRestaurant(List<Day> days) async {
    //clean the agenda
    for (int i = 0; i < days.length; i++) {
      days[i] = days[i].copyWith(
          events: days[i]
              .events
              .where((element) => element.menuCrous == null)
              .toList());
    }
    List<RestaurantModel> restaurant = await IzlyClient.getRestaurantCrous();
    CacheService.set<RestaurantListModel>(
        RestaurantListModel(restaurantList: restaurant));
    List<(Event, int)> menuToAdd = [];
    for (var resto in restaurant) {
      if (await IzlyLogic.isRestaurantFavourite(resto)) {
        for (var menu in resto.menus) {
          //find the free lunch time in the user agenda
          int startLimit;
          int endLimit;
          switch (menu.type) {
            case MenuType.matin:
              startLimit = 7;
              endLimit = 10;
              break;
            case MenuType.midi:
              startLimit = 11;
              endLimit = 14;
              break;
            case MenuType.soir:
              startLimit = 18;
              endLimit = 21;
              break;
          }
          ({
            Duration duration,
            DateTime start,
            DateTime end,
            int index
          }) lastPause = (
            duration: Duration.zero,
            start: menu.date.shrink(3).add(Duration(hours: startLimit + 1)),
            end: menu.date.shrink(3).add(Duration(hours: endLimit + 2)),
            index: 0
          );
          Day day = days.firstWhere((element) =>
              element.date.shrink(3).isAtSameMomentAs(menu.date.shrink(3)));
          if (day.events.length == 1) {
            if (day.events.first.start
                    .subtract(const Duration(hours: 1))
                    .hour >=
                startLimit) {
              lastPause = (
                duration: const Duration(hours: 1),
                start:
                    day.events.first.start.subtract(const Duration(hours: 1)),
                end: day.events.first.start,
                index: 0,
              );
            } else {
              lastPause = (
                duration: const Duration(hours: 1),
                start: day.events.first.end,
                end: day.events.first.end.add(const Duration(hours: 1)),
                index: 1,
              );
            }
          } else {
            for (int i = 0; i < day.events.length - 1; i++) {
              if (day.events[i].end.hour >= startLimit &&
                  (day.events[i + 1].start.hour <= endLimit ||
                      day.events[i + 1].start.hour - day.events[i].end.hour >=
                          1)) {
                Duration duration =
                    day.events[i + 1].start.difference(day.events[i].end);
                if (duration >= const Duration(minutes: 30) &&
                    duration > lastPause.duration) {
                  lastPause = (
                    duration: duration,
                    start: day.events[i].end,
                    end: day.events[i + 1].start,
                    index: i + 1
                  );
                }
              }
            }
          }
          menuToAdd.add((
            Event(
                location: resto.name,
                menuCrous: menu,
                teacher: "",
                description: "",
                name: menu.type.toString(),
                start: lastPause.start,
                end: lastPause.end,
                eventLastModified: DateTime.now()),
            lastPause.index
          ));
        }
      }
    }

    //add the new menu to the clean agenda
    for (var menu in menuToAdd) {
      int index = days.indexWhere((element) =>
          element.date.shrink(3).isAtSameMomentAs(menu.$1.start.shrink(3)));
      List<Event> events = List.from(days[index].events);
      days[index] =
          days[index].copyWith(events: events..insert(menu.$2, menu.$1));
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
