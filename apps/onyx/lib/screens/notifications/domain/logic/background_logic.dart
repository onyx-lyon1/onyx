import 'package:flutter/foundation.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/notifications/notifications_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void workmanagerHandler() {
  Workmanager().executeTask((task, inputData) async {
    if (kDebugMode) {
      print("task :  $task");
    }
    switch (task) {
      case "check update":
        return await backgroundLogic();
    }
    return Future.value(true);
  });
}

Future<bool> backgroundLogic({bool init = true}) async {
  if (init) {
    await hiveInit();
    await NotificationLogic.init();
  }
  SettingsModel settings = await SettingsLogic.load();

  if (!settings.firstLogin && !settings.biometricAuth) {
    Lyon1CasClient lyon1Cas = Lyon1CasClient();
    var result = await lyon1Cas.authenticate(
        (await CacheService.get<Credential>(
            secureKey: await CacheService.getEncryptionKey(false)))!);
    Lyon1TomussClient tomussClient = Lyon1TomussClient(lyon1Cas);
    if (!result.authResult) return false;
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
                  dartus: tomussClient,
                  autoRefresh: true,
                  semester: semestreModel ??
                      Semester("default semester",
                          Lyon1TomussClient.currentSemester())))
              .schoolSubjectModel!;
      for (var i in newTeachingUnits) {
        TeachingUnit teachingUnitModel =
            teachingUnits.firstWhere((element) => element == i);
        for (var x in i.grades) {
          if (!teachingUnitModel.grades.any((element) => element == x)) {
            await NotificationLogic.showNotification(
                title: "Nouvelles notes",
                body:
                    "Vous avez eu ${x.numerator}/${x.denominator} (${x.title}) en : ${i.title}",
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
      Credential creds = (await CacheService.get<Credential>(
          secureKey: await CacheService.getEncryptionKey(false)))!;
      Lyon1MailClient mail = await MailLogic.connect(
          username: creds.username, password: creds.password);
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
      await CacheService.set<MailBoxList>(MailBoxList(mailBoxes: mailBoxes));
    }
    if (settings.calendarUpdateNotification) {
      List<Day> days = [];
      if (await CacheService.exist<Agenda>()) {
        days = (await CacheService.get<Agenda>())!.days;
      }
      List<Day> newDays = await AgendaLogic.load(
          agendaClient: Lyon1AgendaClient.useLyon1Cas(tomussClient.lyon1Cas),
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
              body: "Vous avez un nouvel évènement le : ${i.date.toString()}",
              payload: "newEvent");
        }
      }
      await CacheService.set<Agenda>(Agenda(newDays));
    }
  }
  return Future.value(true);
}
