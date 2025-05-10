import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/screens/bloc_connections/connections/agenda_connections.dart';
import 'package:onyx/screens/agenda/states/agenda_cubit.dart';
import 'package:onyx/screens/login/states/authentification_cubit.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:onyx/screens/settings/states/theme_cubit.dart';

class SettingsConnection extends BlocListener<SettingsCubit, SettingsState> {
  static SettingsState? previous;

  SettingsConnection({
    super.key,
  }) : super(
          listener: (context, settingsState) {
            ThemeState themeState = context.read<ThemeCubit>().state;
            AuthState authState = context.read<AuthCubit>().state;

            if (settingsState is SettingsReady) {
              if (authState.status == AuthentificationStatus.initial) {
                context.read<AuthCubit>().login(
                      settings: settingsState.settings,
                    );
              }
            }

            if (themeState.status != ThemeStateStatus.initial) {
              context.read<ThemeCubit>().init();
            }

            //update agenda if the ids are changed
            if (previous != null &&
                previous is SettingsReady &&
                settingsState is SettingsReady) {
              final previousReady = previous as SettingsReady;
              if ((!listEquals(previousReady.settings.agendaIds,
                      settingsState.settings.agendaIds) ||
                  previousReady.settings.fetchAgendaAuto !=
                      settingsState.settings.fetchAgendaAuto)) {
                context.read<AgendaCubit>().load(
                    lyon1Cas: context.read<AuthCubit>().state.lyon1Cas,
                    settings: settingsState.settings,
                    cache: false);
                if (settingsState.settings.colloscopeEnabled == null &&
                    !settingsState.settings.fetchAgendaAuto) {
                  AgendaConnection.updateColloscopeEnabled(context);
                }
              }
            }
            previous = settingsState;
          },
        );
}
