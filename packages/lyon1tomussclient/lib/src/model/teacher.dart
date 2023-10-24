import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/utils/stringcasing.dart';

part 'teacher.mapper.dart';

@MappableClass()
class Teacher with TeacherMappable {
  late final String name;
  late final String email;

  Teacher.fromJSON(var json) {
    name = "${Capitalize.to(json[0])} ${json[1] ?? ''}"; // Firstname LASTNAME
    email = json[2] ?? ""; // firstname.lastname@domain.ext
  }

  Teacher(this.name, this.email);

  @MappableConstructor()
  Teacher.mappableConstruct({
    this.name = "",
    this.email = "",
  });
}
