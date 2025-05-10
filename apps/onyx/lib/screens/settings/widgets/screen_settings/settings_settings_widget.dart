// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/settings/states/theme_cubit.dart';

class SettingsSettingsWidget extends StatelessWidget {
  const SettingsSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!kIsWeb && (Platform.isIOS || Platform.isAndroid))
          TextSwitchWidget(
            text: AppLocalizations.of(context).enablebiometricAuth,
            value: context.read<SettingsCubit>().settings.biometricAuth,
            onChanged: (value) async {
              if (value) {
                final canAuthenticate =
                    await BiometricStorage().canAuthenticate();
                if (canAuthenticate != CanAuthenticateResponse.success) {
                  //show alert dialog
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(AppLocalizations.of(context).error),
                            content: Text(AppLocalizations.of(context)
                                .unableToEnableBiometricAuth),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(AppLocalizations.of(context).ok))
                            ],
                          ));
                  return;
                }
                bool undo = false;
                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(AppLocalizations.of(context).warning),
                          content: Text(AppLocalizations.of(context)
                              .enableBiometricAuthDisableNotifications),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  undo = true;
                                  Navigator.of(context).pop();
                                },
                                child:
                                    Text(AppLocalizations.of(context).cancel)),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(AppLocalizations.of(context).ok))
                          ],
                        ));
                if (undo) {
                  value = !value;
                  return;
                }
              }

              await CacheService.toggleBiometricAuth(value);
              context.read<SettingsCubit>().modify(
                  settings: context
                      .read<SettingsCubit>()
                      .settings
                      .copyWith(biometricAuth: value));
            },
          ),
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return TextSwitchWidget(
              text: AppLocalizations.of(context).autoChangeTheme,
              value: themeState.themesSettings!.autoSwitchTheme,
              onChanged: (bool value) {
                context.read<ThemeCubit>().updateAutoSwitchTheme(value);
              },
            );
          },
        ),
      ],
    );
  }
}
