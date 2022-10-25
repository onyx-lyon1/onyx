import 'package:flutter/foundation.dart';
import 'package:oloid2/functionalities/background_notifications/notification_service.dart';
import 'package:oloid2/functionalities/cache_service.dart';
import 'package:oloid2/model/day_model.dart';
import 'package:oloid2/model/mail_model.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/model/wrapper/day_model_wrapper.dart';
import 'package:oloid2/model/wrapper/email_model_wrapper.dart';
import 'package:oloid2/model/wrapper/teaching_unit_model_wrapper.dart';
import 'package:oloid2/others/hive_init.dart';
import 'package:oloid2/states/agenda/agenda_bloc.dart';
import 'package:oloid2/states/authentification/authentification_bloc.dart';
import 'package:oloid2/states/email/email_bloc.dart';
import 'package:oloid2/states/grades/grades_bloc.dart';
import 'package:oloid2/states/settings/settings_bloc.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (kDebugMode) {
      print("task :  $task");
    }
    switch (task) {
      case "check update":
        bool end = false;
        if (kDebugMode) {
          print("in check update switch");
        }
        await hiveInit();

        await NotificationService.init();
        if (kDebugMode) {
          print("hive and notification inited");
        }

        SettingsBloc settingsBloc = SettingsBloc();
        settingsBloc.stream.listen((settingsState) {
          if (kDebugMode) {
            print("new settings state in stream $settingsState");
          }

          if (settingsState is SettingsReady) {
            AuthentificationBloc authentificationBloc = AuthentificationBloc();
            authentificationBloc.stream.listen((authState) async {
              if (authState is AuthentificationAuthentificated) {
                //begin of body

                //check if there is a new grade
                if (settingsBloc.settings.newGradeNotification) {
                  bool gradeNote = false;
                  List<TeachingUnitModel> teachingUnits = [];
                  if (await CacheService.exist<TeachingUnitModelWrapper>()) {
                    teachingUnits =
                        (await CacheService.get<TeachingUnitModelWrapper>())!
                            .teachingUnitModels;
                  }
                  GradesBloc gradesBloc = GradesBloc();
                  gradesBloc.stream.listen((gradesState) async {
                    if (kDebugMode) {
                      print("new grades state in stream $gradesState");
                    }
                    if (gradesState is GradesError) {
                      gradeNote = true;
                    }
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
                      gradeNote = true;
                    }
                  });
                  gradesBloc.add(
                      GradesLoad(authentificationBloc.dartus!, cache: false));
                  while (!gradeNote) {
                    await Future.delayed(const Duration(seconds: 1));
                    if (kDebugMode) {
                      print("waiting for grades");
                    }
                  }
                }

                //check if there is a new mail
                if (settingsBloc.settings.newMailNotification) {
                  bool mailEnd = false;
                  List<EmailModel> emails = [];
                  if (await CacheService.exist<EmailModelWrapper>()) {
                    emails = (await CacheService.get<EmailModelWrapper>())!
                        .emailModels;
                  }
                  EmailBloc emailBloc = EmailBloc();
                  emailBloc.stream.listen((mailState) async {
                    if (kDebugMode) {
                      print("new mail state in stream $mailState");
                    }
                    if (mailState is EmailError) {
                      mailEnd = true;
                    }
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
                      mailEnd = true;
                    }
                  });
                  emailBloc.add(EmailConnect(
                      username: authentificationBloc.usename,
                      password: authentificationBloc.password));
                  while (!mailEnd) {
                    await Future.delayed(const Duration(seconds: 1));
                    if (kDebugMode) {
                      print("waiting for mail");
                    }
                  }
                }

                //check if there is a new or updated event
                if (settingsBloc.settings.calendarUpdateNotification) {
                  bool agendaEnd = false;
                  List<DayModel> days = [];
                  if (await CacheService.exist<DayModelWrapper>()) {
                    days =
                        (await CacheService.get<DayModelWrapper>())!.dayModels;
                  }
                  AgendaBloc agendaBloc = AgendaBloc();
                  agendaBloc.stream.listen((agendaState) async {
                    if (kDebugMode) {
                      print("new agenda state in stream $agendaState");
                    }
                    if (agendaState is AgendaError) {
                      agendaEnd = true;
                    }
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
                      agendaEnd = true;
                    }
                  });
                  agendaBloc.add(AgendaLoad(
                      authentificationBloc.dartus!, settingsBloc.settings,
                      cache: false));
                  while (!agendaEnd) {
                    await Future.delayed(const Duration(seconds: 1));
                    if (kDebugMode) {
                      print("waiting for agenda");
                    }
                  }
                }
                end = true;
                //end of checking
              }
            });
            authentificationBloc.add(AuthentificationLogin(
                keepLogedIn: settingsBloc.settings.keepMeLoggedIn));
          }
        });
        settingsBloc.add(SettingsLoad());
        while (!end) {
          await Future.delayed(const Duration(seconds: 3));
          if (kDebugMode) {
            print("waiting for end");
          }
        }

        break;
    }

    if (kDebugMode) {
      print("return");
    }
    return Future.value(true);
  });
}
