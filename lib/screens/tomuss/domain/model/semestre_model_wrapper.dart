import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/screens/tomuss/domain/model/semestre_model.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

part 'generated/semestre_model_wrapper.g.dart';

@HiveType(typeId: 14)
class SemestreModelWrapper {
  @HiveField(0)
  late List<SemestreModel> semestres;
  @HiveField(1)
  final int currentSemestreIndex;

  SemestreModelWrapper(this.semestres, {this.currentSemestreIndex = 0});

  @override
  String toString() {
    return 'SemesterModelWrapper{semesters: $semestres currenSemesterIndex: $currentSemestreIndex} ';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemestreModelWrapper &&
          runtimeType == other.runtimeType &&
          currentSemestreIndex == other.currentSemestreIndex &&
          listEquals(semestres, other.semestres);

  @override
  int get hashCode => semestres.hashCode ^ currentSemestreIndex.hashCode;
}
