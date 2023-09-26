import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OneDayViewWidget extends StatelessWidget {
  final PageController pageController;

  const OneDayViewWidget({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final AgendaState state = context.read<AgendaCubit>().state;
    return PageView(
      controller: pageController,
      scrollDirection: Axis.vertical,
      key: UniqueKey(),
      // pas le plus propre mais force a rebuild et reinit le controller
      onPageChanged: (index) {
        if (context.read<SettingsCubit>().state.settings.showMiniCalendar &&
            !state.animating) {
          if (state.days.length > index) {
            context.read<AgendaCubit>().updateDisplayedDate(
                date: context.read<AgendaCubit>().state.days[index].date,
                fromPageController: true);
          }
        }
      },
      children: [
        for (var day in context.read<AgendaCubit>().state.days)
          SingleChildScrollView(
            child: Column(children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${day.date.toWeekDayName()} ${day.date.day} ${day.date.toMonthName()}",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyLarge!.color),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                          '${day.events.length} ${(context.read<AgendaCubit>().state.dayCount > 1) ? "évé" : "événement(s)"}'),
                    ]),
              ),
              ...day.events.map(
                (e) => Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 3.w),
                  child: EventWidget(
                    event: e,
                    compact: context.read<AgendaCubit>().state.dayCount > 1,
                  ),
                ),
              ),
            ]),
          ),
      ],
    );
  }
}
