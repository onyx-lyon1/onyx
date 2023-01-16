part of 'tomuss_cubit.dart';

enum TomussStatus { initial, loading, cacheReady, ready, error, updated }

class TomussState {
  final TomussStatus status;
  final List<SchoolSubjectModel> teachingUnits;
  final List<SemestreModel> semesters;
  final int currentSemesterIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TomussState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          teachingUnits == other.teachingUnits &&
          semesters == other.semesters &&
          currentSemesterIndex == other.currentSemesterIndex;

  @override
  int get hashCode =>
      status.hashCode ^
      teachingUnits.hashCode ^
      semesters.hashCode ^
      currentSemesterIndex.hashCode;

  TomussState({
    this.status = TomussStatus.initial,
    this.teachingUnits = const [],
    this.semesters = const [],
    this.currentSemesterIndex = 0,
  });

  @override
  String toString() {
    return 'TomussState{status: $status, teachingUnits: $teachingUnits, semesters: $semesters, currentSemesterIndex: $currentSemesterIndex}';
  }

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
