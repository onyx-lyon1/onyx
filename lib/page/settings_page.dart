import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/functionalities/cache_service.dart';
import 'package:oloid2/model/wrapper/day_model_wrapper.dart';
import 'package:oloid2/model/wrapper/email_model_wrapper.dart';
import 'package:oloid2/model/wrapper/teaching_unit_model_wrapper.dart';
import 'package:oloid2/page/qr_code_scanner.dart';
import 'package:oloid2/states/authentification/authentification_bloc.dart';
import 'package:oloid2/states/settings/settings_bloc.dart';
import 'package:oloid2/widget/settings_card.dart';
import 'package:oloid2/widget/text_switch.dart';
import 'package:sizer/sizer.dart';

class SettingsPage extends StatelessWidget {
  final TextEditingController qrCodeURLController = TextEditingController();

  SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    qrCodeURLController.text = context.read<SettingsBloc>().settings.agendaURL;

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Container(
          color: Theme.of(context).backgroundColor,
          child: ListView(
            children: [
              Container(
                height: 10.h,
                color: Theme.of(context).cardTheme.color,
                child: Center(
                  child: Text(
                    'Paramètres',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SettingsCard(
                name: 'Général',
                widgets: [
                  TextSwitch(
                    text: 'Activer le thème sombre',
                    value: context.read<SettingsBloc>().settings.darkMode,
                    onChanged: (bool b) {
                      context.read<SettingsBloc>().add(SettingsModify(context
                          .read<SettingsBloc>()
                          .settings
                          .copyWith(darkMode: b)));
                    },
                  )
                ],
              ),
              SettingsCard(
                name: 'Tomuss',
                widgets: [
                  if (Platform.isAndroid || Platform.isIOS)
                    TextSwitch(
                      text: 'Notification en cas de nouvelle note',
                      value: context
                          .read<SettingsBloc>()
                          .settings
                          .newGradeNotification,
                      onChanged: (bool b) {
                        context.read<SettingsBloc>().add(SettingsModify(context
                            .read<SettingsBloc>()
                            .settings
                            .copyWith(newGradeNotification: b)));
                      },
                    ),
                  TextSwitch(
                    text: 'Forcer les notes en vert',
                    value: context.read<SettingsBloc>().settings.forceGreen,
                    onChanged: (bool b) {
                      context.read<SettingsBloc>().add(SettingsModify(context
                          .read<SettingsBloc>()
                          .settings
                          .copyWith(forceGreen: b)));
                    },
                  ),
                  TextSwitch(
                    text: 'Montrer les UEs cachées',
                    value: context.read<SettingsBloc>().settings.showHiddenUE,
                    onChanged: (bool b) {
                      context.read<SettingsBloc>().add(SettingsModify(context
                          .read<SettingsBloc>()
                          .settings
                          .copyWith(showHiddenUE: b)));
                    },
                  ),
                ],
              ),
              SettingsCard(
                name: 'Agenda',
                widgets: [
                  TextSwitch(
                    text: 'Montrer le mini calendrier en haut de page',
                    value:
                        context.read<SettingsBloc>().settings.showMiniCalendar,
                    onChanged: (bool b) {
                      context.read<SettingsBloc>().add(SettingsModify(context
                          .read<SettingsBloc>()
                          .settings
                          .copyWith(showMiniCalendar: b)));
                    },
                  ),
                  if (Platform.isAndroid || Platform.isIOS)
                    TextSwitch(
                      text: 'Notification en cas de modification de l\'agenda',
                      value: context
                          .read<SettingsBloc>()
                          .settings
                          .calendarUpdateNotification,
                      onChanged: (bool b) {
                        context.read<SettingsBloc>().add(SettingsModify(context
                            .read<SettingsBloc>()
                            .settings
                            .copyWith(calendarUpdateNotification: b)));
                      },
                    ),
                  TextSwitch(
                    text:
                        'Récupérer automatiquement les ressources de l\'agenda',
                    value:
                        context.read<SettingsBloc>().settings.fetchAgendaAuto,
                    onChanged: (bool b) {
                      context.read<SettingsBloc>().add(SettingsModify(context
                          .read<SettingsBloc>()
                          .settings
                          .copyWith(fetchAgendaAuto: b)));
                    },
                  ),
                  (!context.read<SettingsBloc>().settings.fetchAgendaAuto)
                      ? Container(
                          clipBehavior: Clip.hardEdge,
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 110,
                                  height: 8.h,
                                  padding: EdgeInsets.only(left: 3.w),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                  ),
                                  child: TextField(
                                    controller: qrCodeURLController,
                                    enableSuggestions: false,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                    ),
                                    onChanged: (String value) {
                                      context.read<SettingsBloc>().add(
                                          SettingsModify(context
                                              .read<SettingsBloc>()
                                              .settings
                                              .copyWith(agendaURL: value)));
                                      if (kDebugMode) {
                                        print(
                                            'value: ${context.read<SettingsBloc>().settings.agendaURL}');
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(fontSize: 12),
                                      hintStyle: TextStyle(fontSize: 12),
                                      hintText: 'URL de l\'agenda',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const QrCodeScanner(),
                                      ))
                                          .then((dynamic url) {
                                        qrCodeURLController.value =
                                            TextEditingValue(
                                                text: url ??
                                                    qrCodeURLController
                                                        .value.text);
                                        context.read<SettingsBloc>().add(
                                            SettingsModify(context
                                                .read<SettingsBloc>()
                                                .settings
                                                .copyWith(
                                                    agendaURL: url ??
                                                        context
                                                            .read<
                                                                SettingsBloc>()
                                                            .settings
                                                            .agendaURL)));
                                      });
                                    },
                                    enableFeedback: true,
                                    splashColor: Colors.transparent,
                                    icon: Icon(
                                      Icons.qr_code,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              SettingsCard(
                name: 'Email',
                widgets: [
                  if (Platform.isAndroid || Platform.isIOS)
                    TextSwitch(
                      text: 'Notification en cas de nouveau mail',
                      value: context
                          .read<SettingsBloc>()
                          .settings
                          .newMailNotification,
                      onChanged: (bool b) {
                        context.read<SettingsBloc>().add(SettingsModify(context
                            .read<SettingsBloc>()
                            .settings
                            .copyWith(newMailNotification: b)));
                      },
                    ),
                  TextSwitch(
                    text: 'Forcer le thème des mails',
                    value: context.read<SettingsBloc>().settings.darkerMail,
                    onChanged: (bool b) {
                      context.read<SettingsBloc>().add(SettingsModify(context
                          .read<SettingsBloc>()
                          .settings
                          .copyWith(darkerMail: b)));
                    },
                  ),
                ],
              ),
              SettingsCard(
                name: 'Connexion',
                widgets: [
                  TextSwitch(
                    text: 'Rester connecté',
                    value: context.read<SettingsBloc>().settings.keepMeLoggedIn,
                    onChanged: (bool b) {
                      context.read<SettingsBloc>().add(SettingsModify(context
                          .read<SettingsBloc>()
                          .settings
                          .copyWith(keepMeLoggedIn: b)));
                      context
                          .read<AuthentificationBloc>()
                          .add(AuthentificationForgetCredential());
                    },
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    color: const Color(0xffbf616a),
                    textColor: Colors.white70,
                    child: const Text('Déconnexion'),
                    onPressed: () {
                      context
                          .read<AuthentificationBloc>()
                          .add(AuthentificationLogout());
                    },
                  )
                ],
              ),
              SettingsCard(name: "Cache", widgets: [
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  color: const Color(0xffbf616a),
                  textColor: Colors.white70,
                  child: const Text('Vider le cache des notes'),
                  onPressed: () {
                    CacheService.reset<TeachingUnitModelWrapper>();
                  },
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  color: const Color(0xffbf616a),
                  textColor: Colors.white70,
                  child: const Text('Vider le cache de l\'agenda'),
                  onPressed: () {
                    CacheService.reset<DayModelWrapper>();
                  },
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  color: const Color(0xffbf616a),
                  textColor: Colors.white70,
                  child: const Text('Vider le cache des mails'),
                  onPressed: () {
                    CacheService.reset<EmailModelWrapper>();
                  },
                ),
              ])
            ],
          ),
        );
      },
    );
  }
}
