import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/notifications/notifications_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/l10n/app_localizations.dart';

Future<void> agendaNotificationLogic(SettingsModel settings,
    Lyon1CasClient lyon1Cas, AppLocalizations localizations) async {
  if (settings.calendarUpdateNotification) {
    if (await CacheService.exist<Agenda>()) {
      List<Day> days = (await CacheService.get<Agenda>())!.days;

      List<Day> newDays = await AgendaLogic.load(
          agendaClient: Lyon1AgendaClient.useLyon1Cas(lyon1Cas),
          settings: settings,
          ids: (settings.fetchAgendaAuto
              ? (await Lyon1AgendaClient.useLyon1Cas(lyon1Cas).getAgendaIds)
              : settings.agendaIds));
      List<Day> notifyDays = [];
      for (var i in newDays) {
        if (i.date.isAfter(DateTime.now()) &&
            i.date
                    .difference(DateTime.now())
                    .compareTo(const Duration(days: 14)) <
                0 &&
            (!days.any((element) => element == i))) {
          notifyDays.add(i);
        }
      }
      if (notifyDays.length > 4) {
        await NotificationLogic.showNotification(
            title: localizations.newEvent,
            body: localizations.nDayModified(notifyDays.length),
            payload: localizations.newEvent);
      } else {
        for (var i in notifyDays) {
          await NotificationLogic.showNotification(
              title: localizations.newEvent,
              body: localizations.newEventAt(i.date),
              payload: localizations.newEvent);
        }
      }
      await CacheService.set<Agenda>(Agenda(newDays));
    }
  }
}
