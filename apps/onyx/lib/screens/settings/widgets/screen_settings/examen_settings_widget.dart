import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/examen/states/examen_cubit.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExamenSettingsWidget extends StatelessWidget {
  const ExamenSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsModel settings = context.read<SettingsCubit>().state.settings;
    return Column(
      children: [
        TextSwitchWidget(
          text: AppLocalizations.of(context)!.examenAddToAgenda,
          value: settings.examenAddToAgenda,
          onChanged: (value) {
            context
                .read<SettingsCubit>()
                .modify(settings: settings.copyWith(examenAddToAgenda: value));
            context.read<ExamenCubit>().scheduleReload();
          },
        ),
        TextSwitchWidget(
          text: AppLocalizations.of(context)!.enableColloscope,
          value: settings.colloscopeEnabled ?? false,
          onChanged: (value) {
            context
                .read<SettingsCubit>()
                .modify(settings: settings.copyWith(colloscopeEnabled: value));
            context.read<ExamenCubit>().scheduleReload();
          },
        ),
        if (settings.colloscopeEnabled ?? false)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.forceYear,
                softWrap: true,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 12,
                ),
              ),
              DropdownButton(
                value: settings.colloscopeOverrideYearId,
                items: [
                  for (var i = 0; i < 3; i++)
                    DropdownMenuItem(
                        value: i,
                        child: Text(
                            AppLocalizations.of(context)!.forceYearValue(i))),
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
                  AppLocalizations.of(context)!.forceStudentId,
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
                    hintText: AppLocalizations.of(context)!.emptyToDisable,
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
