import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:lyon1tomussclient/src/model/semester.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';

part 'generated/semester_list.g.dart';

@CopyWith()
@HiveType(typeId: 14)
class SemesterList extends Equatable {
  @HiveField(0)
  final List<Semester> semestres;
  @HiveField(1)
  final int currentSemesterIndex;

  SemesterList(this.semestres, {this.currentSemesterIndex = 0});

  @override
  List<Object?> get props => [semestres, currentSemesterIndex];

  @override
  bool? get stringify => true;
}
