part of 'tomuss_cubit.dart';

enum TomussStatus { initial, loading, cacheReady, ready, error, updated }

class TomussState {
  final TomussStatus status;
  final List<SchoolSubjectModel> teachingUnits;
  final List<SemestreModel> semesters;
  final int currentSemesterIndex;

  TomussState({
    this.status = TomussStatus.initial,
    this.teachingUnits = const [],
    this.semesters = const [],
    this.currentSemesterIndex = 0,
  });

  TomussState copyWith({
    TomussStatus? status,
    List<SchoolSubjectModel>? teachingUnits,
    List<SemestreModel>? semesters,
    int? currentSemesterIndex,
  }) {
    return TomussState(
      status: status ?? this.status,
      teachingUnits: teachingUnits ?? this.teachingUnits,
      semesters: semesters ?? this.semesters,
      currentSemesterIndex: currentSemesterIndex ?? this.currentSemesterIndex,
    );
  }
}
