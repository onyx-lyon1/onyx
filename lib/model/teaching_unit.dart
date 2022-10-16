// ignore_for_file: unnecessary_overrides

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:oloid2/model/grade_model.dart';
import 'package:oloid2/model/text_model.dart';

import 'teacher_model.dart';

part 'teaching_unit.g.dart';

@HiveType(typeId: 8)
class TeachingUnitModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<TeacherModel> masters;
  @HiveField(2)
  final List<GradeModel> grades;
  @HiveField(3)
  final List<TextModel> textValues;

  @HiveField(4)
  final bool isSeen;
  @HiveField(5)
  final bool isHidden;

  TeachingUnitModel({
    required this.isSeen,
    required this.isHidden,
    required this.name,
    required this.masters,
    required this.grades,
    required this.textValues,
  });

  String mastersShort() {
    String mastersStr = "";
    for (TeacherModel m in masters) {
      mastersStr += '${m.name.split(" ")[1]}, ';
    }
    return masters.length > 2
        ? mastersStr.substring(0, masters.length - 2)
        : mastersStr;
  }

  GradeModel? latestGrade() {
    return grades.isNotEmpty ? grades.first : null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeachingUnitModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          listEquals(masters, other.masters) &&
          listEquals(grades, other.grades) &&
          listEquals(textValues, other.textValues) &&
          isSeen == other.isSeen &&
          isHidden == other.isHidden;

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() {
    return 'TeachingUnitModel{name: $name, masters: $masters, grades: $grades, textValues: $textValues, isSeen: $isSeen, isHidden: $isHidden}';
  }
}
