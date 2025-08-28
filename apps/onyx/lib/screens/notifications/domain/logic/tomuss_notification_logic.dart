import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/notifications/notifications_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:onyx/l10n/app_localizations.dart';

Future<void> tomussNotificationLogic(SettingsModel settings,
    Lyon1CasClient lyon1Cas, AppLocalizations localizations) async {
  if (settings.newGradeNotification) {
    Lyon1TomussClient tomussClient = Lyon1TomussClient(lyon1Cas);
    List<TeachingUnit> teachingUnits = [];
    int? semestreIndex;
    Semester? semestreModel;
    if (await CacheService.exist<SemesterList>()) {
      SemesterList semestreModelWrapper =
          (await CacheService.get<SemesterList>())!;
      semestreIndex = semestreModelWrapper.semestres.length - 1;
      semestreModel = semestreModelWrapper.semestres[semestreIndex];
    }
    semestreIndex ??= 0;
    if (await CacheService.exist<TeachingUnitList>(index: semestreIndex)) {
      teachingUnits =
          (await CacheService.get<TeachingUnitList>(index: semestreIndex))!
              .teachingUnitModels;
      List<TeachingUnit> newTeachingUnits =
          (await TomussLogic.getNameAndSemestersAndNotes(
                  tomussClient: tomussClient,
                  autoRefresh: true,
                  semester: semestreModel ??
                      Semester(title:localizations.defaultSemester,
                          url: Lyon1TomussClient.currentSemester())))
              .schoolSubjectModel!;
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
                  title: localizations.newGrade,
                  body: localizations.youHaveANewGrade(
                      x.numerator, x.denominator, x.title),
                  payload: localizations.newGrade);
            }
          }
        } else {
          for (var x in i.grades) {
            await NotificationLogic.showNotification(
                title: localizations.newGrade,
                body: localizations.youHaveANewGrade(
                    x.numerator, x.denominator, x.title),
                payload: localizations.newGrade);
          }
        }
      }

      await CacheService.set<TeachingUnitList>(
          TeachingUnitList(teachingUnits, semestreIndex));
    }
  }
}
