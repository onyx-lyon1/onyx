import 'package:convenient_test/convenient_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1mail/lyon1mail.dart';
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

  const OnyxApp({Key? key, required this.androidSdkVersion}) : super(key: key);

  final int androidSdkVersion;

  @override
  State<StatefulWidget> createState() {
    return OnyxAppState();
  }
}

class OnyxAppState extends State<OnyxApp> {
  final List<SchoolSubjectModel> teachingUnits = [];
  final List<DayModel> days = [];
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
          child: BlocConsumer<AuthentificationCubit, AuthentificationState>(
            listener: (context, state) {
              if (state.status == AuthentificationStatus.authentificated) {
                context.read<EmailCubit>().connect(
                    username:
                        context.read<AuthentificationCubit>().state.username!,
                    password:
                        context.read<AuthentificationCubit>().state.password!);
                context.read<AgendaCubit>().load(
                    dartus: state.dartus!,
                    settings: context.read<SettingsCubit>().state.settings);
                context.read<TomussCubit>().load(dartus: state.dartus!);
              }
            },
            builder: (context, authState) {
              return BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, settingsState) {
                  if (settingsState.status == SettingsStatus.ready ||
                      settingsState.status == SettingsStatus.error) {
                    return MaterialApp(
                        title: 'Oloid 2.0',
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
                                !context
                                    .read<AuthentificationCubit>()
                                    .state
                                    .firstLogin)
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
