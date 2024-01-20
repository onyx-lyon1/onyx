import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
import 'package:onyx/screens/settings/states/theme_cubit.dart';
import 'package:onyx/screens/settings/widgets/draggable_zone_widget.dart';
import 'package:onyx/screens/settings/widgets/drop_down_widget.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          child: Column(mainAxisSize: MainAxisSize.max, children: [
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
                      DropdownButton(
                        value: context
                            .read<SettingsCubit>()
                            .state
                            .settings
                            .language,
                        items: AppLocalizations.supportedLocales
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(e.languageCode),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          context.read<SettingsCubit>().modify(
                              settings: context
                                  .read<SettingsCubit>()
                                  .state
                                  .settings
                                  .copyWith(language: value));
                        },
                      ),
                      BlocBuilder<ThemeCubit, ThemeState>(
                        buildWhen: (previous, current) {
                          return previous.themesSettings!.themeMode !=
                              current.themesSettings!.themeMode;
                        },
                        builder: (context, themeState) {
                          return DropDownWidget(
                              text: AppLocalizations.of(context)!.chooseTheme,
                              items: [
                                AppLocalizations.of(context)!.system,
                                AppLocalizations.of(context)!.dark,
                                AppLocalizations.of(context)!.light,
                              ],
                              value: themeState.themesSettings!.themeMode.index,
                              onChanged: (int choice) {
                                switch (choice) {
                                  case 0:
                                    context
                                        .read<ThemeCubit>()
                                        .updateThemeMode(ThemeModeEnum.system);
                                    break;
                                  case 1:
                                    context
                                        .read<ThemeCubit>()
                                        .updateThemeMode(ThemeModeEnum.dark);
                                    break;
                                  case 2:
                                    context
                                        .read<ThemeCubit>()
                                        .updateThemeMode(ThemeModeEnum.light);
                                    break;
                                }
                              });
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MaterialButton(
                        color: Theme.of(context).primaryColor,
                        textColor:
                            Theme.of(context).textTheme.bodyLarge?.color ??
                                Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Changer les thèmes',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ThemesSwap(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  const DraggableZoneWidget(),
                  SettingsCardWidget(
                    name: 'Connexion',
                    widgets: [
                      MaterialButton(
                        color: const Color(0xffbf616a),
                        textColor: Colors.white70,
                        child: Text('Déconnexion',
                            style: TextStyle(fontSize: 17.sp)),
                        onPressed: () => SettingsLogic.logout(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  SettingsCardWidget(
                      name: AppLocalizations.of(context)!.cache,
                      widgets: [
                        MaterialButton(
                          color: const Color(0xffbf616a),
                          textColor: Colors.white70,
                          child: Text('Vider le cache des notes',
                              style: TextStyle(fontSize: 17.sp)),
                          onPressed: () {
                            CacheService.reset<TeachingUnitList>();
                            CacheService.reset<SemesterList>();
                            context.read<TomussCubit>().load(
                                lyon1Cas: context
                                    .read<AuthentificationCubit>()
                                    .state
                                    .lyon1Cas,
                                cache: false,
                                settings: context
                                    .read<SettingsCubit>()
                                    .state
                                    .settings);
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
                                settings: context
                                    .read<SettingsCubit>()
                                    .state
                                    .settings,
                                cache: false);
                          },
                        ),
                        MaterialButton(
                          color: const Color(0xffbf616a),
                          textColor: Colors.white70,
                          child: Text('Vider le cache des mails',
                              style: TextStyle(fontSize: 17.sp)),
                          onPressed: () {
                            CacheService.reset<MailBoxList>();
                            context.read<EmailCubit>().load(
                                  cache: false,
                                  blockTrackers: context
                                      .read<SettingsCubit>()
                                      .state
                                      .settings
                                      .blockTrackers,
                                  appLocalizations:
                                      AppLocalizations.of(context)!,
                                );
                          },
                        ),
                        MaterialButton(
                          color: const Color(0xffbf616a),
                          textColor: Colors.white70,
                          child: Text(
                              AppLocalizations.of(context)!.clearIzlyCache,
                              style: TextStyle(fontSize: 17.sp)),
                          onPressed: () {
                            CacheService.reset<IzlyQrCodeList>();
                            CacheService.reset<IzlyPaymentModelList>();
                            CacheService.reset<IzlyCredential>();
                            Hive.deleteBoxFromDisk("cached_qr_code");
                            Hive.deleteBoxFromDisk("cached_izly_amount");
                            context.read<IzlyCubit>().resetCubit();
                            context.read<IzlyCubit>().connect(
                                settings: context
                                    .read<SettingsCubit>()
                                    .state
                                    .settings);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                  SettingsCardWidget(
                      name: AppLocalizations.of(context)!.notifications,
                      widgets: [
                        MaterialButton(
                          color: const Color(0xffbf616a),
                          textColor: Colors.white70,
                          child: Text(
                              AppLocalizations.of(context)!
                                  .checkForNewNotifications,
                              style: TextStyle(fontSize: 17.sp)),
                          onPressed: () {
                            backgroundLogic(init: false);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                  const SettingsLinkWidget(),
                ],
              ),
            )
          ])),
    );
  }
}
