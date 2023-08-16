import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:lyon1tomussclient/src/utils/stringcasing.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'generated/teacher.g.dart';

@CopyWith()
@HiveType(typeId: 12)
class Teacher extends Equatable {
  @HiveField(0, defaultValue: "")
  late final String name;
  @HiveField(1, defaultValue: "")
  late final String email;
  Teacher.fromJSON(var json) {
    name = "${Capitalize.to(json[0])} ${json[1] ?? ''}"; // Firstname LASTNAME
    email = json[2] ?? ""; // firstname.lastname@domain.ext
  }

  Teacher(this.name, this.email);

  @override
  List<Object?> get props => [name, email];
  @override
  bool? get stringify => true;
}
