part of 'tomuss_cubit.dart';

enum TomussStatus { initial, loading, cacheReady, ready, error }

class TomussState {
  final TomussStatus status;
  final List<SchoolSubjectModel> teachingUnits;

  TomussState({
    this.status = TomussStatus.initial,
    this.teachingUnits = const [],
  });

  TomussState copyWith({
    TomussStatus? status,
    List<SchoolSubjectModel>? teachingUnits,
  }) {
    return TomussState(
      status: status ?? this.status,
      teachingUnits: teachingUnits ?? this.teachingUnits,
    );
  }

}
