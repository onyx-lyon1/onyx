import 'package:dartus/tomuss.dart' as tomusslib;
import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/initialisations/hive_init.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/notifications/notifications_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void backgroundLogic() {
  Workmanager().executeTask((task, inputData) async {
  if (kDebugMode) {
    print("task :  $task");
  }
  switch (task) {
    case "check update":
  await hiveInit();
  await NotificationLogic.init();
  SettingsModel settings = await SettingsLogic.load();
  AuthenticationModel auth = (await AuthentificationLogic.fetchCredential());
  tomusslib.Dartus dartus = await AuthentificationLogic.login(
      username: auth.username,
      password: auth.password,
      keepLogedIn: settings.keepMeLoggedIn);
  if (settings.newGradeNotification) {
    List<SchoolSubjectModel> teachingUnits = [];
    int? semestreIndex;
    SemestreModel? semestreModel;
    if (await CacheService.exist<SemestreModelWrapper>()) {
      SemestreModelWrapper? semestreModelWrapper =
          await CacheService.get<SemestreModelWrapper>();
      semestreIndex = semestreModelWrapper!.semestres.length - 1;
      semestreModel = semestreModelWrapper.semestres[semestreIndex];
    }
    if (await CacheService.exist<SchoolSubjectModelWrapper>(
        index: semestreIndex ?? 0)) {
      teachingUnits = (await CacheService.get<SchoolSubjectModelWrapper>(
              index: semestreIndex ?? 0))!
          .teachingUnitModels;
    }
    List<SchoolSubjectModel> newTeachingUnits =
        (await TomussLogic.getSemestersAndNote(
                dartus: dartus,
                autoRefresh: true,
                semester: semestreModel ??
                    SemestreModel(
                        name: "default semester",
                        url: Dartus.currentSemester())))
            .schoolSubjectModel!;
    for (var i in newTeachingUnits) {
      SchoolSubjectModel teachingUnitModel =
          teachingUnits.firstWhere((element) => element == i);
      for (var x in i.grades) {
        if (!teachingUnitModel.grades.any((element) => element == x)) {
          await NotificationLogic.showNotification(
              title: "Nouvelles notes",
              body:
                  "Vous avez eu ${x.gradeNumerator}/${x.gradeDenominator} en : ${i.name}",
              payload: "newGrades");
        }
      }
    }

    await CacheService.set<SchoolSubjectModelWrapper>(
        SchoolSubjectModelWrapper(teachingUnits, semestreIndex ?? 0));
  }
  if (settings.newMailNotification) {
    List<EmailModel> emails = [];
    if (await CacheService.exist<EmailModelWrapper>()) {
      emails = (await CacheService.get<EmailModelWrapper>())!.emailModels;
    }
    Lyon1Mail mail = await EmailLogic.connect(
        username: auth.username, password: auth.password);
    List<EmailModel> newEmails =
        await EmailLogic.load(mailClient: mail, emailNumber: 20);
    for (var i in newEmails) {
      if (!i.isRead &&
          !emails.any((element) {
            return element == i;
          })) {
        await NotificationLogic.showNotification(
            title: "Nouveau mail",
            body: "Vous avez un nouveau mail de ${i.sender} \n\n ${i.excerpt}",
            payload: "newMail");
      }
    }
    await CacheService.set<EmailModelWrapper>(EmailModelWrapper(newEmails));
  }
  if (settings.calendarUpdateNotification) {
    List<DayModel> days = [];
    if (await CacheService.exist<DayModelWrapper>()) {
      days = (await CacheService.get<DayModelWrapper>())!.dayModels;
    }
    List<DayModel> newDays = await AgendaLogic.load(
        agendaClient: Lyon1Agenda.useAuthentication(dartus.authentication),
        settings: settings);
    List<DayModel> notifyDays = [];
    for (var i in newDays) {
      if (i.date.difference(DateTime.now()).inMilliseconds > 0 &&
          i.date
                  .difference(DateTime.now())
                  .compareTo(const Duration(days: 14)) <
              0 &&
          (!days.any((element) {
            return element == i;
          }))) {
        notifyDays.add(i);
      }
    }
    if (notifyDays.length > 4) {
      await NotificationLogic.showNotification(
          title: "Nouvel évènement",
          body:
              "Vous avez ${notifyDays.length} jours modifiés dans votre agenda",
          payload: "newEvent");
    } else {
      for (var i in notifyDays) {
        await NotificationLogic.showNotification(
            title: "Nouvel évènement",
            body: "Vous avez un nouvel évènement le : ${i.date.toString()}",
            payload: "newEvent");
      }
    }
    await CacheService.set<DayModelWrapper>(DayModelWrapper(newDays));
  }
  break;
  }

  return Future.value(true);
  });
}
