import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/screens/bloc_connections/bloc_connection_screen.dart';
import 'package:onyx/core/screens/home/home_export.dart';
import 'package:onyx/core/theme/theme_export.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/widgets/states_displaying/state_displaying_widget_export.dart';

class OnyxApp extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  const OnyxApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return OnyxAppState();
  }
}

class OnyxAppState extends State<OnyxApp> {
  final List<TeachingUnit> teachingUnits = [];
  final List<Day> days = [];
  final List<Mail> emails = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthentificationCubit>(
              create: (context) => AuthentificationCubit()),
          BlocProvider<SettingsCubit>(create: (context) => SettingsCubit()),
          BlocProvider<EmailCubit>(create: (context) => EmailCubit()),
          BlocProvider<AgendaCubit>(create: (context) => AgendaCubit()),
          BlocProvider<TomussCubit>(create: (context) => TomussCubit()),
          BlocProvider<MapCubit>(create: (context) => MapCubit()),
          BlocProvider<IzlyCubit>(create: (context) => IzlyCubit()),
          BlocProvider<ExamenCubit>(create: (context) => ExamenCubit()),
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        ],
        child: BlocConnectionScreen(
          child: BlocBuilder<AuthentificationCubit, AuthentificationState>(
            builder: (context, authState) {
              if (kDebugMode) {
                print("Device.orientation : ${Device.orientation}");
                print("Device.deviceType : ${Device.deviceType}");
                print("Device.screenType : ${Device.screenType}");
                print("Device.width : ${Device.width}");
                print("Device.height : ${Device.height}");
                print("Device.boxConstraints : ${Device.boxConstraints}");
                print("Device.aspectRatio : ${Device.aspectRatio}");
                print("Device.pixelRatio : ${Device.pixelRatio}");
              }
              return BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, themeState) {
                  return BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, settingsState) {
                      if ((settingsState.status == SettingsStatus.ready ||
                              settingsState.status == SettingsStatus.error) &&
                          (themeState.status != ThemeStateStatus.init)) {
                        return MaterialApp(
                          title:
                              lookupAppLocalizations(const Locale("fr")).onyx,
                          navigatorKey: OnyxApp.navigatorKey,
                          scrollBehavior: const CustomScrollBehavior(),
                          debugShowCheckedModeBanner: false,
                          themeMode:
                              themeState.themesSettings!.themeMode.toThemeMode,
                          theme: themeState.lightTheme,
                          darkTheme: themeState.darkTheme,
                          locale: settingsState.settings.language != null
                              ? Locale(settingsState.settings.language!)
                              : const Locale("fr"),
                          localizationsDelegates:
                              AppLocalizations.localizationsDelegates,
                          supportedLocales: AppLocalizations.supportedLocales,
                          home: (authState.status ==
                                      AuthentificationStatus.authentificated ||
                                  authState.status ==
                                      AuthentificationStatus.authentificating ||
                                  (!settingsState.settings.firstLogin &&
                                      !settingsState.settings.biometricAuth))
                              ? const HomePage()
                              : LoginPage(key: UniqueKey()),
                        );
                      } else {
                        return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          themeMode: ThemeMode.system,
                          theme: OnyxTheme.lightTheme,
                          darkTheme: OnyxTheme.darkTheme,
                          home: Scaffold(
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              body:
                                  const CustomCircularProgressIndicatorWidget()),
                        );
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
