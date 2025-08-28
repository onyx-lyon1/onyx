import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';

part 'generated/student.g.dart';

@CopyWith()
@HiveType(typeId: 43)
class Student extends Equatable {
  @HiveField(0, defaultValue: "")
  late final String name;

  @HiveField(1, defaultValue: "")
  late final String surname;

  @HiveField(2, defaultValue: "")
  late final String email;

  Student.fromJSON(var json) {
    name = json[0] ?? "";
    surname = json[1] ?? "";
    email = json[2] ?? "";
  }

  Student(this.name, this.surname, this.email);

  @override
  List<Object?> get props => [name, surname, email];

  @override
  bool? get stringify => true;
}
