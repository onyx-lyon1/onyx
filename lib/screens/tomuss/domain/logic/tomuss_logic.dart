import 'package:dartus/tomuss.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

class GetCacheDataPass {
  final String path;
  final int currentSemestreIndex;

  GetCacheDataPass(this.path, this.currentSemestreIndex);
}

class TomussLogic {
  static Future<List<Semester>> getSemesters(Dartus dartus) async {
    if (Res.mock) {
      return [Semester("2022/Automne", Dartus.currentSemester())];
    }
    return (await dartus.getParsedPage(Dartus.currentSemester()))?.semesters ??
        [];
  }

  static Future<List<SchoolSubjectModel>> getGrades(
      {required Dartus dartus,
      SemestreModel? semestre,
      int semestreIndex = 0}) async {
    if (Res.mock) {
      return schoolSubjectModelListMock;
    }
    List<SchoolSubjectModel> tmpTeachingUnits = [];
    ParsedPage? parsedPageOpt =
        await dartus.getParsedPage(semestre?.url ?? Dartus.currentSemester());
    if (parsedPageOpt == null) {
      throw Exception('Error while getting grades page empty');
    }
    final ParsedPage parsedPage = parsedPageOpt;
    List<SchoolSubjectModel> cachedTeachingUnits = [];
    if ((await CacheService.exist<SchoolSubjectModelWrapper>(
        index: semestreIndex))) {
      cachedTeachingUnits = (await CacheService.get<SchoolSubjectModelWrapper>(
              index: semestreIndex))!
          .teachingUnitModels;
    }

    for (final TeachingUnit tu in parsedPage.teachingunits) {
      tmpTeachingUnits.add(SchoolSubjectModel(
          isSeen: false,
          isHidden: false,
          name: tu.name,
          masters: tu.masters.map((e) => TeacherModel.fromTeacher(e)).toList(),
          grades: tu.grades.map((e) {
            GradeModel tmpGrade = GradeModel.fromGrade(e);
            if (cachedTeachingUnits.any((element) => element.name == tu.name)) {
              SchoolSubjectModel cachedTeachingUnit = cachedTeachingUnits
                  .firstWhere((element) => element.name == tu.name);
              if (cachedTeachingUnit.grades
                  .any((element) => element.name == e.name)) {
                tmpGrade.coef = cachedTeachingUnit.grades
                    .firstWhere((element) => element.name == e.name)
                    .coef;
              }
            }

            return tmpGrade;
          }).toList()));
    }
    return tmpTeachingUnits;
  }

  static Future<List<SchoolSubjectModel>> getTeachingUnitsCache(
      GetCacheDataPass inputData) async {
    if (Res.mock) {
      return schoolSubjectModelListMock;
    }
    await hiveInit(path: inputData.path);
    if (await CacheService.exist<SchoolSubjectModelWrapper>(
        index: inputData.currentSemestreIndex)) {
      return (await CacheService.get<SchoolSubjectModelWrapper>(
              index: inputData.currentSemestreIndex))!
          .teachingUnitModels;
    } else {
      return [];
    }
  }

