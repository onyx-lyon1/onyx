part of 'colloscope_cubit.dart';

enum ColloscopeStatus {
  initial,
  loading,
  error,
  ready,
}

class ColloscopeState extends Equatable {
  final ColloscopeStatus status;
  final StudentColloscope? studentColloscope;

  const ColloscopeState(
      {required this.status, required this.studentColloscope});

  ColloscopeState copyWith(
      {ColloscopeStatus? status, StudentColloscope? studentColloscope}) {
    return ColloscopeState(
        status: status ?? this.status,
        studentColloscope: studentColloscope ?? this.studentColloscope);
  }

  @override
  List<Object?> get props => [status, studentColloscope];

  @override
  bool? get stringify => true;
}
