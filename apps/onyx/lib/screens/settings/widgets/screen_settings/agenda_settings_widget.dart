import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/date_extension.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgendaSettingsWidget extends StatelessWidget {
  const AgendaSettingsWidget({super.key, required this.sizeUpdate});
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
        TextSwitchWidget(
          text: 'Affichage des agendas de bas en haut',
          value: settings.agendaPageTopToBottom,
          onChanged: (bool b) {
            context
                .read<SettingsCubit>()
                .modify(settings: settings.copyWith(agendaPageTopToBottom: b));
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
                  if (settings.agendaWeekRerenceAlignement >= d) {
                    context.read<SettingsCubit>().modify(
                        settings: settings.copyWith(
                            agendaWeekRerenceAlignement: d.toInt() - 1,
                            agendaWeekLength: d.toInt()));
                  } else {
                    context.read<SettingsCubit>().modify(
                        settings:
                            settings.copyWith(agendaWeekLength: d.toInt()));
                  }
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
                elements: weekDaysShort,
                colorCondition: (i) => i == settings.agendaWeekReference,
                disabledCondition: (i) =>
                    settings.agendaDisabledDays.contains(i + 1),
                onTap: (int i) => context.read<SettingsCubit>().modify(
                      settings: settings.copyWith(agendaWeekReference: i),
                    ),
              ),
              SizedBox(
                height: 5.h,
                child: Material(
                  color: 8 == settings.agendaWeekReference
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor,
                  child: InkWell(
                    onTap: () => context.read<SettingsCubit>().modify(
                        settings: settings.copyWith(agendaWeekReference: 8)),
                    child: const Center(child: Text("Aujourd'hui")),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              const Text('Alignement du Jour de référence'),
              SizedBox(
                height: 1.h,
              ),
              AgendaWeekDaySelector(
                  elements: List.generate(7, (index) => (index + 1).toString()),
                  colorCondition: (i) =>
                      i == settings.agendaWeekRerenceAlignement,
                  disabledCondition: (i) => settings.agendaWeekLength <= i,
                  onTap: (int i) => context.read<SettingsCubit>().modify(
                      settings:
                          settings.copyWith(agendaWeekRerenceAlignement: i))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              const Text('Jour caché'),
              SizedBox(
                height: 1.h,
              ),
              AgendaWeekDaySelector(
                elements: weekDaysShort,
                colorCondition: (i) =>
                    settings.agendaDisabledDays.contains(i + 1),
                onTap: (int rawI) {
                  int i = rawI + 1;
                  if (settings.agendaDisabledDays.contains(i)) {
                    context.read<SettingsCubit>().modify(
                        settings: settings.copyWith(
                            agendaDisabledDays: settings.agendaDisabledDays
                                .where((element) => element != i)
                                .toList()));
                  } else {
                    if (settings.agendaDisabledDays.length == 6) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text(
                            'Vous ne pouvez pas cacher tous les jours'),
                        backgroundColor: Theme.of(context).primaryColor,
                      ));

                      return;
                    } else {
                      if (settings.agendaWeekReference == rawI) {
                        for (var rawj = 1; rawj < 8; rawj++) {
                          int j = (settings.agendaWeekReference + rawj) % 7;
                          if (!settings.agendaDisabledDays.contains(j + 1) &&
                              j != rawI) {
                            context.read<SettingsCubit>().modify(
                                    settings: settings.copyWith(
                                        agendaWeekReference: j,
                                        agendaDisabledDays: [
                                      ...settings.agendaDisabledDays,
                                      i
                                    ]));
                            break;
                          }
                        }
                      } else {
                        context.read<SettingsCubit>().modify(
                                settings: settings.copyWith(
                                    agendaDisabledDays: [
                                  ...settings.agendaDisabledDays,
                                  i
                                ]));
                      }
                    }
                  }
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
