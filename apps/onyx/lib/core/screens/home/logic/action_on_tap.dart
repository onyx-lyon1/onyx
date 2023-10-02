import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/date_extension.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void actionOnTap(
    BuildContext context, int realIndex, ScrollController mainPageController) {
  if (context.read<AgendaCubit>().state.status != AgendaStatus.error) {
    if (realIndex %
                context
                    .read<SettingsCubit>()
                    .state
                    .settings
                    .enabledFunctionalities
                    .length ==
            context
                .read<SettingsCubit>()
                .state
                .settings
                .enabledFunctionalities
                .indexOf(Functionalities.agenda) &&
        (mainPageController.hasClients
                ? ((mainPageController.offset +
                        ((mainPageController.offset < 0) ? -1 : 1)) ~/
                    100.w) //simple +-1 to avoid bug
                : 0) ==
            realIndex) {
      final AgendaState state = context.read<AgendaCubit>().state;
      context.read<AgendaCubit>().updateDisplayedDate(
            wantedDate: state.realDays
                .indexWhere((element) => element.date
                    .shrink(3)
                    .isAtSameMomentAs(DateTime.now().shrink(3)))
                .clamp(0, state.realDays.length - 1),
            fromMiniCalendar: false,
            settings: context.read<SettingsCubit>().state.settings,
          );
    }
  }
}
