import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
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

import 'core/widgets/states_displaying/state_displaying_widget_export.dart';

// class OnyxApp extends StatelessWidget {
//   const OnyxApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp();
//   }
// }

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
    // return MaterialApp();
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
        ],
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

            if (authState.status == AuthentificationStatus.authentificated) {
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
                  lyon1Cas: authState.lyon1Cas,
                  settings: context.read<SettingsCubit>().state.settings);
              context.read<TomussCubit>().load(
                    lyon1Cas: authState.lyon1Cas,
                    settings: context.read<SettingsCubit>().state.settings,
                    force: true,
                  );
            }
            return BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, settingsState) {
                print("${authState.status} | ${settingsState.status}");
                print("first login : ${settingsState.settings.firstLogin}");
                if (settingsState.status == SettingsStatus.ready ||
                    settingsState.status == SettingsStatus.error) {
                  print("settings ready");
                  if (authState.status == AuthentificationStatus.initial) {
                    print("authentification initial");
                    context
                        .read<AuthentificationCubit>()
                        .login(settings: settingsState.settings);
                  } else if (authState.status ==
                          AuthentificationStatus.authentificated &&
                      settingsState.settings.firstLogin) {
                    print("first login");
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
                      home: (authState.status ==
                                  AuthentificationStatus.authentificated ||
                              authState.status ==
                                  AuthentificationStatus.authentificating ||
                              (!settingsState.settings.firstLogin &&
                                  !settingsState.settings.biometricAuth))
                          ? const HomePage()
                          : LoginPage(key: UniqueKey()));
                } else {
                  context.read<SettingsCubit>().load();
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
    );
  }
}
