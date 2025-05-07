import 'dart:async';

import 'package:onyx/screens/settings/domain/model/settings_model.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/notifications/notifications_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/core/cache_service.dart';

Future<void> izlyNotificationLogic(
    SettingsModel settings, AppLocalizations localizations) async {
  if (settings.izlyNotification) {
    if (await CacheService.exist<IzlyState>()) {
      IzlyState state = (await CacheService.get<IzlyState>())!;
      if (state.status == IzlyStatus.loaded) {
        if (state.balance < 3.3) {
          // Schedule notification for tomorrow at 11 AM
          DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
          DateTime notificationTime =
              DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 11);
          Duration delay = notificationTime.difference(DateTime.now());
          Timer(delay, () {
            NotificationLogic.showNotification(
                title: localizations.izlyNotEnoughMoneyTitle,
                body: localizations.izlyNotEnoughMoneyBody(state.balance),
                payload: localizations.izlyNotEnoughMoneyTitle);
          });
        }
      }
    }
  }
}
