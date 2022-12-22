import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/screens/agenda/agenda_export.dart';

part 'day_model_wrapper.g.dart';

@HiveType(typeId: 2)
class DayModelWrapper {
  @HiveField(0)
  late List<DayModel> dayModels;

  DayModelWrapper(this.dayModels);

  @override
  String toString() {
    return 'DayModelWrapper{dayModels: $dayModels}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayModelWrapper &&
          runtimeType == other.runtimeType &&
          listEquals(dayModels, other.dayModels);

  @override
  int get hashCode => dayModels.hashCode;
}
