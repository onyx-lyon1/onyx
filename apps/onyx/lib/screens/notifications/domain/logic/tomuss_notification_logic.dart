import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/notifications/notifications_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

Future<void> tomussNotificationLogic(
    SettingsModel settings, Lyon1CasClient lyon1Cas) async {
  if (settings.newGradeNotification) {
    Lyon1TomussClient tomussClient = Lyon1TomussClient(lyon1Cas);
    List<TeachingUnit> teachingUnits = [];
    int? semesterIndex;
    Semester? semesterModel;
    if (CacheService.exist<List<Semester>>()) {
      List<Semester> semesterList = (CacheService.get<List<Semester>>())!;
      semesterIndex = semesterList.length - 1;
      semesterModel = semesterList[semesterIndex];
      teachingUnits = semesterModel.teachingUnits;
      List<TeachingUnit> newTeachingUnits = (await TomussLogic.getSemesters(
              dartus: tomussClient, autoRefresh: true, semester: semesterModel))
          .semesters!
          .last
          .teachingUnits;
      for (var i in newTeachingUnits) {
        if (teachingUnits.any((element) => element.title == i.title)) {
          TeachingUnit teachingUnitModel =
              teachingUnits.firstWhere((element) => element.title == i.title);
          for (var x in i.grades) {
            if (!teachingUnitModel.grades.any((element) =>
                element.title == x.title &&
                element.numerator == x.numerator &&
                element.denominator == x.denominator)) {
              await NotificationLogic.showNotification(
                  title: "Nouvelles notes",
                  body:
                      "Vous avez eu ${x.numerator}/${x.denominator} (${x.title}) en : ${i.title}",
                  payload: "newGrades");
            }
          }
        } else {
          for (var x in i.grades) {
            await NotificationLogic.showNotification(
                title: "Nouvelles notes",
                body:
                    "Vous avez eu ${x.numerator}/${x.denominator} (${x.title}) en : ${i.title}",
                payload: "newGrades");
          }
        }
      }
      semesterModel = semesterModel.copyWith(teachingUnits: teachingUnits);
      semesterList[semesterIndex] = semesterModel;
      CacheService.set<List<Semester>>(semesterList);
    }
  }
}
