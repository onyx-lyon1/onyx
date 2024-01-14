import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/examen/states/examen_cubit.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class ExamenSettingsWidget extends StatelessWidget {
  const ExamenSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsModel settings = context.read<SettingsCubit>().state.settings;
    return Column(
      children: [
        TextSwitchWidget(
          text: "Ajouter les examens à l'agenda",
          value: settings.examenAddToAgenda,
          onChanged: (value) {
            context
                .read<SettingsCubit>()
                .modify(settings: settings.copyWith(examenAddToAgenda: value));
            context.read<ExamenCubit>().scheduleReload();
          },
        ),
        TextSwitchWidget(
          text: "Activer Colloscope",
          value: settings.colloscopeEnabled ?? false,
          onChanged: (value) {
            context
                .read<SettingsCubit>()
                .modify(settings: settings.copyWith(colloscopeEnabled: value));
            context.read<ExamenCubit>().scheduleReload();
          },
        ),
        if (settings.colloscopeEnabled ?? false)
          TextSwitchWidget(
            text: 'Auto Update Agenda (WIP)',
            value: settings.colloscopeAutoUpdateAgenda,
            onChanged: (bool b) {
              context.read<SettingsCubit>().modify(
                  settings: settings.copyWith(colloscopeAutoUpdateAgenda: b));
            },
          ),
        if (settings.colloscopeEnabled ?? false)
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
                value: settings.colloscopeOverrideYearId,
                items: const [
                  DropdownMenuItem(value: 0, child: Text("Automatique")),
                  DropdownMenuItem(value: 1, child: Text("1ère année")),
                  DropdownMenuItem(value: 2, child: Text("2e année")),
                ],
                onChanged: (int? value) {
                  context.read<SettingsCubit>().modify(
                      settings:
                          settings.copyWith(colloscopeOverrideYearId: value));
                  context.read<ExamenCubit>().scheduleReload();
                },
              ),
            ],
          ),
        if (settings.colloscopeEnabled ?? false)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Text(
                  "Forcer un ID",
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 12,
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: TextFormField(
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    hintText: "(vide pour désactiver)",
                    hintStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                    ),
                    counterText: "",
                    isDense: true,
                  ),
                  maxLength: 3,
                  minLines: 1,
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.center,
                  initialValue: settings.colloscopeOverrideStudentId
                      .toString()
                      .replaceFirst("-1", ""),
                  onChanged: (String? value) {
                    int newId = (value!.isEmpty) ? -1 : int.parse(value);

                    context.read<SettingsCubit>().modify(
                        settings: settings.copyWith(
                            colloscopeOverrideStudentId: newId));
                    context.read<ExamenCubit>().scheduleReload();
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }
}
