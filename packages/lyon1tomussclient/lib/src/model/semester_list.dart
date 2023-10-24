import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/model/semester.dart';

part 'semester_list.mapper.dart';

@MappableClass()
class SemesterList with SemesterListMappable {
  final List<Semester> semestres;
  final int currentSemesterIndex;

  SemesterList(this.semestres, {this.currentSemesterIndex = 0});
}
