import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class MiniCalendarWidget extends StatelessWidget {
  final PageController scrollController;

  const MiniCalendarWidget({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsCubit>().settings;
    final int dayCount = settings.agendaWeekLength;
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: scrollController,
      onPageChanged: (index) {
        context.read<AgendaCubit>().updateDisplayedDate(
            wantedDate: index * dayCount +
                context.read<AgendaCubit>().state.wantedDate % dayCount,
            fromMiniCalendar: true,
            settings: settings,
            fromHorizontalScroll: false);
      },
      itemBuilder: (context, rawIndex) {
        int index = rawIndex * dayCount;
        if (index + dayCount < context.read<AgendaCubit>().state.days.length) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
