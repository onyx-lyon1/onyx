import 'package:hive_flutter/adapters.dart';
import 'package:oloid2/model/teaching_unit.dart';

part 'teaching_unit_model_wrapper.g.dart';

@HiveType(typeId: 12)
class TeachingUnitModelWrapper {
  @HiveField(0)
  late List<TeachingUnitModel> teachingUnitModels;

  TeachingUnitModelWrapper(this.teachingUnitModels);
}
