import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:lyon1tomussclient/src/model/semester.dart';
import 'package:equatable/equatable.dart';

part 'generated/semester_list.g.dart';

@CopyWith()
class SemesterList extends Equatable {
  final List<Semester> semestres;
  final int currentSemesterIndex;

  SemesterList(this.semestres, {this.currentSemesterIndex = 0});

  @override
  List<Object?> get props => [semestres, currentSemesterIndex];

  @override
  bool? get stringify => true;
}
