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
}

class AgendaState {
  AgendaStatus status;
  List<Day> realDays;
  List<Event> examEvents = [];
  int wantedDate;

  AgendaState({
    this.status = AgendaStatus.initial,
    this.realDays = const [],
    this.examEvents = const [],
    required this.wantedDate,
  });

  AgendaState copyWith({
    AgendaStatus? status,
    List<Day>? realDays,
    List<Event>? examEvents,
    int? wantedDate,
  }) {
    return AgendaState(
      status: status ?? this.status,
      realDays: realDays ?? this.realDays,
      wantedDate: wantedDate ?? this.wantedDate,
      examEvents: examEvents ?? this.examEvents,
    );
  }

  int getDayIndex(
      {required DateTime date,
      required SettingsModel settings,
      bool useRealDays = false}) {
    List<Day> tmpDays = (useRealDays) ? realDays : days(settings);
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

  List<Day> days(SettingsModel settingsModel) {
    List<Day> realDays = List.from(this.realDays);
    List<Day> paddingBefore = [];
    List<Day> paddingAfter = [];
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

      if (alignementOffset != 0) {
        paddingBefore = List.generate(
          alignementOffset,
          (index) => Day(
              realDays[0]
                  .date
                  .subtract(Duration(days: alignementOffset - index + 1)),
              const []),
        );
        paddingAfter = List.generate(
          settingsModel.agendaWeekLength - alignementOffset,
          (index) => Day(
              realDays[realDays.length - 1].date.add(Duration(days: index + 1)),
              const []),
        );
      }
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
              }
            }

            break;
          }
        }
        realDays[index] = realDays[index].copyWith(events: [
          ...realDays[index].events,
          i,
        ]);
      } else {
        realDays.add(Day(i.start.shrink(3), [i]));
      }
    }

    return [
      ...paddingBefore,
      ...realDays,
      ...paddingAfter,
    ];
  }

  // Si aucune correspondance n'est trouvée pour aujourd'hui, retourner simplement les jours réels.
  // return realDays;
}
