import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

part 'school_subject_model.g.dart';

@HiveType(typeId: 10)
class SchoolSubjectModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<TeacherModel> masters;
  @HiveField(2)
  final List<GradeModel> grades;
  @HiveField(4)
  final bool isSeen;
  @HiveField(5)
  final bool isHidden;

  SchoolSubjectModel({
    required this.isSeen,
    required this.isHidden,
    required this.name,
    required this.masters,
    required this.grades,
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
  String toString() {
    return 'SchoolSubjectModel{name: $name, masters: $masters, grades: $grades, isSeen: $isSeen, isHidden: $isHidden}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchoolSubjectModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          listEquals(masters, other.masters);

  @override
  int get hashCode => name.hashCode ^ masters.hashCode;
}
