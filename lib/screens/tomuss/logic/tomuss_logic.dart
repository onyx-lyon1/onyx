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
          Grade(
              title: "math",
              author: "Mr math",
              date: DateTime.now(),
              position: 10,
              numerator: 10,
              denominator: 20,
              rank: 50,
              average: 10,
              mediane: 10,
              isValid: true,
              groupeSize: 100,
              children: const [],
              coef: 1)
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
          Grade(
              title: "pix",
              author: "Mr PIX",
              date: DateTime.now(),
              position: 10,
              numerator: 20,
              denominator: 20,
              rank: 1,
              average: 10,
              mediane: 10,
              isValid: true,
              groupeSize: 100,
              children: const [],
              coef: 1),
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
