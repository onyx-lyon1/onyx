import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit.dart';
import 'package:equatable/equatable.dart';

part 'generated/teaching_unit_list.g.dart';

@CopyWith()
class TeachingUnitList extends Equatable {
  final List<TeachingUnit> teachingUnitModels;
  final int semesterIndex;

  TeachingUnitList(this.teachingUnitModels, this.semesterIndex);

  @override
  List<Object?> get props => [teachingUnitModels, semesterIndex];

  @override
  bool? get stringify => true;
}
