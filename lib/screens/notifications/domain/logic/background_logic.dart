import 'package:dartus/tomuss.dart' as tomusslib;
import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
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
        Credential auth = (await AuthentificationLogic.fetchCredential());
        tomusslib.Dartus dartus = await AuthentificationLogic.login(
            username: auth.username,
            password: auth.password,
            keepLogedIn: settings.keepMeLoggedIn);
        if (settings.newGradeNotification) {
          List<TeachingUnit> teachingUnits = [];
          int? semestreIndex;
          Semester? semestreModel;
          if (await CacheService.exist<SemesterList>()) {
            SemesterList? semestreModelWrapper =
                await CacheService.get<SemesterList>();
            semestreIndex = semestreModelWrapper!.semestres.length - 1;
            semestreModel = semestreModelWrapper.semestres[semestreIndex];
          }
          if (await CacheService.exist<TeachingUnitList>(
              index: semestreIndex ?? 0)) {
            teachingUnits = (await CacheService.get<TeachingUnitList>(
                    index: semestreIndex ?? 0))!
                .teachingUnitModels;
          }
          List<TeachingUnit> newTeachingUnits =
              (await TomussLogic.getSemestersAndNote(
                      dartus: dartus,
                      autoRefresh: true,
                      semester: semestreModel ??
                          Semester(
                              "default semester", Dartus.currentSemester())))
                  .schoolSubjectModel!;
          for (var i in newTeachingUnits) {
            TeachingUnit teachingUnitModel =
                teachingUnits.firstWhere((element) => element == i);
            for (var x in i.grades) {
              if (!teachingUnitModel.grades.any((element) => element == x)) {
                await NotificationLogic.showNotification(
                    title: "Nouvelles notes",
                    body:
                        "Vous avez eu ${x.numerator}/${x.denominator} en : ${i.name}",
                    payload: "newGrades");
              }
            }
          }

          await CacheService.set<TeachingUnitList>(
              TeachingUnitList(teachingUnits, semestreIndex ?? 0));
        }
        if (settings.newMailNotification) {
          List<Mail> email = [];
          List<MailBox> mailBoxes = [];
          if (await CacheService.exist<MailBoxList>()) {
            mailBoxes = (await CacheService.get<MailBoxList>())!.mailBoxes;
            email = mailBoxes
                .firstWhere(
                    (element) => element.specialMailBox == SpecialMailBox.inbox)
                .emails;
          }
          Lyon1Mail mail = await MailLogic.connect(
              username: auth.username, password: auth.password);
          List<Mail> newMails = (await MailLogic.load(
                  mailClient: mail, emailNumber: 20, blockTrackers: true))
              .emails;
          for (var i in newMails) {
            if (!i.isRead &&
                !email.any((element) {
                  return element == i;
                })) {
              await NotificationLogic.showNotification(
                  title: "Nouveau mail",
                  body:
                      "Vous avez un nouveau mail de ${i.sender} \n\n ${i.excerpt}",
                  payload: "newMail");
            }
          }
          mailBoxes
              .firstWhere(
                  (element) => element.specialMailBox == SpecialMailBox.inbox)
              .emails = newMails;
          await CacheService.set<MailBoxList>(
              MailBoxList(mailBoxes: mailBoxes));
        }
        if (settings.calendarUpdateNotification) {
          List<Day> days = [];
          if (await CacheService.exist<Agenda>()) {
            days = (await CacheService.get<Agenda>())!.days;
          }
          List<Day> newDays = await AgendaLogic.load(
              agendaClient:
                  Lyon1Agenda.useAuthentication(dartus.authentication),
              settings: settings);
          List<Day> notifyDays = [];
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
                  body:
                      "Vous avez un nouvel évènement le : ${i.date.toString()}",
                  payload: "newEvent");
            }
          }
          await CacheService.set<Agenda>(Agenda(newDays));
        }
        break;
    }
    return Future.value(true);
  });
}
