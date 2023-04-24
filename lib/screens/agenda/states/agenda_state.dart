part of 'agenda_cubit.dart';

enum AgendaStatus {
  initial,
  loading,
  ready,
  cacheReady,
  dateUpdated,
  error,
  haveToChooseManualy
}

class AgendaState {
  AgendaStatus status;
  List<Day> days;
  DateTime wantedDate;
  bool dateUpdateFromPageController;

  AgendaState({
    this.status = AgendaStatus.initial,
    this.days = const [],
    this.dateUpdateFromPageController = false,
    required this.wantedDate,
  });

  AgendaState copyWith({
    AgendaStatus? status,
    List<Day>? days,
    DateTime? wantedDate,
    bool? dateUpdateFromPageController,
  }) {
    return AgendaState(
      status: status ?? this.status,
      days: days ?? this.days,
      wantedDate: wantedDate ?? this.wantedDate,
      dateUpdateFromPageController:
          dateUpdateFromPageController ?? this.dateUpdateFromPageController,
    );
  }
}
