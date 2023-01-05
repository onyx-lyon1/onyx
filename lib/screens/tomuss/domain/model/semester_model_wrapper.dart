import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/screens/tomuss/domain/model/semester_model.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

part 'semester_model_wrapper.g.dart';

@HiveType(typeId: 14)
class SemesterModelWrapper {
  @HiveField(0)
  late List<SemesterModel> semesters;
  @HiveField(1)
  final int currentSemesterIndex;

  SemesterModelWrapper(this.semesters, {this.currentSemesterIndex = 0});

  @override
  String toString() {
    return 'SemesterModelWrapper{semesters: $semesters currenSemesterIndex: $currentSemesterIndex} ';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemesterModelWrapper &&
          runtimeType == other.runtimeType &&
          currentSemesterIndex == other.currentSemesterIndex &&
          listEquals(semesters, other.semesters);

  @override
  int get hashCode => semesters.hashCode ^ currentSemesterIndex.hashCode;
}
