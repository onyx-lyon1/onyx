import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/agenda_config/page/agenda_config_page.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgendaUrlParameterWidget extends StatelessWidget {
  const AgendaUrlParameterWidget({Key? key, required this.sizeUpdate})
      : super(key: key);
  final VoidCallback sizeUpdate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) {
        if (previous.settings.fetchAgendaAuto !=
            current.settings.fetchAgendaAuto) {
          WidgetsBinding.instance.addPostFrameCallback((_) => sizeUpdate());
        }
        return true;
      },
      builder: (context, state) {
        return Column(
          children: [
            TextSwitchWidget(
              text: 'Récupérer automatiquement les ressources de l\'agenda',
              value:
                  context.read<SettingsCubit>().state.settings.fetchAgendaAuto,
              onChanged: (bool b) {
                context.read<SettingsCubit>().modify(
                    settings: context
                        .read<SettingsCubit>()
                        .state
                        .settings
                        .copyWith(fetchAgendaAuto: b));
              },
            ),
            if (!context.read<SettingsCubit>().state.settings.fetchAgendaAuto)
              SizedBox(
                width: 50.w,
                child: const Center(
                  child: AgendaSelectionWidget(),
                ),
              )
            else
              Container(),
          ],
        );
      },
    );
  }
}

class AgendaSelectionWidget extends StatelessWidget {
  final VoidCallback? afterSelect;

  const AgendaSelectionWidget({
    this.afterSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100),
      color: Theme.of(context).primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SafeArea(
                child: AgendaConfigPage(
                  onBack: (index) {
                    context.read<SettingsCubit>().modify(
                        settings: context
                            .read<SettingsCubit>()
                            .state
                            .settings
                            .copyWith(agendaId: index));
                    Navigator.pop(context);
                    if (afterSelect != null) afterSelect!();
                  },
                ),
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(2.w),
          child: Text(
            'Sélectionner l\'agenda',
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
