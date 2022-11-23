import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/others/custom_scroll_behavior.dart';
import 'package:oloid2/page/login_page.dart';
import 'package:oloid2/states/agenda/agenda_cubit.dart';
import 'package:oloid2/states/authentification/authentification_cubit.dart';
import 'package:oloid2/states/email/email_cubit.dart';
import 'package:oloid2/states/grades/grades2_cubit.dart';
import 'package:oloid2/states/settings/settings_cubit.dart';
import 'package:oloid2/widget/custom_circular_progress_indicator.dart';
import 'package:sizer/sizer.dart';

import 'home.dart';
import 'model/day_model.dart';
import 'model/teaching_unit.dart';
import 'theme/theme.dart';

class OloidApp extends StatefulWidget {
  const OloidApp({Key? key, required this.androidSdkVersion}) : super(key: key);

  final int androidSdkVersion;

  @override
  State<StatefulWidget> createState() {
    return OloidAppState();
  }
}

class OloidAppState extends State<OloidApp> {
  final List<TeachingUnitModel> teachingUnits = [];
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
          BlocProvider<GradesCubit>(create: (context) => GradesCubit()),
        ],
        child: BlocBuilder<AuthentificationCubit, AuthentificationState>(
          builder: (context, authState) {
            return BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, settingsState) {
                if (settingsState.status == SettingsStatus.ready) {
                  return MaterialApp(
                      title: 'Oloid 2.0',
                      scrollBehavior:
                          const CustomScrollBehavior(androidSdkVersion: 31),
                      debugShowCheckedModeBanner: false,
                      themeMode: settingsState.settings.darkMode
                          ? ThemeMode.dark
                          : ThemeMode.light,
                      theme: OloidTheme.lighTheme(),
                      darkTheme: OloidTheme.darkTheme(),
                      home: (context.read<AuthentificationCubit>().state.status ==
                              AuthentificationStatus.authentificated)
                          ? const Home()
                          : LoginPage(key: UniqueKey()));
                } else {
                  return const CustomCircularProgressIndicator();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
