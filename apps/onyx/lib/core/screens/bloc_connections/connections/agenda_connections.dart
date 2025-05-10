import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/agenda/states/agenda_cubit.dart';
import 'package:onyx/screens/examen/examen_export.dart';
import 'package:onyx/screens/login/states/authentification_cubit.dart';
import 'package:onyx/screens/settings/domain/model/settings_model.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:onyx/screens/tomuss/states/tomuss_cubit.dart';

class AgendaConnection extends BlocListener<AgendaCubit, AgendaState> {
  AgendaConnection({
    super.key,
  }) : super(
          listener: (context, state) {
            if (context.read<SettingsCubit>().settings.colloscopeEnabled ==
                    null &&
                !context.read<SettingsCubit>().settings.fetchAgendaAuto) {
              updateColloscopeEnabled(context);
            }
          },
        );

  static void updateColloscopeEnabled(BuildContext context) {
    var settings = context.read<SettingsCubit>().settings;
    if (!settings.fetchAgendaAuto && settings.agendaIds.isNotEmpty) {
      settings = settings.copyWith(
        colloscopeEnabled: settings.agendaIds
            .any((element) => Res.peipStudentsAgendaIds.contains(element)),
      );
      context.read<SettingsCubit>().modify(settings: settings);
      context.read<ExamenCubit>().load(
            context.read<TomussCubit>().state.name,
            context.read<TomussCubit>().state.surname,
            context.read<AuthCubit>().state.username,
            settings,
            context.read<AuthCubit>().state.lyon1Cas,
            AppLocalizations.of(context),
          );
    }
  }
}
