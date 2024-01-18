import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/states/agenda_cubit.dart';
import 'package:onyx/screens/examen/examen_export.dart';
import 'package:onyx/screens/login/states/authentification_cubit.dart';
import 'package:onyx/screens/settings/domain/model/settings_model.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:onyx/screens/tomuss/states/tomuss_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AgendaConnection extends BlocListener<AgendaCubit, AgendaState> {
  AgendaConnection({
    super.key,
  }) : super(
          listener: (context, state) {
            if (context
                    .read<SettingsCubit>()
                    .state
                    .settings
                    .colloscopeEnabled ==
                null) {
              updateColloscopeEnabled(context);
            }
          },
        );

  static void updateColloscopeEnabled(BuildContext context) {
    SettingsState settingsState = context.read<SettingsCubit>().state;
    AgendaState agendaState = context.read<AgendaCubit>().state;
    if (!settingsState.settings.fetchAgendaAuto &&
        settingsState.settings.agendaIds.isNotEmpty) {
      context.read<SettingsCubit>().modify(
              settings: settingsState.settings.copyWith(
            colloscopeEnabled: settingsState.settings.agendaIds
                .any((element) => Res.peipStudentsAgendaIds.contains(element)),
          ));
      context.read<ExamenCubit>().load(
            context.read<TomussCubit>().state.name,
            context.read<TomussCubit>().state.surname,
            context.read<AuthentificationCubit>().state.username,
            context.read<SettingsCubit>().state.settings,
            context.read<AuthentificationCubit>().state.lyon1Cas,
            AppLocalizations.of(context)!,
          );
    } else if (agendaState.status == AgendaStatus.ready &&
        agendaState.agendaIds.isNotEmpty) {
      context.read<SettingsCubit>().modify(
            settings: settingsState.settings.copyWith(
              colloscopeEnabled: agendaState.agendaIds.any(
                  (element) => Res.peipStudentsAgendaIds.contains(element)),
            ),
          );
      context.read<ExamenCubit>().load(
            context.read<TomussCubit>().state.name,
            context.read<TomussCubit>().state.surname,
            context.read<AuthentificationCubit>().state.username,
            context.read<SettingsCubit>().state.settings,
            context.read<AuthentificationCubit>().state.lyon1Cas,
            AppLocalizations.of(context)!,
          );
    }
  }
}
