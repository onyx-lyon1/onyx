import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/l10n/app_localizations.dart';

import '../../settings_export.dart';

class MapSettingsWidget extends StatelessWidget {
  const MapSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Text(AppLocalizations.of(context).yetNothingToConfigure);
      },
    );
  }
}
