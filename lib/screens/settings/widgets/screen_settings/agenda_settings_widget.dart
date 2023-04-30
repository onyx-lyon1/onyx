import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class AgendaSettingsWidget extends StatelessWidget {
  const AgendaSettingsWidget({Key? key, required this.sizeUpdate})
      : super(key: key);
  final VoidCallback sizeUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextSwitchWidget(
          text: 'Montrer le mini calendrier en haut de page',
          value: context.read<SettingsCubit>().state.settings.showMiniCalendar,
          onChanged: (bool b) {
            context.read<SettingsCubit>().modify(
                settings: context
                    .read<SettingsCubit>()
                    .state
                    .settings
                    .copyWith(showMiniCalendar: b));
          },
        ),
        if ((Platform.isAndroid || Platform.isIOS) &&
            !context.read<SettingsCubit>().state.settings.biometricAuth)
          TextSwitchWidget(
            text: 'Notification en cas de modification de l\'agenda',
            value: context
                .read<SettingsCubit>()
                .state
                .settings
                .calendarUpdateNotification,
            onChanged: (bool b) {
              context.read<SettingsCubit>().modify(
                  settings: context
                      .read<SettingsCubit>()
                      .state
                      .settings
                      .copyWith(calendarUpdateNotification: b));
            },
          ),
        AgendaUrlParameterWidget(sizeUpdate: sizeUpdate),
      ],
    );
  }
}
