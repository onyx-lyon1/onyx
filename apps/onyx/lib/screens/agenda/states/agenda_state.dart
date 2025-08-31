// ignore_for_file: unnecessary_this, prefer_initializing_formals

part of 'agenda_cubit.dart';

enum AgendaStatus {
  initial,
  loading,
  ready,
  cacheReady,
  dateUpdated,
  error,
  haveToChooseManualy,
  updateDayCount,
  updateAnimating,
  connecting,
}

class AgendaState {
  final AgendaStatus status;
  late final List<Day> realDays;
  final List<Event> examEvents;
  final List<int> agendaIds;
  final int wantedDate;

  AgendaState({
    this.status = AgendaStatus.initial,
    List<Day> realDays = const [],
    this.examEvents = const [],
    required this.wantedDate,
    this.agendaIds = const [],
    required SettingsModel settingsModel,
  }) {
    int paddingBefore = 0;
    int paddingAfter = 0;
    if (realDays.isEmpty) {
      this.realDays = realDays;
      return;
    }
    // remove disabled days
    realDays = realDays
        .where((element) =>
            !settingsModel.agendaDisabledDays.contains(element.date.weekday))
        .toList();

    // move today week day to next week day if on a disabled day
    int todayOffset = 0;
    for (var i = 0;
        i < 7 &&
            settingsModel.agendaDisabledDays.contains(
                (DateTime.now().weekday + todayOffset).positiveModulo(8));
        i++) {
      //use for to ensure that we don't loop forever
      todayOffset++;
    }

    int weekReference = settingsModel.agendaWeekReference;
    if (weekReference == 8) {
      weekReference = DateTime.now().weekday - 1;
    }
    int todayIndex = realDays.indexWhere(
        (element) => element.date.day == (DateTime.now().day + todayOffset));
    if (todayIndex != -1) {
      int indexToAlign = todayIndex -
          (realDays[todayIndex].date.weekday - (weekReference + 1));
      int alignement = indexToAlign % settingsModel.agendaWeekLength;
      int alignementOffset =
          settingsModel.agendaWeekRerenceAlignement - alignement;
      alignementOffset =
          alignementOffset.positiveModulo(settingsModel.agendaWeekLength);

      paddingBefore = alignementOffset;
      paddingAfter = settingsModel.agendaWeekLength - alignementOffset;
    }

    //add examEvents
    for (var i in examEvents) {
      int index =
          realDays.indexWhere((element) => element.date.isSameDay(i.start));
      if (index != -1) {
        //remove if an event with name colle/kholle is at the same time
        for (var j = 0; j < realDays[index].events.length; j++) {
          if (realDays[index]
                  .events[j]
                  .start
                  .isBefore(i.start.add(Durations.short1)) &&
              realDays[index]
                  .events[j]
                  .end
                  .isAfter(i.start.subtract(Durations.short1))) {
            for (var name in ["colle", "kholle"]) {
              if (removeDiacritics(realDays[index].events[j].name)
                  .toLowerCase()
                  .trim()
                  .contains(name)) {
                realDays[index].events.removeAt(j);
                j--;
              }
            }
            break;
          }
        }
      }
    }

    //add examEvents
    for (var i in examEvents) {
      int index =
          realDays.indexWhere((element) => element.date.isSameDay(i.start));
      if (index != -1) {
        realDays[index] = realDays[index].copyWith(events: [
          ...realDays[index].events,
          i,
        ]);
      } else {
        realDays.add(Day(i.start.shrink(3), [i]));
      }
    }
    this.realDays = [
      ...List.generate(
        paddingBefore,
        (index) =>
            Day(realDays[0].date.subtract(Duration(days: index + 1)), const []),
      ),
      ...realDays,
      ...List.generate(
        paddingAfter,
        (index) =>
            Day(realDays.last.date.add(Duration(days: index + 1)), const []),
      ),
    ];
  }

  AgendaState copyWith({
    AgendaStatus? status,
    List<Day>? realDays,
    List<Event>? examEvents,
    int? wantedDate,
    List<int>? agendaIds,
    required SettingsModel settingsModel,
  }) {
    return AgendaState(
      status: status ?? this.status,
      realDays: realDays ?? this.realDays,
      wantedDate: wantedDate ?? this.wantedDate,
      examEvents: examEvents ?? this.examEvents,
      agendaIds: agendaIds ?? this.agendaIds,
      settingsModel: settingsModel,
    );
  }

  int getDayIndex({required DateTime date, required SettingsModel settings}) {
    List<Day> tmpDays = realDays;
    int distance = tmpDays.length;
    int index = -1;

    for (int i = 0; i < tmpDays.length; i++) {
      if ((tmpDays[i].date.difference(date).inDays).abs() < distance) {
        distance = (tmpDays[i].date.difference(date).inDays).abs();
        index = i;
      }
    }
    return index;
  }

  List<Day> get days => realDays;
}
