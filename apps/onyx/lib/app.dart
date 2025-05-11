import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/core/screens/bloc_connections/bloc_connection_screen.dart';
import 'package:onyx/core/screens/home/home_export.dart';
import 'package:onyx/core/widgets/states_displaying/custom_circular_progress_indicator_widget.dart';
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

class OnyxApp extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  const OnyxApp({super.key});

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
          BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
          BlocProvider<SettingsCubit>(create: (context) => SettingsCubit()),
          BlocProvider<EmailCubit>(create: (context) => EmailCubit()),
          BlocProvider<AgendaCubit>(create: (context) => AgendaCubit()),
          BlocProvider<TomussCubit>(create: (context) => TomussCubit()),
          BlocProvider<MapCubit>(create: (context) => MapCubit()),
          BlocProvider<IzlyCubit>(create: (context) => IzlyCubit()),
          BlocProvider<ExamenCubit>(create: (context) => ExamenCubit()),
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        ],
        child: Builder(
          builder: (context) {
            final settingsState = context.watch<SettingsCubit>().state;
            final themeState = context.watch<ThemeCubit>().state;

            return MaterialApp(
              title: lookupAppLocalizations(locale ?? const Locale("fr")).onyx,
              navigatorKey: OnyxApp.navigatorKey,
              scrollBehavior: const CustomScrollBehavior(),
              debugShowCheckedModeBanner: false,
              themeMode: themeState.themesSettings?.themeMode.toThemeMode,
              theme: themeState.lightTheme,
              darkTheme: themeState.darkTheme,
              locale: locale,
              localizationsDelegates: const [
                LocaleNamesLocalizationsDelegate(),
                ...AppLocalizations.localizationsDelegates
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              localeListResolutionCallback: (locales, supportedLocales) {
                if (settingsState is SettingsReady &&
                    settingsState.settings.language != null) {
                  return Locale(settingsState.settings.language!);
                }
                return locales?.firstWhere(supportedLocales.contains,
                        orElse: () => const Locale("fr")) ??
                    const Locale("fr");
              },
              home:
                  BlocConnectionScreen(child: home(settingsState, themeState)),
            );
          },
        ),
      ),
    );
  }

  Widget home(SettingsState settingsState, ThemeState themeState) {
    if (settingsState is! SettingsReady ||
        themeState.status == ThemeStateStatus.initial) {
      return const CustomCircularProgressIndicatorWidget();
    } else if (!settingsState.settings.firstLogin) {
      return const HomePage();
    } else {
      return const LoginPage();
    }
  }
}
