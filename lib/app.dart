import 'package:convenient_test/convenient_test.dart';
import 'package:dartus/tomuss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/core/screens/home/home_export.dart';
import 'package:onyx/core/theme/theme_export.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

import 'core/widgets/states_displaying/state_displaying_widget_export.dart';

class OnyxApp extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  const OnyxApp({Key? key}) : super(key: key);

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
    return ConvenientTestWrapperWidget(
      child: Sizer(
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
          ],
          child: BlocBuilder<AuthentificationCubit, AuthentificationState>(
            builder: (context, authState) {
              if (authState.status == AuthentificationStatus.initial) {
                CacheService.getEncryptionKey(context
                        .read<SettingsCubit>()
                        .state
                        .settings
                        .biometricAuth)
                    .then((key) => CacheService.get<Credential>(secureKey: key)
                        .then((value) => context
                            .read<AuthentificationCubit>()
                            .login(
                                creds: value,
                                settings: context
                                    .read<SettingsCubit>()
                                    .state
                                    .settings)));
              }
              if (authState.status == AuthentificationStatus.authentificated) {
                context.read<SettingsCubit>().modify(
                    settings: context
                        .read<SettingsCubit>()
                        .state
                        .settings
                        .copyWith(firstLogin: false));
                CacheService.getEncryptionKey(context
                        .read<SettingsCubit>()
                        .state
                        .settings
                        .biometricAuth)
                    .then((key) => CacheService.get<Credential>(secureKey: key)
                        .then((value) => context.read<EmailCubit>().connect(
                            username: value!.username,
                            password: value.password)));
                context.read<AgendaCubit>().load(
                    dartus: authState.dartus!,
                    settings: context.read<SettingsCubit>().state.settings);
                context.read<TomussCubit>().load(
                      dartus: authState.dartus!,
                      settings: context.read<SettingsCubit>().state.settings,
                    );
              }
              return BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, settingsState) {
                  if (settingsState.status == SettingsStatus.ready ||
                      settingsState.status == SettingsStatus.error) {
                    if (authState.status ==
                        AuthentificationStatus.authentificated) {
                      context.read<SettingsCubit>().modify(
                          settings: context
                              .read<SettingsCubit>()
                              .state
                              .settings
                              .copyWith(firstLogin: false));
                    }
                    return MaterialApp(
                        title: 'Onyx',
                        navigatorKey: OnyxApp.navigatorKey,
                        scrollBehavior: const CustomScrollBehavior(),
                        debugShowCheckedModeBanner: false,
                        themeMode: settingsState.settings.themeMode.themeMode,
                        theme: OnyxTheme.lighTheme(),
                        darkTheme: OnyxTheme.darkTheme(),
                        // showPerformanceOverlay: true,
                        home: (context
                                        .read<AuthentificationCubit>()
                                        .state
                                        .status ==
                                    AuthentificationStatus.authentificated ||
                                context
                                        .read<AuthentificationCubit>()
                                        .state
                                        .status ==
                                    AuthentificationStatus.authentificating ||
                                !settingsState.settings.firstLogin)
                            ? const HomePage()
                            : LoginPage(key: UniqueKey()));
                  } else {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      themeMode: settingsState.settings.themeMode.themeMode,
                      theme: OnyxTheme.lighTheme(),
                      darkTheme: OnyxTheme.darkTheme(),
                      home: Scaffold(
                          backgroundColor:
                              OnyxTheme.darkTheme().colorScheme.background,
                          body: const CustomCircularProgressIndicatorWidget()),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
