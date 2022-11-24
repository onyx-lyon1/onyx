import 'package:hive_flutter/adapters.dart';
import 'package:oloid2/screens/agenda/agenda_includes.dart';

part 'day_model_wrapper.g.dart';

@HiveType(typeId: 10)
class DayModelWrapper {
  @HiveField(0)
  late List<DayModel> dayModels;

  DayModelWrapper(this.dayModels);
}
