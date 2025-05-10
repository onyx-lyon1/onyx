import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/agenda_config/page/agenda_config_page.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgendaUrlParameterWidget extends StatelessWidget {
  const AgendaUrlParameterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextSwitchWidget(
          text: AppLocalizations.of(context).fetchAgendaAuto,
          value: context.read<SettingsCubit>().settings.fetchAgendaAuto,
          onChanged: (bool b) {
            context.read<SettingsCubit>().modify(
                settings: context
                    .read<SettingsCubit>()
                    .settings
                    .copyWith(fetchAgendaAuto: b));
          },
        ),
        AnimatedContainer(
          duration: Res.animationDuration,
          margin: EdgeInsets.only(top: 2.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: (!context.read<SettingsCubit>().settings.fetchAgendaAuto)
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withValues(alpha: 0.3),
          ),
          child: const AgendaSelectionWidget(),
        ),
      ],
    );
  }
}

class AgendaSelectionWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final bool forceClickable;

  const AgendaSelectionWidget({
    this.onTap,
    this.forceClickable = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100),
      color: (forceClickable)
          ? Theme.of(context).colorScheme.primary
          : Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: (!(context.read<SettingsCubit>().settings.fetchAgendaAuto) ||
                forceClickable)
            ? () {
                if (onTap != null) onTap!();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SafeArea(
                      child: AgendaConfigPage(
                        onBack: (List<int> ids) {
                          context.read<SettingsCubit>().modify(
                              settings: context
                                  .read<SettingsCubit>()
                                  .settings
                                  .copyWith(agendaIds: ids));
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                );
              }
            : null,
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Text(
            AppLocalizations.of(context).agendaSelection,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color:
                    (context.read<SettingsCubit>().settings.fetchAgendaAuto &&
                            !forceClickable)
                        ? Theme.of(context).disabledColor
                        : null),
          ),
        ),
      ),
    );
  }
}
