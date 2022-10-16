import 'package:flutter/foundation.dart';
import 'package:oloid2/functionalities/agenda/agenda_bloc.dart';
import 'package:oloid2/functionalities/authentification/authentification_bloc.dart';
import 'package:oloid2/functionalities/email/email_bloc.dart';
import 'package:oloid2/functionalities/grades/grades_bloc.dart';
import 'package:oloid2/functionalities/settings/settings_bloc.dart';
import 'package:oloid2/model/day_model.dart';
import 'package:oloid2/model/mail_model.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/model/wrapper/day_model_wrapper.dart';
import 'package:oloid2/model/wrapper/email_model_wrapper.dart';
import 'package:oloid2/model/wrapper/teaching_unit_model_wrapper.dart';
import 'package:oloid2/others/cache_service.dart';
import 'package:oloid2/others/hive_init.dart';
import 'package:oloid2/others/notification_service.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case "check update":
        await hiveInit();

        await NotificationService.init();

        SettingsBloc settingsBloc = SettingsBloc();
        settingsBloc.stream.listen((settingsState) {
          if (settingsState is SettingsReady) {
            AuthentificationBloc authentificationBloc = AuthentificationBloc();
            authentificationBloc.stream.listen((authState) async {
              if (authState is AuthentificationAuthentificated) {
                //begin of body

                //check if there is a new grade
                if (settingsBloc.settings.newGradeNotification) {
                  List<TeachingUnitModel> teachingUnits = [];
                  if (await CacheService.exist<TeachingUnitModelWrapper>()) {
                    teachingUnits =
                        (await CacheService.get<TeachingUnitModelWrapper>())!
                            .teachingUnitModels;
                  }
                  GradesBloc gradesBloc = GradesBloc();
                  gradesBloc.stream.listen((gradesState) async {
                    if (gradesState is GradesReady) {
                      for (var i in gradesBloc.teachingUnits) {
                        if (!teachingUnits.any((element) {
                          return element == i;
                        })) {
                          await NotificationService.showNotification(
                              title: "Nouvelles notes",
                              body:
                                  "Vous avez de nouvelles notes dans ${i.name}",
                              payload: "newGrades");
                        }
                      }
                    }
                  });
                  gradesBloc.add(
                      GradesLoad(authentificationBloc.dartus!, cache: false));
                }

                //check if there is a new mail
                if (settingsBloc.settings.newMailNotification) {
                  List<EmailModel> emails = [];
                  if (await CacheService.exist<EmailModelWrapper>()) {
                    emails = (await CacheService.get<EmailModelWrapper>())!
                        .emailModels;
                  }
                  EmailBloc emailBloc = EmailBloc();
                  emailBloc.stream.listen((mailState) async {
                    if (mailState is EmailConnected) {
                      emailBloc.add(EmailLoad(cache: false));
                    }
                    if (mailState is EmailLoaded) {
                      for (var i in emailBloc.emails) {
                        if (!emails.any((element) {
                          return element == i;
                        })) {
                          await NotificationService.showNotification(
                              title: "Nouveau mail",
                              body: "Vous avez un nouveau mail de ${i.sender}",
                              payload: "newMail");
                        }
                      }
                    }
                  });
                  emailBloc.add(EmailConnect(
                      username: authentificationBloc.usename,
                      password: authentificationBloc.password));
                }

                //check if there is a new or updated event
                if (settingsBloc.settings.calendarUpdateNotification) {
                  List<DayModel> days = [];
                  if (await CacheService.exist<DayModelWrapper>()) {
                    days =
                        (await CacheService.get<DayModelWrapper>())!.dayModels;
                  }
                  AgendaBloc agendaBloc = AgendaBloc();
                  agendaBloc.stream.listen((agendaState) async {
                    if (agendaState is AgendaReady) {
                      for (var i in agendaBloc.dayModels) {
                        if (!days.any((element) {
                          return element == i;
                        })) {
                          if (kDebugMode) {
                            print("new event");
                          }
                          await NotificationService.showNotification(
                              title: "Nouvel évènement",
                              body:
                                  "Vous avez un nouvel évènement le : ${i.date.toString()}",
                              payload: "newEvent");
                        }
                      }
                    }
                  });
                  agendaBloc.add(AgendaLoad(
                      authentificationBloc.dartus!, settingsBloc.settings,
                      cache: false));
                }

                //end of checking
              }
            });
            authentificationBloc.add(AuthentificationLogin(
                keepLogedIn: settingsBloc.settings.keepMeLoggedIn));
          }
        });
        settingsBloc.add(SettingsLoad());

        break;
    }
    return Future.value(true);
  });
}
/*
Future<void> tmpGrades() async {

}
*/