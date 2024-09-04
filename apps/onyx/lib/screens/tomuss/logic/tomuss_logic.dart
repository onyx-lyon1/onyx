import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/theme/grade_color.dart';
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
            Student? student,
            List<Semester>? semesters,
            List<TeachingUnit>? schoolSubjectModel,
            Duration? timeout,
          })>
      getNameAndSemestersAndNotes(
          {required Lyon1TomussClient tomussClient,
          Semester? semester,
          int? semesterIndex,
          bool autoRefresh = true}) async {
    if (!Res.mock) {
      ParsedPage? parsedPage = await getParsedPage(
          tomussClient: tomussClient,
          semestre: semester,
          autoRefresh: autoRefresh);
      if (parsedPage == null) {
        throw "Impossible de récuperer la page de tomuss";
      }
      if (parsedPage.isTimedOut) {
        return (
          student: null,
          semesters: null,
          schoolSubjectModel: null,
          timeout: parsedPage.timeout
        );
      }
      if (await CacheService.exist<TeachingUnitList>()) {
        TeachingUnitList? teachingUnitList =
            await CacheService.get<TeachingUnitList>();
        //take all coef and apply them to the new teaching units
        for (var i = 0; i < parsedPage.teachingunits!.length; i++) {
          int index = teachingUnitList!.teachingUnitModels.indexWhere(
              (element) => element.title == parsedPage.teachingunits![i].title);
          if (index != -1) {
            for (var j = 0;
                j < parsedPage.teachingunits![i].grades.length;
                j++) {
              int index2 = teachingUnitList.teachingUnitModels[index].grades
                  .indexWhere((element) =>
                      element.title ==
                      parsedPage.teachingunits![i].grades[j].title);
              if (index2 != -1) {
                parsedPage.teachingunits![i].grades[j] =
                    parsedPage.teachingunits![i].grades[j].copyWith(
                        coef: teachingUnitList
                            .teachingUnitModels[index].grades[index2].coef);
              }
            }
          }
        }
      }
      return (
        student: parsedPage.student,
        semesters: parsedPage.semesters,
        schoolSubjectModel: parsedPage.teachingunits,
        timeout: null
      );
    } else {
      return (
        student: Student("Jean", "Dupont", ""),
        semesters: [
          Semester("2022/Automne", Lyon1TomussClient.currentSemester())
        ],
        schoolSubjectModel: teachingUnitsModelListMock,
        timeout: null
      );
    }
  }

  static Future<ParsedPage?> getParsedPage(
      {required Lyon1TomussClient tomussClient,
      Semester? semestre,
      bool autoRefresh = true}) async {
    return await tomussClient.getParsedPage(
        semestre?.url ?? Lyon1TomussClient.currentSemester(),
        autoRefresh: autoRefresh);
  }

  static Future<List<TeachingUnit>> getTeachingUnitsCache(
      ({String? path, int currentSemesterIndex}) inputData) async {
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

  static List<
          ({
            TeachingUnitElement teachingUnitElement,
            TeachingUnit teachingUnit
          })>
      parseRecentElements(
          List<TeachingUnit> teachingUnits, SettingsModel settings) {
    List<({TeachingUnitElement teachingUnitElement, TeachingUnit teachingUnit})>
        newElements = [];
    for (var teachingUnit in teachingUnits) {
      for (var element in teachingUnit.visibleChildren) {
        if ((element.date != null) &&
            element.date!.isAfter(DateTime.now()
                .subtract(Duration(days: settings.recentGradeDuration)))) {
          newElements
              .add((teachingUnitElement: element, teachingUnit: teachingUnit));
        }
      }
    }
    newElements.sort((a, b) =>
        b.teachingUnitElement.date!.compareTo(a.teachingUnitElement.date!));
    return newElements;
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

  /* original tomuss code
  function rank_to_color(rank, nr) {
    var x = Math.floor(511 * rank / nr);
    var b, c = '';
    if (rank > nr / 2) {
        b = '255,' + (511 - x) + ',' + (511 - x);
        if (rank > 3 * nr / 4)
            c = ';color:#FFF';
    }
    else
        b = x + ',255,' + x;

    return 'background: rgb(' + b + ')' + c
  }
   */

  static Color getMainGradeColor(
      {required bool forceGreen,
      required bool isSeen,
      required List<Grade> grades}) {
    if (forceGreen) {
      return isSeen ? GradeColor.seenGreen : GradeColor.unseenGreen;
    } else {
      if (grades.isEmpty) {
        return isSeen ? GradeColor.seenGreen : GradeColor.unseenGreen;
      } else {
        if (grades.length == 1) {
          return _getGradeColor(
              grade: grades.first, forceGreen: forceGreen, isSeen: isSeen);
        }
        double a = 0;
        double r = 0;
        double g = 0;
        double b = 0;
        double coefSum = 0;
        for (var i in grades) {
          Color tmpColor =
              _getGradeColor(grade: i, forceGreen: forceGreen, isSeen: isSeen);
          a += tmpColor.alpha * (i.coef);
          r += tmpColor.red * (i.coef);
          g += tmpColor.green * (i.coef);
          b += tmpColor.blue * (i.coef);
          coefSum += i.coef;
        }
        if (coefSum == 0) {
          coefSum = 1;
        }
        a = (a / coefSum);
        r = (r / coefSum);
        g = (g / coefSum);
        b = (b / coefSum);
        return Color.fromARGB(a.round(), r.round(), g.round(), b.round());
      }
    }
  }

  static Color _getGradeColor(
      {required Grade grade, required bool forceGreen, required bool isSeen}) {
    if (forceGreen || !grade.isValid) {
      return isSeen ? GradeColor.seenGreen : GradeColor.unseenGreen;
    } else {
      var x = (511 * grade.rank / grade.groupeSize).floor();
      Color b = Colors.red;
      if (grade.rank > grade.groupeSize / 2) {
        b = Color.fromARGB(255, 255, 511 - x, 511 - x);
      } else {
        b = Color.fromARGB(255, x, 255, x);
      }
      return b;
    }
  }

  static final List<TeachingUnit> teachingUnitsModelListMock = [
    TeachingUnit(
        "Algèbre 1 Cursus Prépa",
        [Teacher("Frank WAGNER", "wagner@math.univ-lyon1.fr")],
        [
          Grade(
            title: "Colle1",
            author: "frank-olaf.wagner",
            numerator: 12.0,
            denominator: 20.0,
            groupeSize: 88,
            average: 13.386,
            mediane: 13.0,
            isValid: true,
            rank: 136,
            date: DateTime.now(),
            children: const [],
            coef: 1.0,
            position: 0,
          ),
          Grade(
            title: "Colle2",
            author: "frank-olaf.wagner",
            numerator: 14.0,
            denominator: 20.0,
            groupeSize: 37,
            average: 12.511,
            mediane: 12.0,
            isValid: true,
            rank: 135,
            date: DateTime.now(),
            children: const [],
            coef: 1.0,
            position: 0,
          ),
          Grade(
            title: "Colle3",
            author: "frank-olaf.wagner",
            numerator: 10.0,
            denominator: 20.0,
            groupeSize: 94,
            average: 12.596,
            mediane: 13.0,
            isValid: true,
            rank: 130,
            date: DateTime.now(),
            children: const [],
            coef: 1.0,
            position: 0,
          ),
          Grade(
            title: "Colle4",
            author: "frank-olaf.wagner",
            numerator: 11.0,
            denominator: 20.0,
            groupeSize: 76,
            average: 12.305,
            mediane: 12.0,
            isValid: true,
            rank: 128,
            date: DateTime.now(),
            children: const [],
            coef: 1.0,
            position: 0,
          ),
          Grade(
            title: "Colle5",
            author: "frank-olaf.wagner",
            numerator: 4.0,
            denominator: 20.0,
            groupeSize: 124,
            average: 12.352,
            mediane: 13.0,
            isValid: true,
            rank: 128,
            date: DateTime.now(),
            children: const [],
            coef: 1.0,
            position: 0,
          ),
          Grade(
            title: "DS1",
            author: "frank-olaf.wagner",
            numerator: 10.63,
            denominator: 16.5,
            groupeSize: 30,
            average: 8.335,
            mediane: 8.0,
            isValid: true,
            rank: 135,
            date: DateTime.now(),
            children: const [],
            coef: 1.0,
            position: 0,
          ),
          Grade(
            title: "DS2",
            author: "frank-olaf.wagner",
            numerator: 8.5,
            denominator: 16.0,
            groupeSize: 41,
            average: 7.228,
            mediane: 7.19,
            isValid: true,
            rank: 131,
            date: DateTime.now(),
            children: const [],
            coef: 1.0,
            position: 0,
          ),
          Grade(
            title: "DS3",
            author: "frank-olaf.wagner",
            numerator: 7.5,
            denominator: 30.0,
            groupeSize: 53,
            average: 7.143,
            mediane: 7.0,
            isValid: true,
            rank: 129,
            date: DateTime.now(),
            children: const [],
            coef: 1.0,
            position: 0,
          ),
        ],
        const [],
        const [],
        const [],
        const [],
        const [],
        const [],
        "ticket",
        "UE algèbre"),
    TeachingUnit(
        "Compétences Numériques et Préparation PIX - Module 1",
        [Teacher("Christian TRILLAUD", "christian.trillaud@univ-lyon1.fr")],
        [
          Grade(
            title: "TD/comp1.2_5.2/noteQUEST",
            author: "christian.trillaud",
            numerator: 8.59,
            denominator: 10.0,
            groupeSize: 354,
            average: 6.495,
            mediane: 7.93,
            isValid: true,
            rank: 1485,
            date: DateTime.now(),
            children: const [],
            coef: 1.0,
            position: 0,
          ),
          Grade(
            title: "TD/comp1.3/note",
            author: "christian.trillaud",
            numerator: 8.97,
            denominator: 10.0,
            groupeSize: 433,
            average: 6.676,
            mediane: 8.26,
            isValid: true,
            rank: 1480,
            date: DateTime.now(),
            children: [
              Grade(
                title: "TD/comp1.3/noteQUEST",
                author: "christian.trillaud",
                numerator: 8.97,
                denominator: 10.0,
                groupeSize: 376,
                average: 6.552,
                mediane: 8.03,
                isValid: true,
                rank: 1480,
                date: DateTime.now(),
                children: const [],
                coef: 1.0,
                position: 0,
              ),
            ],
            coef: 1.0,
            position: 0,
          ),
          Grade(
            title: "TD/comp3.1/note",
            author: "christian.trillaud",
            numerator: 9.83,
            denominator: 10.0,
            groupeSize: 101,
            average: 6.725,
            mediane: 8.28,
            isValid: true,
            rank: 1483,
            date: DateTime.now(),
            children: const [],
            coef: 1.0,
            position: 0,
          ),
          Grade(
            title: "compétences/ECUE-PIX/Moyenne_ECUE",
            author: "christian.trillaud",
            numerator: 14.317,
            denominator: 20.0,
            groupeSize: 771,
            average: 12.205,
            mediane: 14.457,
            isValid: true,
            rank: 1480,
            date: DateTime.now(),
            children: [
              Grade(
                title: "compétences/comp1.3/note",
                author: "christian.trillaud",
                numerator: 13.57,
                denominator: 20.0,
                groupeSize: 830,
                average: 12.171,
                mediane: 14.16,
                isValid: true,
                rank: 1484,
                date: DateTime.now(),
                children: [
                  Grade(
                    title: "TD/PIX_TEST/notePIX1.3",
                    author: "christian.trillaud",
                    numerator: 4.6,
                    denominator: 10.0,
                    groupeSize: 1023,
                    average: 5.175,
                    mediane: 6.2,
                    isValid: true,
                    rank: 1484,
                    date: DateTime.now(),
                    children: const [],
                    coef: 1.0,
                    position: 0,
                  ),
                  Grade(
                    title: "TD/comp1.3/noteFinale",
                    author: "christian.trillaud",
                    numerator: 8.97,
                    denominator: 10.0,
                    groupeSize: 433,
                    average: 6.979,
                    mediane: 8.26,
                    isValid: true,
                    rank: 1479,
                    date: DateTime.now(),
                    children: const [],
                    coef: 1.0,
                    position: 0,
                  ),
                ],
                coef: 1.0,
                position: 0,
              ),
              // ... Autres notes
            ],
            coef: 1.0,
            position: 0,
          ),
          Grade(
            title: "compétences/comp3.1/note",
            author: "christian.trillaud",
            numerator: 13.13,
            denominator: 20.0,
            groupeSize: 907,
            average: 12.176,
            mediane: 14.27,
            isValid: true,
            rank: 1485,
            date: DateTime.now(),
            children: [
              Grade(
                title: "TD/PIX_TEST/notePIX3.1",
                author: "christian.trillaud",
                numerator: 3.3,
                denominator: 10.0,
                groupeSize: 1140,
                average: 5.234,
                mediane: 6.1,
                isValid: true,
                rank: 1484,
                date: DateTime.now(),
                children: const [],
                coef: 1.0,
                position: 0,
              ),
              Grade(
                title: "TD/comp3.1/noteFinale",
                author: "christian.trillaud",
                numerator: 9.83,
                denominator: 10.0,
                groupeSize: 101,
                average: 6.927,
                mediane: 8.28,
                isValid: true,
                rank: 1482,
                date: DateTime.now(),
                children: const [],
                coef: 1.0,
                position: 0,
              ),
            ],
            coef: 1.0,
            position: 0,
          ),
          Grade(
            title: "compétences/comp1.2-5.2/note",
            author: "christian.trillaud",
            numerator: 16.79,
            denominator: 20.0,
            groupeSize: 407,
            average: 12.882,
            mediane: 15.68,
            isValid: true,
            rank: 1481,
            date: DateTime.now(),
            children: [
              Grade(
                title: "TD/PIX_TEST/notePIX1.2-5.2",
                author: "christian.trillaud",
                numerator: 8.2,
                denominator: 10.0,
                groupeSize: 457,
                average: 6.215,
                mediane: 7.7,
                isValid: true,
                rank: 1484,
                date: DateTime.now(),
                children: const [],
                coef: 1.0,
                position: 0,
              ),
              Grade(
                title: "TD/comp1.2_5.2/noteFinale",
                author: "christian.trillaud",
                numerator: 8.59,
                denominator: 10.0,
                groupeSize: 423,
                average: 6.634,
                mediane: 8.04,
                isValid: true,
                rank: 1478,
                date: DateTime.now(),
                children: const [],
                coef: 1.0,
                position: 0,
              ),
            ],
            coef: 1.0,
            position: 0,
          ),
          Grade(
            title: "compétences/comp4.1/note",
            author: "christian.trillaud",
            numerator: 13.78,
            denominator: 20.0,
            groupeSize: 787,
            average: 11.472,
            mediane: 13.95,
            isValid: true,
            rank: 1485,
            date: DateTime.now(),
            children: [
              Grade(
                title: "TD/PIX_TEST/notePIX4.1",
                author: "christian.trillaud",
                numerator: 6.0,
                denominator: 10.0,
                groupeSize: 752,
                average: 5.135,
                mediane: 6.2,
                isValid: true,
                rank: 1484,
                date: DateTime.now(),
                children: const [],
                coef: 1.0,
                position: 0,
              ),
              Grade(
                title: "TD/comp4.1/noteQUEST",
                author: "christian.trillaud",
                numerator: 7.78,
                denominator: 10.0,
                groupeSize: 736,
                average: 6.329,
                mediane: 7.78,
                isValid: true,
                rank: 1483,
                date: DateTime.now(),
                children: const [],
                coef: 1.0,
                position: 0,
              ),
            ],
            coef: 1.0,
            position: 0,
          ),
        ],
        const [],
        const [],
        const [],
        const [],
        const [],
        const [],
        "ticket",
        "UE pix"),
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
        "UE ppp2")
  ];
}
