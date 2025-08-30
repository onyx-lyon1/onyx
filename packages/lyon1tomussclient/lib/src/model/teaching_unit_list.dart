import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit.dart';

part 'generated/teaching_unit_list.mapper.dart';

@MappableClass()
class TeachingUnitList with TeachingUnitListMappable {
  final List<TeachingUnit> teachingUnitModels;
  final int semesterIndex;

  TeachingUnitList(this.teachingUnitModels, this.semesterIndex);
}
