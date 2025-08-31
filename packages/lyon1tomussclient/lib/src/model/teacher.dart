import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/utils/stringcasing.dart';

part 'generated/teacher.mapper.dart';

@MappableClass()
class Teacher with TeacherMappable {
  late final String name;
  late final String email;

  Teacher.fromJSON(List<dynamic> json) {
    name =
        "${json[0].toString().capitalize} ${json[1] ?? ''}"; // Firstname LASTNAME
    email = json[2] ?? ""; // firstname.lastname@domain.ext
  }

  @MappableConstructor()
  Teacher({this.name = "", this.email = ""});
}
