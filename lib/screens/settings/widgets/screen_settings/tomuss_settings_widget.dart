import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class TomussSettingsWidget extends StatelessWidget {
  const TomussSettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (Platform.isAndroid || Platform.isIOS)
          TextSwitchWidget(
            text: 'Notification en cas de nouvelle note',
            value: context
                .read<SettingsCubit>()
                .state
                .settings
                .newGradeNotification,
            onChanged: (bool b) {
              context.read<SettingsCubit>().modify(
                  settings: context
                      .read<SettingsCubit>()
                      .state
                      .settings
                      .copyWith(newGradeNotification: b));
            },
          ),
        TextSwitchWidget(
          text: 'Forcer les notes en vert',
          value: context.read<SettingsCubit>().state.settings.forceGreen,
          onChanged: (bool b) {
            context.read<SettingsCubit>().modify(
                settings: context
                    .read<SettingsCubit>()
                    .state
                    .settings
                    .copyWith(forceGreen: b));
          },
        ),
        // TextSwitchWidget(
        //   text: 'Montrer les UEs cachées',
        //   value: context
        //       .read<SettingsCubit>()
        //       .state
        //       .settings
        //       .showHiddenUE,
        //   onChanged: (bool b) {
        //     context.read<SettingsCubit>().modify(
        //         settings: context
        //             .read<SettingsCubit>()
        //             .state
        //             .settings
        //             .copyWith(showHiddenUE: b));
        //   },
        // ),
      ],
    );
  }
}
