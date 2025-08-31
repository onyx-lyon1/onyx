import 'package:dart_mappable/dart_mappable.dart';

part 'generated/student.mapper.dart';

@MappableClass()
class Student with StudentMappable {
  late final String name;
  late final String surname;
  late final String email;

  Student.fromJSON(List<dynamic> json) {
    name = json[0] ?? "";
    surname = json[1] ?? "";
    email = json[2] ?? "";
  }

  @MappableConstructor()
  Student({this.name = "", this.surname = "", this.email = ""});
}
