import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class ColloscopeSettingsWidget extends StatelessWidget {
  const ColloscopeSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextSwitchWidget(
          text: 'Auto Update Agenda (WIP)',
          value: context
              .read<SettingsCubit>()
              .state
              .settings
              .colloscopeAutoUpdateAgenda,
          onChanged: (bool b) {
            context.read<SettingsCubit>().modify(
                settings: context
                    .read<SettingsCubit>()
                    .state
                    .settings
                    .copyWith(colloscopeAutoUpdateAgenda: b));
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Override Year (WIP)",
              softWrap: true,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 12,
              ),
            ),
            DropdownButton(
              value: context
                  .read<SettingsCubit>()
                  .state
                  .settings
                  .colloscopeOverrideYearId,
              items: const [
                DropdownMenuItem(value: 0, child: Text("Automatique (WIP)")),
                DropdownMenuItem(value: 1, child: Text("1ère année")),
                DropdownMenuItem(value: 2, child: Text("2e année")),
              ],
              onChanged: (int? value) {
                context.read<SettingsCubit>().modify(
                    settings: context
                        .read<SettingsCubit>()
                        .state
                        .settings
                        .copyWith(colloscopeOverrideYearId: value));
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Override Student (WIP)",
              softWrap: true,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 12,
              ),
            ),
            DropdownButton(
              value: context
                  .read<SettingsCubit>()
                  .state
                  .settings
                  .colloscopeOverrideStudentId,
              items: const [
                DropdownMenuItem(value: 0, child: Text("0")),
                DropdownMenuItem(value: 351, child: Text("351")),
              ],
              onChanged: (int? value) {
                context.read<SettingsCubit>().modify(
                    settings: context
                        .read<SettingsCubit>()
                        .state
                        .settings
                        .copyWith(colloscopeOverrideStudentId: value));
              },
            ),
          ],
        ),
      ],
    );
  }
}
