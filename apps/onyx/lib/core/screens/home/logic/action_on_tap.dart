import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
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
      List<Day> days = agendaState.days(settings);
      int distance = days.length;
      int index = -1;

      for (int i = 0; i < days.length; i++) {
        if ((days[i].date.difference(DateTime.now()).inDays).abs() < distance) {
          distance = (days[i].date.difference(DateTime.now()).inDays).abs();
          index = i;
        }
      }
      context.read<AgendaCubit>().updateDisplayedDate(
            wantedDate: index,
            fromMiniCalendar: false,
            settings: context.read<SettingsCubit>().state.settings,
            fromHorizontalScroll: false,
          );
    }
  }
}
