part of 'tomuss_cubit.dart';

enum TomussStatus {
  initial,
  loading,
  cacheReady,
  ready,
  error,
  updated,
  timeout
}

class TomussState {
  final TomussStatus status;
  final List<TeachingUnit> teachingUnits;
  final List<Semester> semesters;
  final int currentSemesterIndex;
  final Duration? timeout;
  final List<Grade> newGrades;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TomussState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          teachingUnits == other.teachingUnits &&
          semesters == other.semesters &&
          currentSemesterIndex == other.currentSemesterIndex &&
          newGrades == other.newGrades &&
          timeout == other.timeout;

  @override
  int get hashCode =>
      status.hashCode ^
      teachingUnits.hashCode ^
      semesters.hashCode ^
      currentSemesterIndex.hashCode ^
      newGrades.hashCode ^
      timeout.hashCode;

  TomussState({
    this.status = TomussStatus.initial,
    this.teachingUnits = const [],
    this.semesters = const [],
    this.currentSemesterIndex = 0,
    this.timeout,
    this.newGrades = const [],
  });

  @override
  String toString() {
    return 'TomussState{status: $status, teachingUnits: $teachingUnits, semesters: $semesters, currentSemesterIndex: $currentSemesterIndex, timeout: $timeout}';
  }

  TomussState copyWith(
      {TomussStatus? status,
      List<TeachingUnit>? teachingUnits,
      List<Semester>? semesters,
      int? currentSemesterIndex,
      Duration? timeout,
      List<Grade>? newGrades}) {
    return TomussState(
      status: status ?? this.status,
      teachingUnits: teachingUnits ?? this.teachingUnits,
      semesters: semesters ?? this.semesters,
      currentSemesterIndex: currentSemesterIndex ?? this.currentSemesterIndex,
      timeout: timeout ?? this.timeout,
      newGrades: newGrades ?? this.newGrades,
    );
  }
}
