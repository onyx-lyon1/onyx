import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';

part 'generated/teaching_unit_list.g.dart';

@CopyWith()
@HiveType(typeId: 11)
class TeachingUnitList extends Equatable {
  @HiveField(0)
  final List<TeachingUnit> teachingUnitModels;
  @HiveField(1)
  final int semesterIndex;

  TeachingUnitList(this.teachingUnitModels, this.semesterIndex);

  @override
  List<Object?> get props => [teachingUnitModels, semesterIndex];

  @override
  bool? get stringify => true;
}
