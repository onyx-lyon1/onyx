import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void actionOnTap(
    BuildContext context, int realIndex, ScrollController mainPageController) {
  final AgendaState agendaState = context.read<AgendaCubit>().state;
  final SettingsModel settings = context.read<SettingsCubit>().state.settings;
  if (agendaState.status != AgendaStatus.error) {
    if (realIndex % settings.enabledFunctionalities.length ==
            settings.enabledFunctionalities.indexOf(Functionalities.agenda) &&
        (mainPageController.hasClients
                ? ((mainPageController.offset +
                        ((mainPageController.offset < 0) ? -1 : 1)) ~/
                    100.w) //simple +-1 to avoid bug
                : 0) ==
            realIndex) {
      context.read<AgendaCubit>().goToday(
            fromMiniCalendar: false,
            settings: context.read<SettingsCubit>().state.settings,
            fromHorizontalScroll: false,
          );
    }
  }
}
