import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/examen/states/examen_cubit.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void actionOnScreen(BuildContext context, int index) {
  final agendaIndex = context
      .read<SettingsCubit>()
      .state
      .settings
      .enabledFunctionalities
      .indexOf(Functionalities.agenda);

  final colloscopeIndex = context
      .read<SettingsCubit>()
      .state
      .settings
      .enabledFunctionalities
      .indexOf(Functionalities.examen);

  if (index == colloscopeIndex) {
    if (context.read<ExamenCubit>().state.reloadScheduled) {
      context.read<ExamenCubit>().resetCubit();
    }
  }

  if (index == agendaIndex) {
    if (!context.read<SettingsCubit>().state.settings.shownAgendaPopup) {
      context.read<SettingsCubit>().modify(
          settings: context
              .read<SettingsCubit>()
              .state
              .settings
              .copyWith(shownAgendaPopup: true));
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context).warning),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context).warningSelectShouldAgenda),
                SizedBox(
                  height: 2.h,
                ),
                AgendaSelectionWidget(
                  forceClickable: true,
                  onTap: () {
                    Navigator.of(context).pop();
                    context.read<SettingsCubit>().modify(
                        settings: context
                            .read<SettingsCubit>()
                            .state
                            .settings
                            .copyWith(
                                fetchAgendaAuto:
                                    false)); //this automaticallty reload agenda from bloclistener in home page
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context).ok),
              ),
            ],
          ),
        );
      });
    }
  }
}
