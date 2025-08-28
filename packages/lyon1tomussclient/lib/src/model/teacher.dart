import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:lyon1tomussclient/src/utils/stringcasing.dart';

part 'generated/teacher.g.dart';

@CopyWith()
class Teacher extends Equatable {
  late final String name;
  late final String email;

  Teacher.fromJSON(var json) {
    name =
        "${json[0].toString().capitalize} ${json[1] ?? ''}"; // Firstname LASTNAME
    email = json[2] ?? ""; // firstname.lastname@domain.ext
  }

  Teacher({
    this.name = "",
    this.email = "",
  });

  @override
  List<Object?> get props => [name, email];

  @override
  bool? get stringify => true;
}
