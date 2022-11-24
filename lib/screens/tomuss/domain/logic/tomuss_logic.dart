import 'package:dartus/tomuss.dart';
import 'package:oloid2/screens/tomuss/tomuss_export.dart';

class GradesLogic {
  static Future<List<SchoolSubjectModel>> getGrades(
      {required Dartus dartus}) async {
    List<SchoolSubjectModel> tmpTeachingUnits = [];
    ParsedPage? parsedPageOpt =
        await dartus.getParsedPage(Dartus.currentSemester());
    if (parsedPageOpt == null) {
      throw Exception('Error while getting grades page empty');
    }
    final ParsedPage parsedPage = parsedPageOpt;
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
