part of 'agenda_cubit.dart';

enum AgendaStatus {
  initial,
  loading,
  ready,
  cacheReady,
  dateUpdated,
  error,
  haveToChooseManualy,
  updateDayCount
}

class AgendaState {
  AgendaStatus status;
  List<Day> days;
  DateTime wantedDate;
  bool dateUpdateFromPageController;
  int dayCount = 1;

  AgendaState({
    this.status = AgendaStatus.initial,
    this.days = const [],
    this.dateUpdateFromPageController = false,
    required this.wantedDate,
    this.dayCount = 1,
  });

  AgendaState copyWith({
    AgendaStatus? status,
    List<Day>? days,
    DateTime? wantedDate,
    bool? dateUpdateFromPageController,
    int? dayCount,
  }) {
    return AgendaState(
      status: status ?? this.status,
      days: days ?? this.days,
      wantedDate: wantedDate ?? this.wantedDate,
      dateUpdateFromPageController:
          dateUpdateFromPageController ?? this.dateUpdateFromPageController,
      dayCount: dayCount ?? this.dayCount,
    );
  }
}
