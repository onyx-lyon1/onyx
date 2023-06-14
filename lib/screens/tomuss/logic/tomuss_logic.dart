import 'dart:core';
import 'dart:io';

import 'package:dartus/tomuss.dart';
import 'package:flutter/material.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:path_provider/path_provider.dart';

class GetCacheDataPass {
  final String path;
  final int currentSemesterIndex;

  GetCacheDataPass(this.path, this.currentSemesterIndex);
}

class TomussLogic {
  static Future<
          ({
            List<Semester>? semesters,
            List<TeachingUnit>? schoolSubjectModel,
            Duration? timeout,
          })>
      getSemestersAndNote(
          {required Dartus dartus,
          Semester? semester,
          int? semesterIndex,
          bool autoRefresh = true}) async {
    if (!Res.mock) {
      ParsedPage? parsedPage = await getParsedPage(
          dartus: dartus, semestre: semester, autoRefresh: autoRefresh);
      if (parsedPage == null) {
        throw "Impossible de récuperer la page de tomuss";
      }
      if (parsedPage.isTimedOut) {
        return (
          semesters: null,
          schoolSubjectModel: null,
          timeout: parsedPage.timeout
        );
      }
      return (
        semesters: parsedPage.semesters,
        schoolSubjectModel: parsedPage.teachingunits,
        timeout: null
      );
    } else {
      return (
        semesters: [Semester("2022/Automne", Dartus.currentSemester())],
        schoolSubjectModel: teachingUnitsModelListMock,
        timeout: null
      );
    }
  }

  static Future<ParsedPage?> getParsedPage(
      {required Dartus dartus,
      Semester? semestre,
      bool autoRefresh = true}) async {
    return await dartus.getParsedPage(semestre?.url ?? Dartus.currentSemester(),
        autoRefresh: autoRefresh);
  }

  static Future<List<TeachingUnit>> getTeachingUnitsCache(
      GetCacheDataPass inputData) async {
    if (Res.mock) {
      return teachingUnitsModelListMock;
    }
    await hiveInit(path: inputData.path);
    if (await CacheService.exist<TeachingUnitList>(
        index: inputData.currentSemesterIndex)) {
      return (await CacheService.get<TeachingUnitList>(
              index: inputData.currentSemesterIndex))!
          .teachingUnitModels;
    } else {
      return [];
    }
  }

  static List<Grade> parseRecentGrades(
      List<TeachingUnit> teachingUnits, SettingsModel settings) {
    List<Grade> newGrades = [];
    for (var teachingUnit in teachingUnits) {
      for (var grade in teachingUnit.grades) {
        if ((grade.date != null) &&
            grade.date!.isAfter(DateTime.now()
                .subtract(Duration(days: settings.recentGradeDuration)))) {
          newGrades.add(grade);
        }
      }
    }
    newGrades.sort((a, b) => b.date!.compareTo(a.date!));
    return newGrades;
  }

