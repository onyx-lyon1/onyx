import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/functionalities/cache_service.dart';
import 'package:oloid2/model/wrapper/day_model_wrapper.dart';
import 'package:oloid2/model/wrapper/email_model_wrapper.dart';
import 'package:oloid2/model/wrapper/teaching_unit_model_wrapper.dart';
import 'package:oloid2/states/authentification/authentification_cubit.dart';
import 'package:oloid2/states/settings/settings_bloc.dart';
import 'package:oloid2/widget/settings/agenda_url_params.dart';
import 'package:oloid2/widget/settings/text_switch.dart';
import 'package:oloid2/widget/settings_card.dart';
import 'package:sizer/sizer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (kDebugMode){
          print('Settings state: $state');
        }
        return SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
                Expanded(
                  child: ListView(
                    children: [
                      SettingsCard(
                        name: 'Général',
                        widgets: [
                          TextSwitch(
                            text: 'Activer le thème sombre',
                            value: context.read<SettingsBloc>().state.settings.darkMode,
                            onChanged: (bool b) {
                              context.read<SettingsBloc>().add(SettingsModify(
                                  context
                                      .read<SettingsBloc>()
                                      .state.settings
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
                                  .state.settings
                                  .newGradeNotification,
                              onChanged: (bool b) {
                                context.read<SettingsBloc>().add(SettingsModify(
                                    context
                                        .read<SettingsBloc>()
                                        .state.settings
                                        .copyWith(newGradeNotification: b)));
                              },
                            ),
                          TextSwitch(
                            text: 'Forcer les notes en vert',
                            value:
                                context.read<SettingsBloc>().state.settings.forceGreen,
                            onChanged: (bool b) {
                              context.read<SettingsBloc>().add(SettingsModify(
                                  context
                                      .read<SettingsBloc>()
                                      .state.settings
                                      .copyWith(forceGreen: b)));
                            },
                          ),
                          TextSwitch(
                            text: 'Montrer les UEs cachées',
                            value: context
                                .read<SettingsBloc>()
                                .state.settings
                                .showHiddenUE,
                            onChanged: (bool b) {
                              context.read<SettingsBloc>().add(SettingsModify(
                                  context
                                      .read<SettingsBloc>()
                                      .state.settings
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
                            value: context
                                .read<SettingsBloc>()
                                .state.settings
                                .showMiniCalendar,
                            onChanged: (bool b) {
                              context.read<SettingsBloc>().add(SettingsModify(
                                  context
                                      .read<SettingsBloc>()
                                      .state.settings
                                      .copyWith(showMiniCalendar: b)));
                            },
                          ),
                          if (Platform.isAndroid || Platform.isIOS)
                            TextSwitch(
                              text:
                                  'Notification en cas de modification de l\'agenda',
                              value: context
                                  .read<SettingsBloc>()
                                  .state.settings
                                  .calendarUpdateNotification,
                              onChanged: (bool b) {
                                context.read<SettingsBloc>().add(SettingsModify(
                                    context
                                        .read<SettingsBloc>()
                                        .state.settings
                                        .copyWith(
                                            calendarUpdateNotification: b)));
                              },
                            ),
                          const AgendaUrlParams(),
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
                                  .state.settings
                                  .newMailNotification,
                              onChanged: (bool b) {
                                context.read<SettingsBloc>().add(SettingsModify(
                                    context
                                        .read<SettingsBloc>()
                                        .state.settings
                                        .copyWith(newMailNotification: b)));
                              },
                            ),
                          TextSwitch(
                            text: 'Forcer le thème des mails',
                            value:
                                context.read<SettingsBloc>().state.settings.darkerMail,
                            onChanged: (bool b) {
                              context.read<SettingsBloc>().add(SettingsModify(
                                  context
                                      .read<SettingsBloc>()
                                      .state.settings
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
                            value: context
                                .read<SettingsBloc>()
                                .state.settings
                                .keepMeLoggedIn,
                            onChanged: (bool b) {
                              context.read<SettingsBloc>().add(SettingsModify(
                                  context
                                      .read<SettingsBloc>()
                                      .state.settings
                                      .copyWith(keepMeLoggedIn: b)));
                              context
                                  .read<AuthentificationCubit>().forget();
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
                                  .read<AuthentificationCubit>()
                                  .logout();
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
