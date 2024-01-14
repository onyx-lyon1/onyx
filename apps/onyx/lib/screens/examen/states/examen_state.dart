part of 'examen_cubit.dart';

enum ExamenStatus {
  initial,
  loading,
  error,
  ready,
}

class ExamenState extends Equatable {
  final ExamenStatus status;
  final StudentColloscope? studentColloscope;
  final List<ExamenModel> examens;

  final bool reloadScheduled;

  const ExamenState({
    required this.status,
    required this.studentColloscope,
    required this.reloadScheduled,
    required this.examens,
  });

  ExamenState copyWith({
    ExamenStatus? status,
    StudentColloscope? studentColloscope,
    bool? reloadScheduled,
    List<ExamenModel>? examens,
  }) {
    return ExamenState(
      status: status ?? this.status,
      studentColloscope: studentColloscope ?? this.studentColloscope,
      reloadScheduled: reloadScheduled ?? this.reloadScheduled,
      examens: examens ?? this.examens,
    );
  }

  @override
  List<Object?> get props =>
      [status, studentColloscope, reloadScheduled, examens];

  @override
  bool? get stringify => true;
}
