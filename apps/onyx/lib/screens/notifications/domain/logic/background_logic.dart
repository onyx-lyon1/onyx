import 'dart:ui';

import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/notifications/notifications_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void workmanagerHandler() {
  Workmanager().executeTask((task, inputData) async {
    Res.logger.d("background task : $task");
    switch (task) {
      case "check update":
        return await backgroundLogic();
    }
    return Future.value(true);
  });
}

Future<bool> backgroundLogic({bool init = true}) async {
  if (init) {
    await hiveInit();
    await NotificationLogic.init();
  }
  SettingsModel settings = await SettingsLogic.load();
  Locale local = (settings.language != null)
      ? Locale(settings.language!)
      : PlatformDispatcher.instance.locale;
  if (!AppLocalizations.supportedLocales.contains(local)) {
    local = const Locale("fr"); //TODO discuss on maybe changing to english
  }
  AppLocalizations localizations = lookupAppLocalizations(local);

  if (!settings.firstLogin && !settings.biometricAuth) {
    Lyon1CasClient lyon1Cas = Lyon1CasClient();
    var result = await lyon1Cas.authenticate(
        (await CacheService.get<Credential>(
            secureKey: await CacheService.getEncryptionKey(false)))!);
    if (!result) return false;
    await tomussNotificationLogic(settings, lyon1Cas, localizations);
    await emailNotificationLogic(settings, localizations);
    await agendaNotificationLogic(settings, lyon1Cas, localizations);
    await izlyNotificationLogic(settings, localizations);
  }
  return Future.value(true);
}
