import 'dart:convert';

import 'package:home_widget/home_widget.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/domain/model/settings_model.dart';

String encodeDays(
  List<Day> days,
  DateTime today,
  int daysLimit,
  List<int> disabledDays,
) {
  final eventsList = days
      .where(
        (day) =>
            !day.date.isBefore(today) &&
            !day.date.isAfter(today.add(Duration(days: daysLimit - 1))) &&
            !disabledDays.contains(day.date.weekday) &&
            (day.events.isNotEmpty || Res.agendaWidgetShowEmptyDays),
      )
      .map((day) => day.toMap())
      .toList();
  return jsonEncode(eventsList);
}

void updateEvents(List<Day> days, SettingsModel settings) {
  DateTime now = DateTime.now();
  String encodedDays = encodeDays(
    days,
    now,
    Res.agendaWidgetDaysStored,
    settings.agendaDisabledDays,
  );
  HomeWidget.saveWidgetData<String>('agenda_events', encodedDays);
  HomeWidget.saveWidgetData<String>(
    'agenda_last_update',
    now.toLocal().toIso8601String(),
  );
  HomeWidget.updateWidget(
    name: Res.agendaWidgetName,
    iOSName: Res.agendaWidgetName,
    androidName: Res.agendaWidgetName,
  );
}