  static final List<SchoolSubjectModel> schoolSubjectModelListMock = [
    SchoolSubjectModel(
        name: "Algèbre 1 Cursus Prépa",
        masters: [TeacherModel("Frank WAGNER", "wagner@math.univ-lyon1.fr")],
        grades: [
          GradeModel(
              name: "Colle1",
              author: "frank-olaf.wagner",
              gradeNumerator: 12.0,
              gradeDenominator: 20.0,
              rank: 88,
              average: 13.386,
              mediane: 13.0,
              groupSize: 136,
              isValidGrade: true,
              children: []),
          GradeModel(
              name: "Colle2",
              author: "frank-olaf.wagner",
              gradeNumerator: 14.0,
              gradeDenominator: 20.0,
              rank: 37,
              average: 12.511,
              mediane: 12.0,
              groupSize: 135,
              isValidGrade: true,
              children: []),
          GradeModel(
              name: "Colle3",
              author: "frank-olaf.wagner",
              gradeNumerator: 10.0,
              gradeDenominator: 20.0,
              rank: 94,
              average: 12.596,
              mediane: 13.0,
              groupSize: 130,
              isValidGrade: true,
              children: []),
          GradeModel(
              name: "Colle4",
              author: "frank-olaf.wagner",
              gradeNumerator: 11.0,
              gradeDenominator: 20.0,
              rank: 76,
              average: 12.305,
              mediane: 12.0,
              groupSize: 128,
              isValidGrade: true,
              children: []),
          GradeModel(
              name: "Colle5",
              author: "frank-olaf.wagner",
              gradeNumerator: 4.0,
              gradeDenominator: 20.0,
              rank: 124,
              average: 12.352,
              mediane: 13.0,
              groupSize: 128,
              isValidGrade: true,
              children: []),
          GradeModel(
              name: "DS1",
              author: "frank-olaf.wagner",
              gradeNumerator: 10.63,
              gradeDenominator: 16.5,
              rank: 30,
              average: 8.335,
              mediane: 8.0,
              groupSize: 135,
              isValidGrade: true,
              children: []),
          GradeModel(
              name: "DS2",
              author: "frank-olaf.wagner",
              gradeNumerator: 8.5,
              gradeDenominator: 16.0,
              rank: 41,
              average: 7.228,
              mediane: 7.19,
              groupSize: 131,
              isValidGrade: true,
              children: []),
          GradeModel(
              name: "DS3",
              author: "frank-olaf.wagner",
              gradeNumerator: 7.5,
              gradeDenominator: 30.0,
              rank: 53,
              average: 7.143,
              mediane: 7.0,
              groupSize: 129,
              isValidGrade: true,
              children: [])
        ],
        isSeen: false,
        isHidden: false),
    SchoolSubjectModel(
        name: "Compétences Numériques et Préparation PIX - Module 1",
        masters: [
          TeacherModel("Christian TRILLAUD", "christian.trillaud@univ-lyon1.fr")
        ],
        grades: [
          GradeModel(
              name: "TD/comp1.2_5.2/noteQUEST",
              author: "christian.trillaud",
              gradeNumerator: 8.59,
              gradeDenominator: 10.0,
              rank: 354,
              average: 6.495,
              mediane: 7.93,
              groupSize: 1485,
              isValidGrade: true,
              children: []),
          GradeModel(
              name: "TD/comp1.3/note",
              author: "christian.trillaud",
              gradeNumerator: 8.97,
              gradeDenominator: 10.0,
              rank: 433,
              average: 6.676,
              mediane: 8.26,
              groupSize: 1480,
              isValidGrade: true,
              children: [
                GradeModel(
                    name: "TD/comp1.3/noteQUEST",
                    author: "christian.trillaud",
                    gradeNumerator: 8.97,
                    gradeDenominator: 10.0,
                    rank: 376,
                    average: 6.552,
                    mediane: 8.03,
                    groupSize: 1480,
                    isValidGrade: true,
                    children: [])
              ]),
          GradeModel(
              name: "TD/comp3.1/note",
              author: "christian.trillaud",
              gradeNumerator: 9.83,
              gradeDenominator: 10.0,
              rank: 101,
              average: 6.725,
              mediane: 8.28,
              groupSize: 1483,
              isValidGrade: true,
              children: []),
          GradeModel(
              name: "compétences/ECUE-PIX/Moyenne_ECUE",
              author: "christian.trillaud",
              gradeNumerator: 14.317,
              gradeDenominator: 20.0,
              rank: 771,
              average: 12.205,
              mediane: 14.457,
              groupSize: 1480,
              isValidGrade: true,
              children: [
                GradeModel(
                    name: "compétences/comp1.3/note",
                    author: "christian.trillaud",
                    gradeNumerator: 13.57,
                    gradeDenominator: 20.0,
                    rank: 830,
                    average: 12.171,
                    mediane: 14.16,
                    groupSize: 1484,
                    isValidGrade: true,
                    children: [
                      GradeModel(
                          name: "TD/PIX_TEST/notePIX1.3",
                          author: "christian.trillaud",
                          gradeNumerator: 4.6,
                          gradeDenominator: 10.0,
                          rank: 1023,
                          average: 5.175,
                          mediane: 6.2,
                          groupSize: 1484,
                          isValidGrade: true,
                          children: []),
                      GradeModel(
                          name: "TD/comp1.3/noteFinale",
                          author: "christian.trillaud",
                          gradeNumerator: 8.97,
                          gradeDenominator: 10.0,
                          rank: 433,
                          average: 6.979,
                          mediane: 8.26,
                          groupSize: 1479,
                          isValidGrade: true,
                          children: [])
                    ]),
                GradeModel(
                    name: "compétences/comp3.1/note",
                    author: "christian.trillaud",
                    gradeNumerator: 13.13,
                    gradeDenominator: 20.0,
                    rank: 907,
                    average: 12.176,
                    mediane: 14.27,
                    groupSize: 1485,
                    isValidGrade: true,
                    children: [
                      GradeModel(
                          name: "TD/PIX_TEST/notePIX3.1",
                          author: "christian.trillaud",
                          gradeNumerator: 3.3,
                          gradeDenominator: 10.0,
                          rank: 1140,
                          average: 5.234,
                          mediane: 6.1,
                          groupSize: 1484,
                          isValidGrade: true,
                          children: []),
                      GradeModel(
                          name: "TD/comp3.1/noteFinale",
                          author: "christian.trillaud",
                          gradeNumerator: 9.83,
                          gradeDenominator: 10.0,
                          rank: 101,
                          average: 6.927,
                          mediane: 8.28,
                          groupSize: 1482,
                          isValidGrade: true,
                          children: [])
                    ]),
                GradeModel(
                    name: "compétences/comp1.2-5.2/note",
                    author: "christian.trillaud",
                    gradeNumerator: 16.79,
                    gradeDenominator: 20.0,
                    rank: 407,
                    average: 12.882,
                    mediane: 15.68,
                    groupSize: 1481,
                    isValidGrade: true,
                    children: [
                      GradeModel(
                          name: "TD/PIX_TEST/notePIX1.2-5.2",
                          author: "christian.trillaud",
                          gradeNumerator: 8.2,
                          gradeDenominator: 10.0,
                          rank: 457,
                          average: 6.215,
                          mediane: 7.7,
                          groupSize: 1484,
                          isValidGrade: true,
                          children: []),
                      GradeModel(
                          name: "TD/comp1.2_5.2/noteFinale",
                          author: "christian.trillaud",
                          gradeNumerator: 8.59,
                          gradeDenominator: 10.0,
                          rank: 423,
                          average: 6.634,
                          mediane: 8.04,
                          groupSize: 1478,
                          isValidGrade: true,
                          children: [])
                    ]),
                GradeModel(
                    name: "compétences/comp4.1/note",
                    author: "christian.trillaud",
                    gradeNumerator: 13.78,
                    gradeDenominator: 20.0,
                    rank: 787,
                    average: 11.472,
                    mediane: 13.95,
                    groupSize: 1485,
                    isValidGrade: true,
                    children: [
                      GradeModel(
                          name: "TD/PIX_TEST/notePIX4.1",
                          author: "christian.trillaud",
                          gradeNumerator: 6.0,
                          gradeDenominator: 10.0,
                          rank: 752,
                          average: 5.135,
                          mediane: 6.2,
                          groupSize: 1484,
                          isValidGrade: true,
                          children: []),
                      GradeModel(
                          name: "TD/comp4.1/noteQUEST",
                          author: "christian.trillaud",
                          gradeNumerator: 7.78,
                          gradeDenominator: 10.0,
                          rank: 736,
                          average: 6.329,
                          mediane: 7.78,
                          groupSize: 1483,
                          isValidGrade: true,
                          children: [])
                    ])
              ])
        ],
        isSeen: false,
        isHidden: false),
    SchoolSubjectModel(
        name: "Transversale Préparation Aux Métiers De L'Ingénieur 1",
        masters: [],
        grades: [],
        isSeen: false,
        isHidden: false)
  ];
}
