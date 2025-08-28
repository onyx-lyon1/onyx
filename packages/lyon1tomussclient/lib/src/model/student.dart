import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'generated/student.g.dart';

@CopyWith()
class Student extends Equatable {
  late final String name;

  late final String surname;

  late final String email;

  Student.fromJSON(var json) {
    name = json[0] ?? "";
    surname = json[1] ?? "";
    email = json[2] ?? "";
  }

  Student({
    this.name = "",
    this.surname = "",
    this.email = "",
  });

  @override
  List<Object?> get props => [name, surname, email];

  @override
  bool? get stringify => true;
}
