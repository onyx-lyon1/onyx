// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/cache_service.dart';
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
            text: "Activer l'authentification par empreinte digitale",
            value: context.read<SettingsCubit>().state.settings.biometricAuth,
            onChanged: (value) async {
              if (value) {
                final canAuthenticate =
                    await BiometricStorage().canAuthenticate();
                if (canAuthenticate != CanAuthenticateResponse.success) {
                  //show alert dialog
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Erreur"),
                            content: const Text(
                                "Impossible d'activer l'authentification par empreinte digitale"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"))
                            ],
                          ));
                  return;
                }
                bool undo = false;
                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Attention"),
                          content: const Text(
                              "L'authentification par empreinte digitale désactive les notifications"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  undo = true;
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Annuler")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"))
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
                      .state
                      .settings
                      .copyWith(biometricAuth: value));
            },
          ),
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return TextSwitchWidget(
              text: 'Changer automatiquement au theme selectionné',
              value: themeState.themesUserData!.changeAutoTheme,
              onChanged: (bool value) {
                context.read<ThemeCubit>().setChangeAutoTheme(value);
              },
            );
          },
        ),
      ],
    );
  }
}
