import 'package:hive_flutter/adapters.dart';
import 'package:oloid2/screens/tomuss/domain/model/school_subject_model.dart';

part 'school_subject_model_wrapper.g.dart';

@HiveType(typeId: 12)
class SchoolSubjectModelWrapper {
  @HiveField(0)
  late List<SchoolSubjectModel> teachingUnitModels;

  SchoolSubjectModelWrapper(this.teachingUnitModels);
}
