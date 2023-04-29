import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/settings/widgets/draggable_zone_widget.dart';
import 'package:onyx/screens/settings/widgets/drop_down_widget.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (kDebugMode) {
          print('Settings state: ${state.status}');
        }
        return Container(
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
                            items: const ["système", "sombre", "clair"],
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
                                              themeMode: ThemeModeEnum.system));
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
                                              themeMode: ThemeModeEnum.light));
                                  break;
                              }
                            }),
                      ],
                    ),
                    const DraggableZoneWidget(),
                    SettingsCardWidget(
                      name: 'Connexion',
                      widgets: [
                        const SizedBox(height: 20),
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          color: const Color(0xffbf616a),
                          textColor: Colors.white70,
                          child: const Text('Déconnexion'),
                          onPressed: () {
                            CacheService.reset<IzlyCredential>();
                            context.read<IzlyCubit>().disconnect();
                            Hive.deleteBoxFromDisk("cached_qr_code");
                            Hive.deleteBoxFromDisk("cached_izly_amount");
                            CacheService.reset<IzlyQrCodeList>();
                            CacheService.reset<MailBoxList>();
                            CacheService.reset<Agenda>();
                            CacheService.reset<TeachingUnitList>();
                            CacheService.reset<Authentication>();
                            CacheService.reset<SettingsModel>();
                            context.read<AgendaCubit>().resetCubit();
                            context.read<IzlyCubit>().resetCubit();
                            context.read<EmailCubit>().resetCubit();
                            context.read<MapCubit>().resetCubit();
                            context.read<SettingsCubit>().resetCubit();
                            context.read<SettingsCubit>().load();
                            context.read<TomussCubit>().resetCubit();
                            context.read<AuthentificationCubit>().logout();
                          },
                        ),
                      ],
                    ),
                    SettingsCardWidget(name: "Cache", widgets: [
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        color: const Color(0xffbf616a),
                        textColor: Colors.white70,
                        child: const Text('Vider le cache des notes'),
                        onPressed: () {
                          CacheService.reset<TeachingUnitList>();
                          context.read<TomussCubit>().load(
                              dartus: context
                                  .read<AuthentificationCubit>()
                                  .state
                                  .dartus!,
                              cache: false,
                              settings:
                                  context.read<SettingsCubit>().state.settings);
                        },
                      ),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        color: const Color(0xffbf616a),
                        textColor: Colors.white70,
                        child: const Text('Vider le cache de l\'agenda'),
                        onPressed: () {
                          CacheService.reset<Agenda>();
                          context.read<AgendaCubit>().load(
                              dartus: context
                                  .read<AuthentificationCubit>()
                                  .state
                                  .dartus!,
                              settings:
                                  context.read<SettingsCubit>().state.settings,
                              cache: false);
                        },
                      ),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        color: const Color(0xffbf616a),
                        textColor: Colors.white70,
                        child: const Text('Vider le cache des mails'),
                        onPressed: () {
                          CacheService.reset<MailBoxList>();
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
                        minWidth: MediaQuery.of(context).size.width,
                        color: const Color(0xffbf616a),
                        textColor: Colors.white70,
                        child: const Text('Vider le cache de Izly'),
                        onPressed: () {
                          CacheService.reset<IzlyQrCodeList>();
                          CacheService.reset<IzlyCredential>();
                          Hive.deleteBoxFromDisk("cached_qr_code");
                          Hive.deleteBoxFromDisk("cached_izly_amount");
                          context.read<IzlyCubit>().resetCubit();
                          context.read<IzlyCubit>().connect();
                        },
                      )
                    ]),
                    const SettingsLinkWidget(),
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
