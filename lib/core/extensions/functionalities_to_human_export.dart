import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

extension HumanFunctionalities on Functionalities {
  String toCleanString() {
    switch (this) {
      case Functionalities.tomuss:
        return "Notes";
      case Functionalities.agenda:
        return "Agenda";
      case Functionalities.mail:
        return "Email";
      case Functionalities.map:
        return "Carte";
      case Functionalities.izly:
        return "Izly";
      case Functionalities.settings:
        return "Paramètres";
    }
  }

  IconData toIcon() {
    switch (this) {
      case Functionalities.tomuss:
        return Icons.class_rounded;
      case Functionalities.agenda:
        return Icons.calendar_today_rounded;
      case Functionalities.mail:
        return Icons.email_rounded;
      case Functionalities.map:
        return Icons.map_rounded;
      case Functionalities.izly:
        return Icons.attach_money_rounded;
      case Functionalities.settings:
        return Icons.settings_rounded;
    }
  }

  Widget toPage() {
    switch (this) {
      case Functionalities.tomuss:
        return const TomussPage();
      case Functionalities.agenda:
        return const AgendaPage();
      case Functionalities.mail:
        return const EmailsPage();
      case Functionalities.map:
        return const MapPage();
      case Functionalities.izly:
        return const IzlyPage();
      case Functionalities.settings:
        return const SettingsPage();
    }
  }

  Widget toBottomBarIcon({required bool selected}) {
    switch (this) {
      case Functionalities.tomuss:
        return TomussBottomNavBarIcon(selected: selected);
      case Functionalities.agenda:
        return AgendaBottomNavBarIcon(selected: selected);
      case Functionalities.mail:
        return EmailBottomNavBarIcon(selected: selected);
      case Functionalities.map:
        return MapBottomNavBarIcon(selected: selected);
      case Functionalities.izly:
        return IzlyBottomNavBarIconWidget(selected: selected);
      case Functionalities.settings:
        return SettingsBottomNavBarIcon(selected: selected);
    }
  }

  Widget toSettings() {
    switch (this) {
      case Functionalities.tomuss:
        return const TomussSettingsWidget();
      case Functionalities.agenda:
        return const AgendaSettingsWidget();
      case Functionalities.mail:
        return const EMailSettingsWidget();
      case Functionalities.map:
        return const MapSettingsWidget();
      case Functionalities.izly:
        return const IzlySettingsWidget();
      case Functionalities.settings:
        return const SettingsSettingsWidget();
    }
  }
}
