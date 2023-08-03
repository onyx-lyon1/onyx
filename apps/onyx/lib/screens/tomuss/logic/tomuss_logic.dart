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
            List<Semester>? semesters,
            List<TeachingUnit>? schoolSubjectModel,
            Duration? timeout,
          })>
      getSemestersAndNote(
          {required Lyon1TomussClient dartus,
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
        semesters: [
          Semester("2022/Automne", Lyon1TomussClient.currentSemester())
        ],
        schoolSubjectModel: teachingUnitsModelListMock,
        timeout: null
      );
    }
  }

  static Future<ParsedPage?> getParsedPage(
      {required Lyon1TomussClient dartus,
      Semester? semestre,
      bool autoRefresh = true}) async {
    return await dartus.getParsedPage(
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
