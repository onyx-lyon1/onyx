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
  int wantedDate;

  AgendaState({
    this.status = AgendaStatus.initial,
    this.realDays = const [],
    required this.wantedDate,
  });

  AgendaState copyWith({
    AgendaStatus? status,
    List<Day>? realDays,
    int? wantedDate,
  }) {
    return AgendaState(
      status: status ?? this.status,
      realDays: realDays ?? this.realDays,
      wantedDate: wantedDate ?? this.wantedDate,
    );
  }

  List<Day> days(SettingsModel settingsModel) {
    List<Day> realDays = List.from(this.realDays);
    realDays = realDays
        .where((element) =>
            !settingsModel.agendaDisabledDays.contains(element.date.weekday))
        .toList();

    int todayOffset =
        DateTime.now().weekday - (settingsModel.agendaWeekReference + 1);
    todayOffset = todayOffset.positiveModulo(settingsModel.agendaWeekLength);
    int todayIndex = realDays.indexWhere(
        (element) => element.date.isAtSameMomentAs(DateTime.now().shrink(3)));

    if (todayIndex != -1) {
      int paddingBeforeCount = (todayOffset - todayIndex)
          .positiveModulo(settingsModel.agendaWeekLength);
      int paddingAfterCount = (settingsModel.agendaWeekLength -
              ((realDays.length + paddingBeforeCount) %
                  settingsModel.agendaWeekLength))
          .clamp(0, settingsModel.agendaWeekLength - 1);

      int postPaddingCount = 0;
      List<Day> paddingBefore = [];
      for (int i = 0; i < paddingBeforeCount + postPaddingCount; i++) {
        DateTime date = realDays.first.date
            .subtract(Duration(days: paddingBeforeCount - i));
        if (settingsModel.agendaDisabledDays.contains(date.weekday)) {
          postPaddingCount++;
        } else {
          paddingBefore.add(Day(date, const []));
        }
      }

      postPaddingCount = 0;
      List<Day> paddingAfter = [];
      for (int i = 0; i < paddingAfterCount + postPaddingCount; i++) {
        DateTime date = realDays.last.date.add(Duration(days: i + 1));
        if (settingsModel.agendaDisabledDays.contains(date.weekday)) {
          postPaddingCount++;
        } else {
          paddingAfter.add(Day(date, const []));
        }
      }

      return [
        ...paddingBefore,
        ...realDays,
        ...paddingAfter,
      ];
    }

    // Si aucune correspondance n'est trouvée pour aujourd'hui, retourner simplement les jours réels.
    return realDays;
  }
}
