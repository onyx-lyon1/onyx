import 'package:dartus/tomuss.dart' as tomuss_lib;
import 'package:flutter/foundation.dart';
import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/screens/agenda/domain/logic/agenda_backend.dart';
import 'package:oloid2/screens/login/domain/logic/authentification_backend.dart';
import 'package:oloid2/screens/notifications/domain/logic/notification_service.dart';
import 'package:oloid2/core/cache_service.dart';
import 'package:oloid2/screens/mails/domain/logic/email_backend.dart';
import 'package:oloid2/screens/tomuss/domain/logic/tomuss_backend.dart';
import 'package:oloid2/screens/settings/domain/logic/settings_backend.dart';
import 'package:oloid2/screens/login/domain/model/authentication.dart';
import 'package:oloid2/screens/agenda/domain/model/day_model.dart';
import 'package:oloid2/screens/mails/domain/model/mail_model.dart';
import 'package:oloid2/screens/settings/domain/model/settings.dart';
import 'package:oloid2/screens/tomuss/domain/model/school_subject_model.dart';
import 'package:oloid2/screens/agenda/domain/model/day_model_wrapper.dart';
import 'package:oloid2/screens/mails/domain/model/email_model_wrapper.dart';
import 'package:oloid2/screens/tomuss/domain/model/school_subject_model_wrapper.dart';
import 'package:oloid2/core/initialisations/hive_init.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (kDebugMode) {
      print("task :  $task");
    }
    switch (task) {
      case "check update":
        await hiveInit();
        await NotificationService.init();
        SettingsModel settings = await SettingsBackend.load();
        Authentication auth = (await AuthentificationBackend.fetchCredential());
        tomuss_lib.Dartus dartus = await AuthentificationBackend.login(
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
              await GradesBackend.getGrades(dartus: dartus);
          for (var i in newTeachingUnits) {
            SchoolSubjectModel teachingUnitModel =
                teachingUnits.firstWhere((element) => element.name == i.name);
            for (var x in i.grades) {
              if (!teachingUnitModel.grades.any((element) => element == x)) {
                await NotificationService.showNotification(
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
          Lyon1Mail mail = await EmailBackend.connect(
              username: auth.username, password: auth.password);
          List<EmailModel> newEmails =
              await EmailBackend.load(mailClient: mail, emailNumber: 20);
          for (var i in newEmails) {
            if (!i.isRead &&
                !emails.any((element) {
                  return element == i;
                })) {
              await NotificationService.showNotification(
                  title: "Nouveau mail",
                  body: "Vous avez un nouveau mail de ${i.sender}",
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
          List<DayModel> newDays = await AgendaBackend.load(
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
              await NotificationService.showNotification(
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
