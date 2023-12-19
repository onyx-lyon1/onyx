import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              "Forcer l'année",
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
                DropdownMenuItem(
                    value: 0, child: Text("Détection automatique")),
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
              "Forcer un ID",
              softWrap: true,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 12,
              ),
            ),
            SizedBox(
              width: 160,
              child: TextFormField(
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  hintText: "(laisser vide pour désactiver)",
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 12,
                  ),
                  counterText: "",
                ),
                maxLength: 3,
                minLines: 1,
                maxLines: 1,
                initialValue: context
                    .read<SettingsCubit>()
                    .state
                    .settings
                    .colloscopeOverrideStudentId
                    .toString()
                    .replaceFirst("-1", ""),
                onChanged: (String? value) {
                  int newId = (value!.isEmpty) ? -1 : int.parse(value);

                  context.read<SettingsCubit>().modify(
                      settings: context
                          .read<SettingsCubit>()
                          .state
                          .settings
                          .copyWith(colloscopeOverrideStudentId: newId));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
