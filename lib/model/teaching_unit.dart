import 'package:oloid2/model/grade_model.dart';
import 'package:oloid2/model/text_model.dart';

import 'teacher_model.dart';

class TeachingUnitModel {
  final String name;
  final List<TeacherModel> masters;
  final List<GradeModel> grades;
  final List<TextModel> textValues;

  final bool isSeen;
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
}
