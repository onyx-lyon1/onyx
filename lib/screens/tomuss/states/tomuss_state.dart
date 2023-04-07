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
  final List<SchoolSubjectModel> teachingUnits;
  final List<SemestreModel> semesters;
  final int currentSemesterIndex;
  final Duration? timeout;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TomussState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          teachingUnits == other.teachingUnits &&
          semesters == other.semesters &&
          currentSemesterIndex == other.currentSemesterIndex &&
          timeout == other.timeout;

  @override
  int get hashCode =>
      status.hashCode ^
      teachingUnits.hashCode ^
      semesters.hashCode ^
      currentSemesterIndex.hashCode ^
      timeout.hashCode;

  TomussState({
    this.status = TomussStatus.initial,
    this.teachingUnits = const [],
    this.semesters = const [],
    this.currentSemesterIndex = 0,
    this.timeout,
  });

  @override
  String toString() {
    return 'TomussState{status: $status, teachingUnits: $teachingUnits, semesters: $semesters, currentSemesterIndex: $currentSemesterIndex, timeout: $timeout}';
  }

  TomussState copyWith(
      {TomussStatus? status,
      List<SchoolSubjectModel>? teachingUnits,
      List<SemestreModel>? semesters,
      int? currentSemesterIndex,
      Duration? timeout}) {
    return TomussState(
      status: status ?? this.status,
      teachingUnits: teachingUnits ?? this.teachingUnits,
      semesters: semesters ?? this.semesters,
      currentSemesterIndex: currentSemesterIndex ?? this.currentSemesterIndex,
      timeout: timeout ?? this.timeout,
    );
  }
}
