// ignore_for_file: use_build_context_synchronously

import 'package:biometric_storage/biometric_storage.dart';
import 'package:dartus/tomuss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class SettingsSettingsWidget extends StatelessWidget {
  const SettingsSettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Attention"),
                          content: const Text(
                              "L'authentification par empreinte digital désactive les notifications"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  value = false;
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
              }
              Credential? creds;
              IzlyCredential? izlyCreds;
              try {
                creds = await CacheService.get<Credential>(
                    secureKey: await CacheService.getEncryptionKey(!value));
              } catch (e) {
                creds = null;
              }
              try {
                izlyCreds = await CacheService.get<IzlyCredential>(
                    secureKey: await CacheService.getEncryptionKey(!value));
              } catch (e) {
                izlyCreds = null;
              }
              await CacheService.reset<Credential>();
              await CacheService.reset<IzlyCredential>();
              CacheService.secureKey = null;
              if (creds != null) {
                await CacheService.set<Credential>(creds,
                    secureKey: await CacheService.getEncryptionKey(value));
              }
              if (izlyCreds != null) {
                await CacheService.set<IzlyCredential>(izlyCreds,
                    secureKey: await CacheService.getEncryptionKey(value));
              }
              context.read<SettingsCubit>().modify(
                  settings: context
                      .read<SettingsCubit>()
                      .state
                      .settings
                      .copyWith(biometricAuth: value));
            }),
      ],
    );
  }
}
