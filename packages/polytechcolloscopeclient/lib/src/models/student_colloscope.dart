import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:polytechcolloscopeclient/polytechcolloscopeclient.dart';

part 'generated/student_colloscope.g.dart';

@CopyWith()
class StudentColloscope extends Equatable {
  final Student student;
  final int trinomeId;
  final List<Kholle> kholles;

  StudentColloscope(this.student, this.trinomeId, this.kholles);

  static StudentColloscope empty() {
    return StudentColloscope(Student.empty(), 0, []);
  }

  @override
  List<Object?> get props => [student, trinomeId, kholles];

  @override
  bool? get stringify => true;
}
