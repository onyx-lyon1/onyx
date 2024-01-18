import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/screens/bloc_connections/connections/agenda_connections.dart';
import 'package:onyx/screens/agenda/states/agenda_cubit.dart';
import 'package:onyx/screens/login/states/authentification_cubit.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:onyx/screens/settings/states/theme_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsConnection extends BlocListener<SettingsCubit, SettingsState> {
  static SettingsState? previous;

  SettingsConnection({
    super.key,
  }) : super(
          listener: (context, settingsState) {
            ThemeState themeState = context.read<ThemeCubit>().state;
            AuthentificationState authState =
                context.read<AuthentificationCubit>().state;
            if ((settingsState.status == SettingsStatus.ready ||
                settingsState.status == SettingsStatus.error)) {
              if (authState.status == AuthentificationStatus.initial) {
                context
                    .read<AuthentificationCubit>()
                    .login(settings: settingsState.settings,
                    appLocalizations: AppLocalizations.of(context)!
                    );
              }
            }

            if (themeState.status != ThemeStateStatus.init) {
              context.read<ThemeCubit>().init();
            }

            //update agenda if the ids are changed
            if (previous != null &&
                (!listEquals(previous!.settings.agendaIds,
                        settingsState.settings.agendaIds) ||
                    previous!.settings.fetchAgendaAuto !=
                        settingsState.settings.fetchAgendaAuto)) {
              context.read<AgendaCubit>().load(
                  lyon1Cas:
                      context.read<AuthentificationCubit>().state.lyon1Cas,
                  settings: settingsState.settings,
                  cache: false);
              if (settingsState.settings.colloscopeEnabled == null) {
                AgendaConnection.updateColloscopeEnabled(context);
              }
            }
            previous = settingsState;
          },
        );
}
