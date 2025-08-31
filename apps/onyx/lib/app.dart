import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/core/screens/bloc_connections/bloc_connection_screen.dart';
import 'package:onyx/core/screens/home/home_export.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/examen/states/examen_cubit.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/settings/states/theme_cubit.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/widgets/states_displaying/state_displaying_widget_export.dart';

class OnyxApp extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  final ThemeSettingsModel theme;
  final SettingsModel settings;

  const OnyxApp({super.key, required this.theme, required this.settings});

  @override
  State<StatefulWidget> createState() {
    return OnyxAppState();
  }
}

class OnyxAppState extends State<OnyxApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final platformLocal = Platform.localeName.split("_");
    Locale? locale;
    if (platformLocal.length > 1) {
      locale = Locale(platformLocal[0], platformLocal[1]);
    } else if (platformLocal.isNotEmpty) {
      locale = Locale(platformLocal[0]);
    }

    return ResponsiveSizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
          BlocProvider<AuthentificationCubit>(
              create: (context) => AuthentificationCubit(widget.settings)),
          BlocProvider<SettingsCubit>(
              create: (context) => SettingsCubit(settings: widget.settings)),
          BlocProvider<EmailCubit>(create: (context) => EmailCubit()),
          BlocProvider<AgendaCubit>(create: (context) => AgendaCubit()),
          BlocProvider<TomussCubit>(create: (context) => TomussCubit()),
          BlocProvider<MapCubit>(create: (context) => MapCubit()),
          BlocProvider<IzlyCubit>(create: (context) => IzlyCubit()),
          BlocProvider<ExamenCubit>(create: (context) => ExamenCubit()),
          BlocProvider<ThemeCubit>(
              create: (context) => ThemeCubit(themeSettings: widget.theme)),
        ],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settingsState) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                return MaterialApp(
                  title: lookupAppLocalizations(const Locale("fr")).onyx,
                  navigatorKey: OnyxApp.navigatorKey,
                  scrollBehavior: const CustomScrollBehavior(),
                  debugShowCheckedModeBanner: false,
                  themeMode: themeState.themesSettings!.themeMode.toThemeMode,
                  theme: themeState.lightTheme,
                  darkTheme: themeState.darkTheme,
                  locale: locale,
                  localizationsDelegates: const [
                    LocaleNamesLocalizationsDelegate(),
                    ...AppLocalizations.localizationsDelegates,
                    FlutterQuillLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                  localeListResolutionCallback: (locales, supportedLocales) {
                    if (context.read<SettingsCubit>().state.settings.language !=
                        null) {
                      return Locale(context
                          .read<SettingsCubit>()
                          .state
                          .settings
                          .language!);
                    } else {
                      if (locales != null) {
                        for (var locale in locales) {
                          if (supportedLocales.contains(locale)) {
                            return locale;
                          }
                        }
                      }
                      return const Locale("fr");
                    }
                  },
                  home: BlocConnectionScreen(
                    child: BlocBuilder<AuthentificationCubit,
                        AuthentificationState>(
                      builder: (context, authState) {
                        if (kDebugMode) {
                          print("Device.orientation : ${Device.orientation}");
                          print("Device.deviceType : ${Device.deviceType}");
                          print("Device.screenType : ${Device.screenType}");
                          print("Device.width : ${Device.width}");
                          print("Device.height : ${Device.height}");
                          print(
                              "Device.boxConstraints : ${Device.boxConstraints}");
                          print("Device.aspectRatio : ${Device.aspectRatio}");
                          print("Device.pixelRatio : ${Device.pixelRatio}");
                        }

                        if ((settingsState.status == SettingsStatus.ready ||
                                settingsState.status == SettingsStatus.error) &&
                            (themeState.status != ThemeStateStatus.init)) {
                          if ((authState.status ==
                                      AuthentificationStatus.authentificated ||
                                  authState.status ==
                                      AuthentificationStatus.authentificating ||
                                  (!settingsState.settings.firstLogin &&
                                      !settingsState.settings.biometricAuth)) &&
                              authState.status !=
                                  AuthentificationStatus.needCredential) {
                            return const HomePage();
                          } else {
                            return const LoginPage();
                          }
                        } else {
                          return const CustomCircularProgressIndicatorWidget();
                        }
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
