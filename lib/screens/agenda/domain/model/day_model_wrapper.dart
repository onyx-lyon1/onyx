import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/screens/agenda/agenda_export.dart';

part 'day_model_wrapper.g.dart';

@HiveType(typeId: 2)
class DayModelWrapper {
  @HiveField(0)
  late List<DayModel> dayModels;

  DayModelWrapper(this.dayModels);
}
