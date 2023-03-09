import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class EMailSettingsWidget extends StatelessWidget {
  const EMailSettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (Platform.isAndroid || Platform.isIOS)
          TextSwitchWidget(
            text: 'Notification en cas de nouveau Emails',
            value: context
                .read<SettingsCubit>()
                .state
                .settings
                .newMailNotification,
            onChanged: (bool b) {
              context.read<SettingsCubit>().modify(
                  settings: context
                      .read<SettingsCubit>()
                      .state
                      .settings
                      .copyWith(newMailNotification: b));
            },
          ),
        TextSwitchWidget(
          text: 'Forcer le thème des mails',
          value: context
              .read<SettingsCubit>()
              .state
              .settings
              .darkerMail,
          onChanged: (bool b) {
            context.read<SettingsCubit>().modify(
                settings: context
                    .read<SettingsCubit>()
                    .state
                    .settings
                    .copyWith(darkerMail: b));
          },
        ),

      ],
    );
  }
}
