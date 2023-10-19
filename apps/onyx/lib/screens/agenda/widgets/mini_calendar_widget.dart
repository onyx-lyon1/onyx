import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/agenda/widgets/days_view_widget_res.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MiniCalendarWidget extends StatelessWidget {
  final PageController scrollController;

  const MiniCalendarWidget({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final int dayCount =
        context.read<SettingsCubit>().state.settings.agendaWeekLength;
    final SettingsModel settings = context.read<SettingsCubit>().state.settings;
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: scrollController,
      onPageChanged: (index) {
        context.read<AgendaCubit>().updateDisplayedDate(
            wantedDate: index * dayCount +
                context.read<AgendaCubit>().state.wantedDate % dayCount,
            fromMiniCalendar: true,
            settings: context.read<SettingsCubit>().state.settings,
            fromHorizontalScroll: false);
      },
      itemBuilder: (context, rawIndex) {
        int index = rawIndex * dayCount;
        if (index + dayCount <
            context.read<AgendaCubit>().state.days(settings).length) {
          return Row(
            children: [
              SizedBox(
                width: DaysViewRes.leftHourIndicatorWidth.w,
                child: Center(
                  child: Text(
                    "S: ${context.read<AgendaCubit>().state.days(settings)[index].date.toWeekNumber()}",
                  ),
                ),
              ),
              for (int i = index; i < index + dayCount; i++)
                MiniCalendarOneDayWidget(context: context, currentDateIndex: i),
            ],
          );
        }
        return null;
      },
    );
  }
}
