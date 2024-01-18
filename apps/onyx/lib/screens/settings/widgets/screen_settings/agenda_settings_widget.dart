import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/date_extension.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AgendaSettingsWidget extends StatelessWidget {
  const AgendaSettingsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsCubit>().state.settings;
    return Column(
      children: [
        TextSwitchWidget(
          text: AppLocalizations.of(context)!.showMiniCalendar,
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
            text: AppLocalizations.of(context)!.calendarUpdateNotification,
            value: settings.calendarUpdateNotification,
            onChanged: (bool b) {
              context.read<SettingsCubit>().modify(
                  settings: settings.copyWith(calendarUpdateNotification: b));
            },
          ),
        TextSwitchWidget(
          text: AppLocalizations.of(context)!.agendaPageBottomToTop,
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
              Text(AppLocalizations.of(context)!.agendaWeekLength),
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
              Text(AppLocalizations.of(context)!.agendaWeekReference),
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
                    child: Center(
                        child: Text(AppLocalizations.of(context)!.today)),
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
              Text(AppLocalizations.of(context)!.agendaWeekReferenceAlignement),
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
              Text(AppLocalizations.of(context)!.disabledDays),
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
                        content:
                            Text(AppLocalizations.of(context)!.cantHideAllDays),
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
        const AgendaUrlParameterWidget(),
      ],
    );
  }
}
