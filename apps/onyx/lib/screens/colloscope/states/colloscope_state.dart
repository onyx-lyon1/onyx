part of 'colloscope_cubit.dart';

enum ColloscopeStatus {
  initial,
  gatheringColloscopeData,
  error,
  ready,
}

class ColloscopeState extends Equatable {
  final ColloscopeStatus status;
  final StudentColloscope? studentColloscope;

  final bool reloadScheduled;

  const ColloscopeState(
      {required this.status,
      required this.studentColloscope,
      required this.reloadScheduled});

  ColloscopeState copyWith(
      {ColloscopeStatus? status,
      StudentColloscope? studentColloscope,
      bool? reloadScheduled}) {
    return ColloscopeState(
        status: status ?? this.status,
        studentColloscope: studentColloscope ?? this.studentColloscope,
        reloadScheduled: reloadScheduled ?? this.reloadScheduled);
  }

  @override
  List<Object?> get props => [status, studentColloscope, reloadScheduled];

  @override
  bool? get stringify => true;
}
