import 'package:dart_mappable/dart_mappable.dart';
import 'package:polytechcolloscopeclient/src/models/year.dart';

part 'generated/student.mapper.dart';

@MappableClass()
class Student with StudentMappable {
  final Year year;
  final String name;
  final int id;

  Student(this.year, this.name, this.id);

  static Student empty() {
    return Student(Year.first, "", 0);
  }
}
