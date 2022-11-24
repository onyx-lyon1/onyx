// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:dartus/src/parser/parsedpage.dart';
import 'package:dartus/tomuss.dart';
import 'package:dartz/dartz.dart';
import 'package:oloid2/screens/tomuss/domain/model/grade_model.dart';
import 'package:oloid2/screens/tomuss/domain/model/teacher_model.dart';
import 'package:oloid2/screens/tomuss/domain/model/school_subject_model.dart';

class GradesLogic {
  static Future<List<SchoolSubjectModel>> getGrades(
      {required Dartus dartus}) async {
    List<SchoolSubjectModel> tmpTeachingUnits = [];
    Option<ParsedPage> parsedPageOpt =
        await dartus.getParsedPage(Dartus.currentSemester());
    if (parsedPageOpt.isNone()) {
      throw Exception('Error while getting grades page empty');
    }
    final ParsedPage parsedPage =
        parsedPageOpt.getOrElse(() => ParsedPage.empty());
    for (final TeachingUnit tu in parsedPage.teachingunits) {
      tmpTeachingUnits.add(SchoolSubjectModel(
          isSeen: false,
          isHidden: false,
          name: tu.name,
          masters: tu.masters.map((e) => TeacherModel.fromTeacher(e)).toList(),
          grades: tu.grades.map((e) => GradeModel.fromGrade(e)).toList()));
    }
    return tmpTeachingUnits;
  }
}
