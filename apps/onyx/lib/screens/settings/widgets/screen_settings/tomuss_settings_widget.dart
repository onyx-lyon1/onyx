import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TomussSettingsWidget extends StatelessWidget {
  const TomussSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if ((!kIsWeb && (Platform.isAndroid || Platform.isIOS)) &&
            !context.read<SettingsCubit>().state.settings.biometricAuth)
          TextSwitchWidget(
            text: AppLocalizations.of(context)!.notifIfNewGrade,
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
          text: AppLocalizations.of(context)!.forceGreenGrade,
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
        //pick the duration of a recent grade
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.recentGradeDuration,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 12,
              ),
            ),
            DropdownButton(
              value: context
                  .read<SettingsCubit>()
                  .state
                  .settings
                  .recentGradeDuration,
              items: [
                for (var i = 0; i <= 10; i++)
                  DropdownMenuItem(
                    value: i,
                    child: Text(AppLocalizations.of(context)!.nDays(i)),
                  ),
              ],
              onChanged: (int? value) {
                context.read<SettingsCubit>().modify(
                    settings: context
                        .read<SettingsCubit>()
                        .state
                        .settings
                        .copyWith(recentGradeDuration: value));
              },
            ),
          ],
        ),
        // TextSwitchWidget(
        //   text: AppLocalizations.of(context)!.showHiddenUE,
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
