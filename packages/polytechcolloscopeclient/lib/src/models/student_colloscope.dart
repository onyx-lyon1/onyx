import 'package:dart_mappable/dart_mappable.dart';
import 'package:polytechcolloscopeclient/polytechcolloscopeclient.dart';

part 'generated/student_colloscope.mapper.dart';

@MappableClass()
class StudentColloscope with StudentColloscopeMappable {
  final Student student;
  final int trinomeId;
  final List<Kholle> kholles;

  StudentColloscope(this.student, this.trinomeId, this.kholles);

  static StudentColloscope empty() {
    return StudentColloscope(Student.empty(), 0, []);
  }
}
