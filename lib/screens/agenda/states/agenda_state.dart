part of 'agenda_cubit.dart';

enum AgendaStatus { initial, loading, ready, cacheReady, dateUpdated, error }

class AgendaState {
  AgendaStatus status;
  List<DayModel> dayModels;
  DateTime wantedDate;

  AgendaState({
    this.status = AgendaStatus.initial,
    this.dayModels = const [],
    required this.wantedDate,
  });

  AgendaState copyWith({
    AgendaStatus? status,
    List<DayModel>? dayModels,
    DateTime? wantedDate,
  }) {
    return AgendaState(
      status: status ?? this.status,
      dayModels: dayModels ?? this.dayModels,
      wantedDate: wantedDate ?? this.wantedDate,
    );
  }
}
