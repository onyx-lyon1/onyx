import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:oloid2/core/initialisations/custom_scroll_behavior.dart';
import 'package:oloid2/core/theme/theme.dart';
import 'package:oloid2/core/widgets/states_displaying/custom_circular_progress_indicator_widget.dart';
import 'package:oloid2/screens/agenda/states/agenda_cubit.dart';
import 'package:oloid2/screens/login/pages/login_page.dart';
import 'package:oloid2/screens/login/states/authentification_cubit.dart';
import 'package:oloid2/screens/mails/states/email_cubit.dart';
import 'package:oloid2/screens/settings/states/settings_cubit.dart';
import 'package:oloid2/screens/tomuss/states/tomuss_cubit.dart';
import 'package:sizer/sizer.dart';

import 'home.dart';
import 'screens/agenda/domain/model/day_model.dart';
import 'screens/tomuss/domain/model/school_subject_model.dart';

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
        ],
        child: BlocBuilder<AuthentificationCubit, AuthentificationState>(
          builder: (context, authState) {
            return BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, settingsState) {
                if (settingsState.status == SettingsStatus.ready ||
                    settingsState.status == SettingsStatus.error) {
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
                      home:
                          (context.read<AuthentificationCubit>().state.status ==
                                  AuthentificationStatus.authentificated)
                              ? const Home()
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
