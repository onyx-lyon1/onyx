import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/settings/widgets/drop_down_widget.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (kDebugMode) {
          print('Settings state: ${state.status}');
        }
        return Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: Res.bottomNavBarHeight,
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
                    SettingsCardWidget(
                      name: 'Général',
                      widgets: [
                        DropDownWidget(
                            text: 'Activer le thème sombre',
                            items: const ["system", "sombre", "claire"],
                            value: state.settings.themeMode.index,
                            onChanged: (int b) {
                              switch (b) {
                                case 0:
                                  context.read<SettingsCubit>().modify(
                                      settings: context
                                          .read<SettingsCubit>()
                                          .state
                                          .settings
                                          .copyWith(
                                              themeMode:
                                                  ThemeModeEnum.system));
                                  break;
                                case 1:
                                  context.read<SettingsCubit>().modify(
                                      settings: context
                                          .read<SettingsCubit>()
                                          .state
                                          .settings
                                          .copyWith(
                                              themeMode: ThemeModeEnum.dark));
                                  break;
                                case 2:
                                  context.read<SettingsCubit>().modify(
                                      settings: context
                                          .read<SettingsCubit>()
                                          .state
                                          .settings
                                          .copyWith(
                                              themeMode:
                                                  ThemeModeEnum.light));
                                  break;
                              }
                            }),
                        // TextSwitchWidget(
                        //   text: 'Activer le thème sombre',
                        //   value: context.read<SettingsCubit>().state.settings.darkMode,
                        //   onChanged: (bool b) {
                        //     context.read<SettingsCubit>().modify(settings:
                        //         context
                        //             .read<SettingsCubit>()
                        //             .state.settings
                        //             .copyWith(darkMode: b));
                        //   },
                        // )
                      ],
                    ),
                    SettingsCardWidget(
                      name: 'Tomuss',
                      widgets: [
                        if (Platform.isAndroid || Platform.isIOS)
                          TextSwitchWidget(
                            text: 'Notification en cas de nouvelle note',
                            value: context
                                .read<SettingsCubit>()
                                .state
                                .settings
                                .newGradeNotification,
                            onChanged: (bool b) {
                              context.read<SettingsCubit>().modify(
                                  settings: context
                                      .read<SettingsCubit>()
                                      .state
                                      .settings
                                      .copyWith(newGradeNotification: b));
                            },
                          ),
                        TextSwitchWidget(
                          text: 'Forcer les notes en vert',
                          value: context
                              .read<SettingsCubit>()
                              .state
                              .settings
                              .forceGreen,
                          onChanged: (bool b) {
                            context.read<SettingsCubit>().modify(
                                settings: context
                                    .read<SettingsCubit>()
                                    .state
                                    .settings
                                    .copyWith(forceGreen: b));
                          },
                        ),
                        // TextSwitchWidget(
                        //   text: 'Montrer les UEs cachées',
                        //   value: context
                        //       .read<SettingsCubit>()
                        //       .state
                        //       .settings
                        //       .showHiddenUE,
                        //   onChanged: (bool b) {
                        //     context.read<SettingsCubit>().modify(
                        //         settings: context
                        //             .read<SettingsCubit>()
                        //             .state
                        //             .settings
                        //             .copyWith(showHiddenUE: b));
                        //   },
                        // ),
                      ],
                    ),
                    SettingsCardWidget(
                      name: 'Agenda',
                      widgets: [
                        TextSwitchWidget(
                          text: 'Montrer le mini calendrier en haut de page',
                          value: context
                              .read<SettingsCubit>()
                              .state
                              .settings
                              .showMiniCalendar,
                          onChanged: (bool b) {
                            context.read<SettingsCubit>().modify(
                                settings: context
                                    .read<SettingsCubit>()
                                    .state
                                    .settings
                                    .copyWith(showMiniCalendar: b));
                          },
                        ),
                        if (Platform.isAndroid || Platform.isIOS)
                          TextSwitchWidget(
                            text:
                                'Notification en cas de modification de l\'agenda',
                            value: context
                                .read<SettingsCubit>()
                                .state
                                .settings
                                .calendarUpdateNotification,
                            onChanged: (bool b) {
                              context.read<SettingsCubit>().modify(
                                  settings: context
                                      .read<SettingsCubit>()
                                      .state
                                      .settings
                                      .copyWith(
                                          calendarUpdateNotification: b));
                            },
                          ),
                        const AgendaUrlParameterWidget(),
                      ],
                    ),
                    SettingsCardWidget(
                      name: 'Email',
                      widgets: [
                        if (Platform.isAndroid || Platform.isIOS)
                          TextSwitchWidget(
                            text: 'Notification en cas de nouveau mail',
                            value: context
                                .read<SettingsCubit>()
                                .state
                                .settings
                                .newMailNotification,
                            onChanged: (bool b) {
                              context.read<SettingsCubit>().modify(
                                  settings: context
                                      .read<SettingsCubit>()
                                      .state
                                      .settings
                                      .copyWith(newMailNotification: b));
                            },
                          ),
                        TextSwitchWidget(
                          text: 'Forcer le thème des mails',
                          value: context
                              .read<SettingsCubit>()
                              .state
                              .settings
                              .darkerMail,
                          onChanged: (bool b) {
                            context.read<SettingsCubit>().modify(
                                settings: context
                                    .read<SettingsCubit>()
                                    .state
                                    .settings
                                    .copyWith(darkerMail: b));
                          },
                        ),
                      ],
                    ),
                    SettingsCardWidget(
                      name: 'Connexion',
                      widgets: [
                        TextSwitchWidget(
                          text: 'Rester connecté',
                          value: context
                              .read<SettingsCubit>()
                              .state
                              .settings
                              .keepMeLoggedIn,
                          onChanged: (bool b) {
                            context.read<SettingsCubit>().modify(
                                settings: context
                                    .read<SettingsCubit>()
                                    .state
                                    .settings
                                    .copyWith(keepMeLoggedIn: b));
                            context.read<AuthentificationCubit>().forget();
                          },
                        ),
                        const SizedBox(height: 20),
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          color: const Color(0xffbf616a),
                          textColor: Colors.white70,
                          child: const Text('Déconnexion'),
                          onPressed: () {
                            context.read<AuthentificationCubit>().logout();
                          },
                        )
                      ],
                    ),
                    SettingsCardWidget(name: "Cache", widgets: [
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        color: const Color(0xffbf616a),
                        textColor: Colors.white70,
                        child: const Text('Vider le cache des notes'),
                        onPressed: () {
                          CacheService.reset<SchoolSubjectModelWrapper>();
                          context.read<TomussCubit>().load(
                              dartus: context
                                  .read<AuthentificationCubit>()
                                  .state
                                  .dartus!,
                              cache: false);
                        },
                      ),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        color: const Color(0xffbf616a),
                        textColor: Colors.white70,
                        child: const Text('Vider le cache de l\'agenda'),
                        onPressed: () {
                          CacheService.reset<DayModelWrapper>();
                          context.read<AgendaCubit>().load(
                              dartus: context
                                  .read<AuthentificationCubit>()
                                  .state
                                  .dartus!,
                              settings: context
                                  .read<SettingsCubit>()
                                  .state
                                  .settings,
                              cache: false);
                        },
                      ),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        color: const Color(0xffbf616a),
                        textColor: Colors.white70,
                        child: const Text('Vider le cache des mails'),
                        onPressed: () {
                          CacheService.reset<EmailModelWrapper>();
                          context.read<EmailCubit>().load(cache: false);
                        },
                      ),
                    ])
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
