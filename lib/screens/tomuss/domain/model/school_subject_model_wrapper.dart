import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/screens/tomuss/tomuss_export.dart';

part 'school_subject_model_wrapper.g.dart';

@HiveType(typeId: 11)
class SchoolSubjectModelWrapper {
  @HiveField(0)
  late List<SchoolSubjectModel> teachingUnitModels;

  SchoolSubjectModelWrapper(this.teachingUnitModels);

  @override
  String toString() {
    return 'SchoolSubjectModelWrapper{teachingUnitModels: $teachingUnitModels}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchoolSubjectModelWrapper &&
          runtimeType == other.runtimeType &&
          listEquals(teachingUnitModels, other.teachingUnitModels);

  @override
  int get hashCode => teachingUnitModels.hashCode;
}
