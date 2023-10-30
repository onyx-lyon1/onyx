import 'package:dart_mappable/dart_mappable.dart';
import 'package:polytechcolloscopeclient/src/models/student.dart';

part 'student_colloscope.mapper.dart';

@MappableClass()
class StudentColloscope with StudentColloscopeMappable {
  final Student student;
  final int trinomeId;
  final List kholles;

  StudentColloscope(this.student, this.trinomeId, this.kholles);
}
