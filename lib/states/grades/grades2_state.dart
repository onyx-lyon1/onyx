part of 'grades2_cubit.dart';

enum GradesStatus { initial, loading, cacheReady, ready, error }

class GradesState {
  final GradesStatus status;
  final List<TeachingUnitModel> teachingUnits;

  GradesState({
    this.status = GradesStatus.initial,
    this.teachingUnits = const [],
  });

  GradesState copyWith({
    GradesStatus? status,
    List<TeachingUnitModel>? teachingUnits,
  }) {
    return GradesState(
      status: status ?? this.status,
      teachingUnits: teachingUnits ?? this.teachingUnits,
    );
  }

}
