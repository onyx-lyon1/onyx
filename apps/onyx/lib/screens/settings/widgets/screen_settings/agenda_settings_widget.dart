import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgendaSettingsWidget extends StatelessWidget {
  const AgendaSettingsWidget({Key? key, required this.sizeUpdate})
      : super(key: key);
  final VoidCallback sizeUpdate;

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsCubit>().state.settings;
    return Column(
      children: [
        TextSwitchWidget(
          text: 'Montrer le mini calendrier en haut de page',
          value: settings.showMiniCalendar,
          onChanged: (bool b) {
            context
                .read<SettingsCubit>()
                .modify(settings: settings.copyWith(showMiniCalendar: b));
          },
        ),
        if ((!kIsWeb && (Platform.isAndroid || Platform.isIOS)) &&
            !settings.biometricAuth)
          TextSwitchWidget(
            text: 'Notification en cas de modification de l\'agenda',
            value: settings.calendarUpdateNotification,
            onChanged: (bool b) {
              context.read<SettingsCubit>().modify(
                  settings: settings.copyWith(calendarUpdateNotification: b));
            },
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              const Text('Nombre de jours affichés en mode semaine'),
              Slider(
                value: settings.agendaWeekLength.toDouble(),
                onChanged: (double d) {
                  context.read<SettingsCubit>().modify(
                      settings: settings.copyWith(agendaWeekLength: d.toInt()));
                },
                min: 2,
                max: 7,
                divisions: 7 - 2,
                label: settings.agendaWeekLength.toString(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              const Text('Jour de référence en mode semaine'),
              SizedBox(
                height: 1.h,
              ),
              AgendaWeekDaySelector(
                  colorCondition: (i) => i == settings.agendaWeekReference,
                  onTap: (int i) => context.read<SettingsCubit>().modify(
                      settings: settings.copyWith(agendaWeekReference: i))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              const Text('Jour désactivé en mode semaine'),
              SizedBox(
                height: 1.h,
              ),
              AgendaWeekDaySelector(
                colorCondition: (i) =>
                    settings.agendaDisabledDays.contains(i + 1),
                onTap: (int rawI) {
                  int i = rawI + 1;
                  context.read<SettingsCubit>().modify(
                      settings: settings.copyWith(
                          agendaDisabledDays:
                              settings.agendaDisabledDays.contains(i)
                                  ? settings.agendaDisabledDays
                                      .where((element) => element != i)
                                      .toList()
                                  : [...settings.agendaDisabledDays, i]));
                },
              ),
            ],
          ),
        ),
        AgendaUrlParameterWidget(sizeUpdate: sizeUpdate),
      ],
    );
  }
}
