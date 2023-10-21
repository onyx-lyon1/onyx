import 'package:equatable/equatable.dart';
import 'package:polytechcolloscopeclient/src/models/student.dart';

class StudentColloscope extends Equatable {
  final Student student;
  final int trinomeId;
  final List kholles;

  StudentColloscope(this.student, this.trinomeId, this.kholles);

  @override
  List<Object?> get props => [student, trinomeId, kholles];

  @override
  bool? get stringify => true;
}
