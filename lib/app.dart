import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/core/initialisations/initialisations_export.dart';
import 'package:oloid2/core/theme/theme_export.dart';
import 'package:oloid2/core/home/pages/home_page.dart';
import 'package:oloid2/screens/agenda/agenda_export.dart';
import 'package:oloid2/screens/login/login_export.dart';
import 'package:oloid2/screens/mails/mails_export.dart';
import 'package:oloid2/screens/map/map_export.dart';
import 'package:oloid2/screens/settings/settings_export.dart';
import 'package:oloid2/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

import 'core/widgets/states_displaying/state_displaying_widget_export.dart';

class OloidApp extends StatefulWidget {
  const OloidApp({Key? key, required this.androidSdkVersion}) : super(key: key);

  final int androidSdkVersion;

  @override
  State<StatefulWidget> createState() {
    return OloidAppState();
  }
}

class OloidAppState extends State<OloidApp> {
  final List<SchoolSubjectModel> teachingUnits = [];
  final List<DayModel> days = [];
  final List<Mail> emails = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthentificationCubit>(
              create: (context) => AuthentificationCubit()),
          BlocProvider<SettingsCubit>(create: (context) => SettingsCubit()),
          BlocProvider<EmailCubit>(create: (context) => EmailCubit()),
          BlocProvider<AgendaCubit>(create: (context) => AgendaCubit()),
          BlocProvider<TomussCubit>(create: (context) => TomussCubit()),
          BlocProvider<MapCubit>(create: (context) => MapCubit()),
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
                      scrollBehavior: const CustomScrollBehavior(),
                      debugShowCheckedModeBanner: false,
                      themeMode: settingsState.settings.themeMode.themeMode,
                      theme: OloidTheme.lighTheme(),
                      darkTheme: OloidTheme.darkTheme(),
                      home:
                          (context.read<AuthentificationCubit>().state.status ==
                                      AuthentificationStatus.authentificated ||
                                  context
                                          .read<AuthentificationCubit>()
                                          .state
                                          .status ==
                                      AuthentificationStatus.authentificating)
                              ? const HomePage()
                              : LoginPage(key: UniqueKey()));
                } else {
                  return const CustomCircularProgressIndicatorWidget();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
