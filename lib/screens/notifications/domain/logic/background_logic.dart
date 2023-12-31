import 'package:dartus/tomuss.dart' as tomusslib;
import 'package:flutter/foundation.dart';
import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/core/cache_service.dart';
import 'package:oloid2/core/initialisations/initialisations_export.dart';
import 'package:oloid2/screens/agenda/agenda_export.dart';
import 'package:oloid2/screens/login/login_export.dart';
import 'package:oloid2/screens/mails/mails_export.dart';
import 'package:oloid2/screens/notifications/notifications_export.dart';
import 'package:oloid2/screens/settings/settings_export.dart';
import 'package:oloid2/screens/tomuss/tomuss_export.dart';
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
          if (await CacheService.exist<SchoolSubjectModelWrapper>()) {
            teachingUnits =
                (await CacheService.get<SchoolSubjectModelWrapper>())!
                    .teachingUnitModels;
          }
          List<SchoolSubjectModel> newTeachingUnits =
              await TomussLogic.getGrades(dartus: dartus);
          for (var i in newTeachingUnits) {
            SchoolSubjectModel teachingUnitModel =
                teachingUnits.firstWhere((element) => element.name == i.name);
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
          CacheService.set<SchoolSubjectModelWrapper>(
              SchoolSubjectModelWrapper(teachingUnits));
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
                  body:
                      "Vous avez un nouveau mail de ${i.sender} \n\n ${i.excerpt}",
                  payload: "newMail");
            }
          }
          CacheService.set<EmailModelWrapper>(EmailModelWrapper(newEmails));
        }
        if (settings.calendarUpdateNotification) {
          List<DayModel> days = [];
          if (await CacheService.exist<DayModelWrapper>()) {
            days = (await CacheService.get<DayModelWrapper>())!.dayModels;
          }
          List<DayModel> newDays = await AgendaLogic.load(
              agendaClient:
                  Lyon1Agenda.useAuthentication(dartus.authentication),
              settings: settings);
          for (var i in newDays) {
            if (i.date.difference(DateTime.now()).inMilliseconds > 0 &&
                i.date
                        .difference(DateTime.now())
                        .compareTo(const Duration(days: 14)) <
                    0 &&
                (!days.any((element) {
                  return element == i;
                }))) {
              await NotificationLogic.showNotification(
                  title: "Nouvel évènement",
                  body:
                      "Vous avez un nouvel évènement le : ${i.date.toString()}",
                  payload: "newEvent");
            }
          }
          CacheService.set<DayModelWrapper>(DayModelWrapper(newDays));
        }
        break;
    }

    if (kDebugMode) {
      print("return");
    }
    return Future.value(true);
  });
}
