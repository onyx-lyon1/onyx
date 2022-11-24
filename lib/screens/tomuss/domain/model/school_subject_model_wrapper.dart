import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/screens/tomuss/tomuss_export.dart';

part 'school_subject_model_wrapper.g.dart';

@HiveType(typeId: 12)
class SchoolSubjectModelWrapper {
  @HiveField(0)
  late List<SchoolSubjectModel> teachingUnitModels;

  SchoolSubjectModelWrapper(this.teachingUnitModels);
}
