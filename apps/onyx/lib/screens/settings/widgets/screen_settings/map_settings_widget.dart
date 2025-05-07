import 'package:flutter/material.dart';
import 'package:onyx/l10n/app_localizations.dart';

class MapSettingsWidget extends StatelessWidget {
  const MapSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context).yetNothingToConfigure);
  }
}
