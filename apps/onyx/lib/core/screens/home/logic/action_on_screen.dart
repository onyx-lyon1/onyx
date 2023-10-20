import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void actionOnScreen(BuildContext context, int index) {
  int indexLocal = index %
      context
          .read<SettingsCubit>()
          .state
          .settings
          .enabledFunctionalities
          .length;
  if (indexLocal ==
      context
          .read<SettingsCubit>()
          .state
          .settings
          .enabledFunctionalities
          .indexOf(Functionalities.agenda)) {
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
            title: const Text("Attention"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("""
L'agenda est sélectionné automatiquement. Cela peut être inexact,
surtout pour les étudiants de Polytech.
N'hésitez pas à le sélectionner manuellement dans les paramètres."""),
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
                child: const Text("Ok"),
              ),
            ],
          ),
        );
      });
    }
  }
}
