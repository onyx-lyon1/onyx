import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/examen/pages/examen_page.dart';
import 'package:onyx/screens/examen/widgets/examen_bottom_nav_bar_icon.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/settings/widgets/screen_settings/examen_settings_widget.dart';
import 'package:onyx/screens/settings/widgets/screen_settings/email_settings_widget.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension FunctionalitiesExtention on Functionalities {
  String toCleanString(AppLocalizations localizations) {
    switch (this) {
      case Functionalities.tomuss:
        return localizations.tomuss;
      case Functionalities.agenda:
        return localizations.agenda;
      case Functionalities.mail:
        return localizations.mails;
      case Functionalities.map:
        return localizations.map;
      case Functionalities.izly:
        return localizations.izly;
      case Functionalities.settings:
        return localizations.settings;
      case Functionalities.examen:
        return localizations.exams;
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
      case Functionalities.examen:
        return Icons.school_rounded;
    }
  }

  Widget toPage() {
    switch (this) {
      case Functionalities.tomuss:
        return const TomussPage();
      case Functionalities.agenda:
        return const AgendaPage();
      case Functionalities.mail:
        return const MailsPage();
      case Functionalities.map:
        return const MapPage();
      case Functionalities.izly:
        return const IzlyPage();
      case Functionalities.settings:
        return const SettingsPage();
      case Functionalities.examen:
        return const ExamenPage();
    }
  }

  Widget toBottomBarIcon({required bool selected}) {
    switch (this) {
      case Functionalities.tomuss:
        return TomussBottomNavBarIcon(selected: selected);
      case Functionalities.agenda:
        return AgendaBottomNavBarIcon(selected: selected);
      case Functionalities.mail:
        return MailBottomNavBarIcon(selected: selected);
      case Functionalities.map:
        return MapBottomNavBarIcon(selected: selected);
      case Functionalities.izly:
        return IzlyBottomNavBarIcon(selected: selected);
      case Functionalities.settings:
        return SettingsBottomNavBarIcon(selected: selected);
      case Functionalities.examen:
        return ExamenBottomNavBarIcon(selected: selected);
    }
  }

  Widget toSettings({Key? key, VoidCallback? sizeUpdate}) {
    switch (this) {
      case Functionalities.tomuss:
        return TomussSettingsWidget(
          key: key,
        );
      case Functionalities.agenda:
        return AgendaSettingsWidget(
          key: key,
        );
      case Functionalities.mail:
        return MailSettingsWidget(
          key: key,
        );
      case Functionalities.map:
        return MapSettingsWidget(
          key: key,
        );
      case Functionalities.izly:
        return IzlySettingsWidget(
          key: key,
        );
      case Functionalities.settings:
        return SettingsSettingsWidget(
          key: key,
        );
      case Functionalities.examen:
        return ExamenSettingsWidget(
          key: key,
        );
    }
  }
}
