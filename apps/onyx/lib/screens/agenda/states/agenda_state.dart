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
  DateTime wantedDate;
  int dayCount = 1;

  AgendaState({
    this.status = AgendaStatus.initial,
    this.realDays = const [],
    required this.wantedDate,
    this.dayCount = 1,
  });

  AgendaState copyWith({
    AgendaStatus? status,
    List<Day>? realDays,
    DateTime? wantedDate,
    int? dayCount,
    List<Day>? paddingDays,
  }) {
    return AgendaState(
      status: status ?? this.status,
      realDays: realDays ?? this.realDays,
      wantedDate: wantedDate ?? this.wantedDate,
      dayCount: dayCount ?? this.dayCount,
    );
  }

  List<Day> get days => [
        ...List.generate(
            dayCount - 1,
            (index) => Day(
                realDays.first.date
                    .subtract(Duration(days: dayCount - 1 - index)),
                const [])),
        ...realDays,
        ...List.generate(
            dayCount - 1,
            (index) =>
                Day(realDays.last.date.add(Duration(days: index)), const [])),
      ];
}
