import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/initialisations/initialisations_export.dart';
import 'package:onyx/core/res.dart';
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
    cacheInit();
    await NotificationLogic.init();
  }
  SettingsModel settings = await SettingsLogic.load();

  if (!settings.firstLogin && !settings.biometricAuth) {
    Lyon1CasClient lyon1Cas = Lyon1CasClient();
    var result = await lyon1Cas.authenticate(
        (CacheService.get<Credential>(
            secureKey: await CacheService.getEncryptionKey(false), permanent: true))!);
    if (!result.authResult) return false;
    await tomussNotificationLogic(settings, lyon1Cas);
    await emailNotificationLogic(settings);
    await agendaNotificationLogic(settings, lyon1Cas);
    await izlyNotificationLogic(settings);
  }
  return Future.value(true);
}
