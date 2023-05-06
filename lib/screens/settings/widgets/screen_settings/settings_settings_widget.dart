// ignore_for_file: use_build_context_synchronously

import 'dart:io';

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
        if (Platform.isIOS || Platform.isAndroid)
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
                List<int>? unSecureKey = await CacheService.getEncryptionKey(
                    !value,
                    autoRetry: true);
                try {
                  creds = await CacheService.get<Credential>(
                      secureKey: unSecureKey);
                } catch (e) {
                  creds = null;
                }
                try {
                  izlyCreds = await CacheService.get<IzlyCredential>(
                      secureKey: unSecureKey);
                } catch (e) {
                  izlyCreds = null;
                }
                await CacheService.reset<Credential>();
                await CacheService.reset<IzlyCredential>();
                CacheService.secureKey = null;
                try {
                  CacheService.secureKey = await CacheService.getEncryptionKey(
                      value,
                      autoRetry: false);
                } on AuthException catch (e) {
                  if (e.code == AuthExceptionCode.userCanceled) {
                    value = false;
                    return;
                  }
                }
                if (creds != null) {
                  await CacheService.set<Credential>(creds,
                      secureKey: CacheService.secureKey);
                }
                if (izlyCreds != null) {
                  await CacheService.set<IzlyCredential>(izlyCreds,
                      secureKey: CacheService.secureKey);
                }
                context.read<SettingsCubit>().modify(
                    settings: context
                        .read<SettingsCubit>()
                        .state
                        .settings
                        .copyWith(biometricAuth: value));
              })
        else
          const Text("pour l'instant, rien à configurer")
      ],
    );
  }
}
