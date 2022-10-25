// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:dartus/tomuss.dart';
import 'package:dartus/src/parser/parsedpage.dart';
import 'package:oloid2/model/grade_model.dart';
import 'package:oloid2/model/teacher_model.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/model/text_model.dart';
import 'package:dartz/dartz.dart';

class GradesBackend{
  static Future<List<TeachingUnitModel>> getGrades({required Dartus dartus}) async {

    List<TeachingUnitModel> tmpTeachingUnits = [];
    Option<ParsedPage> parsedPageOpt =
    await dartus.getParsedPage(Dartus.currentSemester());
    if (parsedPageOpt.isNone()) {
      throw Exception('Error while getting grades page empty');
    }
    final ParsedPage parsedPage =
    parsedPageOpt.getOrElse(() => ParsedPage.empty());
    for (final TeachingUnit tu in parsedPage.teachingunits) {
      tmpTeachingUnits.add(TeachingUnitModel(
          isSeen: false,
          isHidden: false,
          name: tu.name,
          masters: tu.masters.map((e) => TeacherModel.fromTeacher(e)).toList(),
          grades: tu.grades.map((e) => GradeModel.fromGrade(e)).toList(),
          textValues:
          tu.textValues.map((e) => TextModel.fromText(e)).toList()));
    }
    return tmpTeachingUnits;
  }
}