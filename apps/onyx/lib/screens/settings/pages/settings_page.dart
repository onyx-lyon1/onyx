import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/notifications/domain/logic/background_logic.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/settings/widgets/draggable_zone_widget.dart';
import 'package:onyx/screens/settings/widgets/drop_down_widget.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) => Container(
        color: Theme.of(context).colorScheme.background,
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
                    color: Theme.of(context).textTheme.bodyLarge!.color,
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
                          text: 'Choisir le thème',
                          items: const ["Système", "Sombre", "Clair"],
                          value: state.settings.themeMode.index,
                          onChanged: (int b) {
                            ThemeModeEnum themeMode;
                            switch (b) {
                              case 0:
                                themeMode = ThemeModeEnum.system;
                                break;
                              case 1:
                                themeMode = ThemeModeEnum.dark;
                                break;
                              case 2:
                                themeMode = ThemeModeEnum.light;
                                break;
                              default:
                                themeMode = ThemeModeEnum.system;
                                break;
                            }

                            context.read<SettingsCubit>().modify(
                                settings: state.settings
                                    .copyWith(themeMode: themeMode));
                          }),
                    ],
                  ),
                  const DraggableZoneWidget(),
                  SettingsCardWidget(
                    name: 'Connexion',
                    widgets: [
                      Center(
                        child: MaterialButton(
                          color: const Color(0xffbf616a),
                          textColor: Colors.white70,
                          child: Text('Déconnexion',
                              style: TextStyle(fontSize: 17.sp)),
                          onPressed: () => SettingsLogic.logout(context),
                        ),
                      ),
                    ],
                  ),
                  SettingsCardWidget(name: "Cache", widgets: [
                    MaterialButton(
                      color: const Color(0xffbf616a),
                      textColor: Colors.white70,
                      child: Text('Vider le cache des notes',
                          style: TextStyle(fontSize: 17.sp)),
                      onPressed: () {
                        CacheService.reset<List<Semester>>();
                        context.read<TomussCubit>().load(
                            lyon1Cas: context
                                .read<AuthentificationCubit>()
                                .state
                                .lyon1Cas,
                            cache: false,
                            settings:
                                context.read<SettingsCubit>().state.settings);
                      },
                    ),
                    MaterialButton(
                      color: const Color(0xffbf616a),
                      textColor: Colors.white70,
                      child: Text('Vider le cache de l\'agenda',
                          style: TextStyle(fontSize: 17.sp)),
                      onPressed: () {
                        CacheService.reset<Agenda>();
                        context.read<AgendaCubit>().load(
                            lyon1Cas: context
                                .read<AuthentificationCubit>()
                                .state
                                .lyon1Cas,
                            settings:
                                context.read<SettingsCubit>().state.settings,
                            cache: false);
                      },
                    ),
                    MaterialButton(
                      color: const Color(0xffbf616a),
                      textColor: Colors.white70,
                      child: Text('Vider le cache des mails',
                          style: TextStyle(fontSize: 17.sp)),
                      onPressed: () {
                        CacheService.reset<List<MailBox>>();
                        context.read<EmailCubit>().load(
                            cache: false,
                            blockTrackers: context
                                .read<SettingsCubit>()
                                .state
                                .settings
                                .blockTrackers);
                      },
                    ),
                    MaterialButton(
                      color: const Color(0xffbf616a),
                      textColor: Colors.white70,
                      child: Text('Vider le cache de Izly',
                          style: TextStyle(fontSize: 17.sp)),
                      onPressed: () {
                        CacheService.reset<List<IzlyQrCode>>();
                        CacheService.reset<List<IzlyPaymentModel>>();
                        CacheService.reset<IzlyCredential>();
                        Hive.box(name: "cached_izly_amount").deleteFromDisk();
                        context.read<IzlyCubit>().resetCubit();
                        context.read<IzlyCubit>().connect(
                            settings:
                                context.read<SettingsCubit>().state.settings);
                      },
                    )
                  ]),
                  SettingsCardWidget(name: "Notifications", widgets: [
                    MaterialButton(
                      color: const Color(0xffbf616a),
                      textColor: Colors.white70,
                      child: Text('Tester les notifications',
                          style: TextStyle(fontSize: 17.sp)),
                      onPressed: () {
                        backgroundLogic(init: false);
                      },
                    ),
                  ]),
                  const SettingsLinkWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
