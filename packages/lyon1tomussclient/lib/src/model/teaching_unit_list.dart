import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit.dart';
import 'package:equatable/equatable.dart';

part 'teaching_unit_list.mapper.dart';

@MappableClass()
class TeachingUnitList extends Equatable {
  final List<TeachingUnit> teachingUnitModels;
  final int semesterIndex;

  TeachingUnitList(this.teachingUnitModels, this.semesterIndex);

  @override
  List<Object?> get props => [teachingUnitModels, semesterIndex];

  @override
  bool? get stringify => true;
}
