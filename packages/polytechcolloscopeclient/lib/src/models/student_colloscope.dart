import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:polytechcolloscopeclient/polytechcolloscopeclient.dart';

part 'generated/student_colloscope.g.dart';

@CopyWith()
@HiveType(typeId: 46)
class StudentColloscope extends Equatable {
  @HiveField(0)
  final Student student;
  @HiveField(1)
  final int trinomeId;
  @HiveField(2)
  final List<Kholle> kholles;

  StudentColloscope(this.student, this.trinomeId, this.kholles);

  static empty() {
    return StudentColloscope(Student.empty(), 0, []);
  }

  @override
  List<Object?> get props => [student, trinomeId, kholles];

  @override
  bool? get stringify => true;
}
