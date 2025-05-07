import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/l10n/app_localizations.dart';

class MailSettingsWidget extends StatelessWidget {
  const MailSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if ((!kIsWeb && (Platform.isAndroid || Platform.isIOS)) &&
            !context.read<SettingsCubit>().state.settings.biometricAuth)
          TextSwitchWidget(
            text: AppLocalizations.of(context).notifIfNewEmail,
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
          text: AppLocalizations.of(context).forceMailTheme,
          value: context.read<SettingsCubit>().state.settings.forcedMailTheme,
          onChanged: (bool b) {
            context.read<SettingsCubit>().modify(
                settings: context
                    .read<SettingsCubit>()
                    .state
                    .settings
                    .copyWith(forcedMailTheme: b));
            context.read<EmailCubit>().load(
                  blockTrackers: b,
                  cache: false,
                  appLocalizations: AppLocalizations.of(context),
                );
          },
        ),
        TextSwitchWidget(
          text: AppLocalizations.of(context).blockTrackers,
          value: context.read<SettingsCubit>().state.settings.blockTrackers,
          onChanged: (bool b) {
            context.read<SettingsCubit>().modify(
                settings: context
                    .read<SettingsCubit>()
                    .state
                    .settings
                    .copyWith(blockTrackers: b));
          },
        ),
      ],
    );
  }
}
