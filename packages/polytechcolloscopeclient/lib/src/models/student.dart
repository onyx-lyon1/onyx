import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:polytechcolloscopeclient/src/models/year.dart';

part 'generated/student.g.dart';

@CopyWith()
class Student extends Equatable {
  final Year year;
  final String name;
  final int id;

  Student(this.year, this.name, this.id);

  static Student empty() {
    return Student(Year.first, "", 0);
  }

  @override
  List<Object?> get props => [year, name, id];

  @override
  bool? get stringify => true;
}
