part of 'tomuss_cubit.dart';

@MappableEnum()
enum TomussStatus {
  @MappableValue(000)
  initial,
  @MappableValue(100)
  loading,
  @MappableValue(200)
  cacheReady,
  @MappableValue(300)
  ready,
  @MappableValue(400)
  error,
  @MappableValue(500)
  updated,
  @MappableValue(600)
  timeout
}

@MappableClass()
class TomussState with TomussStateMappable {
  final TomussStatus status;
  final List<Semester> semesters;
  final int currentSemesterIndex;
  final Duration? timeout;
  final List<
      ({
        TeachingUnitElement teachingUnitElement,
        TeachingUnit teachingUnit
      })> newElements;

  const TomussState(
      {this.status = TomussStatus.initial,
      this.semesters = const [],
      this.currentSemesterIndex = 0,
      this.timeout,
      this.newElements = const []});

  List<TeachingUnit> get teachingUnits => semesters[currentSemesterIndex].teachingUnits;

}
