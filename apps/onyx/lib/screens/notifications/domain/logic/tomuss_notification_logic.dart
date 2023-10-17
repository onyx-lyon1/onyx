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
    Semester? semestreModel;
    if (await CacheService.exist<List<Semester>>()) {
      List<Semester> semesters = (await CacheService.get<List<Semester>>())!;
      semestreModel = semesters.last;
      teachingUnits = semestreModel.teachingUnits;

      List<TeachingUnit> newTeachingUnits = (await TomussLogic.getSemesters(
              dartus: tomussClient, autoRefresh: true, semester: semestreModel))
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

      semesters.last = semesters.last.copyWith(teachingUnits: teachingUnits);
      await TomussLogic.setCurrentSemester(semesters.length - 1);
      await CacheService.set<List<Semester>>(semesters);
    }
  }
}
