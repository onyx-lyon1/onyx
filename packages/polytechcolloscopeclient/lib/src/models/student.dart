import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
import 'package:polytechcolloscopeclient/src/models/year.dart';

part 'generated/student.g.dart';

@CopyWith()
@HiveType(typeId: 44)
class Student extends Equatable {
  @HiveField(0)
  final Year year;
  @HiveField(1)
  final String name;
  @HiveField(2)
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
