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
  List<DayModel> dayModels;
  DateTime wantedDate;
  bool dateUpdateFromPageController;

  AgendaState({
    this.status = AgendaStatus.initial,
    this.dayModels = const [],
    this.dateUpdateFromPageController = false,
    required this.wantedDate,
  });

  AgendaState copyWith({
    AgendaStatus? status,
    List<DayModel>? dayModels,
    DateTime? wantedDate,
    bool? dateUpdateFromPageController,
  }) {
    return AgendaState(
      status: status ?? this.status,
      dayModels: dayModels ?? this.dayModels,
      wantedDate: wantedDate ?? this.wantedDate,
      dateUpdateFromPageController:
          dateUpdateFromPageController ?? this.dateUpdateFromPageController,
    );
  }
}
