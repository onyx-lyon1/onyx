import 'package:dartus/tomuss.dart' as tomussLib;
import 'package:flutter/foundation.dart';
import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/functionalities/agenda_backend/agenda_backend.dart';
import 'package:oloid2/functionalities/authentification_backend/authentification_backend.dart';
import 'package:oloid2/functionalities/background_notifications/notification_service.dart';
import 'package:oloid2/functionalities/cache_service.dart';
import 'package:oloid2/functionalities/email_backend/email_backend.dart';
import 'package:oloid2/functionalities/grades_backend/grades_backend.dart';
import 'package:oloid2/functionalities/settings_backend/settings_backend.dart';
import 'package:oloid2/model/authentication.dart';
import 'package:oloid2/model/day_model.dart';
import 'package:oloid2/model/mail_model.dart';
import 'package:oloid2/model/settings.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/model/wrapper/day_model_wrapper.dart';
import 'package:oloid2/model/wrapper/email_model_wrapper.dart';
import 'package:oloid2/model/wrapper/teaching_unit_model_wrapper.dart';
import 'package:oloid2/others/hive_init.dart';
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
        tomussLib.Dartus dartus = await AuthentificationBackend.login(
            username: auth.username,
            password: auth.password,
            keepLogedIn: settings.keepMeLoggedIn);
        if (settings.newGradeNotification) {
          List<TeachingUnitModel> teachingUnits = [];
          if (await CacheService.exist<TeachingUnitModelWrapper>()) {
            teachingUnits =
                (await CacheService.get<TeachingUnitModelWrapper>())!
                    .teachingUnitModels;
          }
          List<TeachingUnitModel> newTeachingUnits =
              await GradesBackend.getGrades(dartus: dartus);
          for (var i in newTeachingUnits) {
            if (!teachingUnits.any((element) {
              return element == i;
            })) {
              await NotificationService.showNotification(
                  title: "Nouvelles notes",
                  body: "Vous avez de nouvelles notes dans ${i.name}",
                  payload: "newGrades");
            }
          }
          CacheService.set<TeachingUnitModelWrapper>(
              TeachingUnitModelWrapper(teachingUnits));
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
            if (!emails.any((element) {
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
            if (!days.any((element) {
              return element == i;
            })) {
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
// void v2() async {}
