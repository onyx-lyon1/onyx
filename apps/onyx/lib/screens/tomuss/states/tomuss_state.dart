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

class TomussState extends Equatable {
  final TomussStatus status;
  final List<TeachingUnit> teachingUnits;
  final List<Semester> semesters;
  final int currentSemesterIndex;
  final Duration? timeout;
  final List<
      ({
        TeachingUnitElement teachingUnitElement,
        TeachingUnit teachingUnit
      })> newElements;

  @override
  List<Object?> get props => [
        status,
        teachingUnits,
        semesters,
        currentSemesterIndex,
        timeout,
        newElements,
      ];

  @override
  bool get stringify => true;

  const TomussState(
      {this.status = TomussStatus.initial,
      this.teachingUnits = const [],
      this.semesters = const [],
      this.currentSemesterIndex = 0,
      this.timeout,
      this.newElements = const []});

  TomussState copyWith(
      {TomussStatus? status,
      List<TeachingUnit>? teachingUnits,
      List<Semester>? semesters,
      int? currentSemesterIndex,
      Duration? timeout,
      List<
              ({
                TeachingUnitElement teachingUnitElement,
                TeachingUnit teachingUnit
              })>?
          newElements}) {
    return TomussState(
        status: status ?? this.status,
        teachingUnits: teachingUnits ?? this.teachingUnits,
        semesters: semesters ?? this.semesters,
        currentSemesterIndex: currentSemesterIndex ?? this.currentSemesterIndex,
        timeout: timeout ?? this.timeout,
        newElements: newElements ?? this.newElements);
  }
}
