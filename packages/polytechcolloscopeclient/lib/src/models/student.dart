import 'package:dart_mappable/dart_mappable.dart';

import '../consts.dart';

part 'student.mapper.dart';

@MappableClass()
class Student with StudentMappable {
  final Year year;
  final String name;
  final int id;

  Student(this.year, this.name, this.id);
}
