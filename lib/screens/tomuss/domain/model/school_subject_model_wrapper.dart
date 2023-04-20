import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

part 'generated/school_subject_model_wrapper.g.dart';

@HiveType(typeId: 11)
class SchoolSubjectModelWrapper {
  @HiveField(0)
  late List<SchoolSubjectModel> teachingUnitModels;
  @HiveField(1)
  final int semesterIndex;

  SchoolSubjectModelWrapper(this.teachingUnitModels, this.semesterIndex);

  @override
  String toString() {
    return 'SchoolSubjectModelWrapper{teachingUnitModels: $teachingUnitModels , semesterIndex: $semesterIndex}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchoolSubjectModelWrapper &&
          runtimeType == other.runtimeType &&
          listEquals(teachingUnitModels, other.teachingUnitModels) &&
          semesterIndex == other.semesterIndex;

  @override
  int get hashCode => teachingUnitModels.hashCode ^ semesterIndex.hashCode;
}
