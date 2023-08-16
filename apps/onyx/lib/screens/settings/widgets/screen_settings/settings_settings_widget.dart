// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class SettingsSettingsWidget extends StatelessWidget {
  const SettingsSettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!kIsWeb && (Platform.isIOS || Platform.isAndroid))
          TextSwitchWidget(
            text: "Activer l'authentification par empreinte digital",
            value: context.read<SettingsCubit>().state.settings.biometricAuth,
            onChanged: (value) async {
              if (value) {
                final canAuthentificate =
                    await BiometricStorage().canAuthenticate();
                if (canAuthentificate != CanAuthenticateResponse.success) {
                  //show alert dialog
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Erreur"),
                            content: const Text(
                                "Impossible d'activer l'authentification par empreinte digital"),
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
                              "L'authentification par empreinte digital désactive les notifications"),
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
          )
        else
          const Text("pour l'instant, rien à configurer")
      ],
    );
  }
}
