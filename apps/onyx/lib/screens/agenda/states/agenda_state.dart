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
  List<Day> days;
  DateTime wantedDate;
  bool dateUpdateFromPageController;
  int dayCount = 1;
  bool animating = false;

  AgendaState({
    this.status = AgendaStatus.initial,
    this.days = const [],
    this.dateUpdateFromPageController = false,
    required this.wantedDate,
    this.dayCount = 1,
    this.animating = false,
  });

  AgendaState copyWith({
    AgendaStatus? status,
    List<Day>? days,
    DateTime? wantedDate,
    bool? dateUpdateFromPageController,
    int? dayCount,
    bool? animating,
  }) {
    return AgendaState(
      status: status ?? this.status,
      days: days ?? this.days,
      wantedDate: wantedDate ?? this.wantedDate,
      dateUpdateFromPageController:
          dateUpdateFromPageController ?? this.dateUpdateFromPageController,
      dayCount: dayCount ?? this.dayCount,
      animating: animating ?? this.animating,
    );
  }
}