  static Future<String> getDownloadLocalPath(
      {required Upload upload,
      required String ticket,
      required BuildContext context}) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${upload.fileUrl.split("/").last}');
    if (await file.exists()) {
      return file.path;
    } else {
      List<int> uploadFile =
          await upload.getContent(ticket); //email.getAttachment(fileName);
      await file.writeAsBytes(uploadFile);
      return file.path;
    }
  }

  static final List<TeachingUnit> teachingUnitsModelListMock = [
    TeachingUnit(
        "Algèbre 1 Cursus Prépa",
        [Teacher("Frank WAGNER", "wagner@math.univ-lyon1.fr")],
        [
          Grade("Colle1", "frank-olaf.wagner", 12.0, 20.0, 88, 13.386, 13.0,
              true, 136, DateTime.now(), const [], 0),
          Grade("Colle2", "frank-olaf.wagner", 14.0, 20.0, 37, 12.511, 12.0,
              true, 135, DateTime.now(), const [], 0),
          Grade("Colle3", "frank-olaf.wagner", 10.0, 20.0, 94, 12.596, 13.0,
              true, 130, DateTime.now(), const [], 0),
          Grade("Colle4", "frank-olaf.wagner", 11.0, 20.0, 76, 12.305, 12.0,
              true, 128, DateTime.now(), const [], 0),
          Grade("Colle5", "frank-olaf.wagner", 4.0, 20.0, 124, 12.352, 13.0,
              true, 128, DateTime.now(), const [], 0),
          Grade("DS1", "frank-olaf.wagner", 10.63, 16.5, 30, 8.335, 8.0, true,
              135, DateTime.now(), const [], 0),
          Grade("DS2", "frank-olaf.wagner", 8.5, 16.0, 41, 7.228, 7.19, true,
              131, DateTime.now(), const [], 0),
          Grade("DS3", "frank-olaf.wagner", 7.5, 30.0, 53, 7.143, 7.0, true,
              129, DateTime.now(), const [], 0)
        ],
        const [],
        const [],
        const [],
        const [],
        const [],
        const [],
        "ticket",
        "ue"),
    TeachingUnit(
        "Compétences Numériques et Préparation PIX - Module 1",
        [Teacher("Christian TRILLAUD", "christian.trillaud@univ-lyon1.fr")],
        [
          Grade("TD/comp1.2_5.2/noteQUEST", "christian.trillaud", 8.59, 10.0,
              354, 6.495, 7.93, true, 1485, DateTime.now(), const [], 1),
          Grade(
              "TD/comp1.3/note",
              "christian.trillaud",
              8.97,
              10.0,
              433,
              6.676,
              8.26,
              true,
              1480,
              DateTime.now(),
              [
                Grade("TD/comp1.3/noteQUEST", "christian.trillaud", 8.97, 10.0,
                    376, 6.552, 8.03, true, 1480, DateTime.now(), const [], 2)
              ],
              0),
          Grade("TD/comp3.1/note", "christian.trillaud", 9.83, 10.0, 101, 6.725,
              8.28, true, 1483, DateTime.now(), const [], 3),
          Grade(
              "compétences/ECUE-PIX/Moyenne_ECUE",
              "christian.trillaud",
              14.317,
              20.0,
              771,
              12.205,
              14.457,
              true,
              1480,
              DateTime.now(),
              [
                Grade(
                    "compétences/comp1.3/note",
                    "christian.trillaud",
                    13.57,
                    20.0,
                    830,
                    12.171,
                    14.16,
                    true,
                    1484,
                    DateTime.now(),
                    [
                      Grade(
                          "TD/PIX_TEST/notePIX1.3",
                          "christian.trillaud",
                          4.6,
                          10.0,
                          1023,
                          5.175,
                          6.2,
                          true,
                          1484,
                          DateTime.now(),
                          const [],
                          4),
                      Grade(
                          "TD/comp1.3/noteFinale",
                          "christian.trillaud",
                          8.97,
                          10.0,
                          433,
                          6.979,
                          8.26,
                          true,
                          1479,
                          DateTime.now(),
                          const [],
                          5)
                    ],
                    0),
                Grade(
                    "compétences/comp3.1/note",
                    "christian.trillaud",
                    13.13,
                    20.0,
                    907,
                    12.176,
                    14.27,
                    true,
                    1485,
                    DateTime.now(),
                    [
                      Grade(
                          "TD/PIX_TEST/notePIX3.1",
                          "christian.trillaud",
                          3.3,
                          10.0,
                          1140,
                          5.234,
                          6.1,
                          true,
                          1484,
                          DateTime.now(),
                          const [],
                          6),
                      Grade(
                          "TD/comp3.1/noteFinale",
                          "christian.trillaud",
                          9.83,
                          10.0,
                          101,
                          6.927,
                          8.28,
                          true,
                          1482,
                          DateTime.now(),
                          const [],
                          7)
                    ],
                    0),
                Grade(
                    "compétences/comp1.2-5.2/note",
                    "christian.trillaud",
                    16.79,
                    20.0,
                    407,
                    12.882,
                    15.68,
                    true,
                    1481,
                    DateTime.now(),
                    [
                      Grade(
                          "TD/PIX_TEST/notePIX1.2-5.2",
                          "christian.trillaud",
                          8.2,
                          10.0,
                          457,
                          6.215,
                          7.7,
                          true,
                          1484,
                          DateTime.now(),
                          const [],
                          8),
                      Grade(
                          "TD/comp1.2_5.2/noteFinale",
                          "christian.trillaud",
                          8.59,
                          10.0,
                          423,
                          6.634,
                          8.04,
                          true,
                          1478,
                          DateTime.now(),
                          const [],
                          9)
                    ],
                    0),
                Grade(
                    "compétences/comp4.1/note",
                    "christian.trillaud",
                    13.78,
                    20.0,
                    787,
                    11.472,
                    13.95,
                    true,
                    1485,
                    DateTime.now(),
                    [
                      Grade(
                          "TD/PIX_TEST/notePIX4.1",
                          "christian.trillaud",
                          6.0,
                          10.0,
                          752,
                          5.135,
                          6.2,
                          true,
                          1484,
                          DateTime.now(),
                          const [],
                          10),
                      Grade(
                          "TD/comp4.1/noteQUEST",
                          "christian.trillaud",
                          7.78,
                          10.0,
                          736,
                          6.329,
                          7.78,
                          true,
                          1483,
                          DateTime.now(),
                          const [],
                          11)
                    ],
                    0)
              ],
              0)
        ],
        const [],
        const [],
        const [],
        const [],
        const [],
        const [],
        "ticket",
        "ue"),
    TeachingUnit(
        "Transversale Préparation Aux Métiers De L'Ingénieur 1",
        const [],
        const [],
        const [],
        const [],
        const [],
        const [],
        const [],
        const [],
        "ticket",
        "ue")
  ];
}
