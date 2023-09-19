import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OneDayView extends StatelessWidget {
  final bool animating;
  final PageController pageController;

  const OneDayView({
    super.key,
    required this.animating,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      scrollDirection: Axis.vertical,
      key: UniqueKey(),
      // pas le plus propre mais force a rebuild et reinit le controller
      onPageChanged: (index) {
        if (context.read<SettingsCubit>().state.settings.showMiniCalendar &&
            !animating) {
          if (context.read<AgendaCubit>().state.days.length > index) {
            context.read<AgendaCubit>().updateDisplayedDate(
                date: context.read<AgendaCubit>().state.days[index].date,
                fromPageController: true);
          }
        }
      },
      children: [
        for (int i = 0; i < context.read<AgendaCubit>().state.days.length; i++)
          SingleChildScrollView(
            child: SizedBox(
              width: 100.w / context.read<AgendaCubit>().state.dayCount,
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
                          "coucou",
                          // "${context.read<AgendaCubit>().state.days[i + j].date.toWeekDayName()} ${context.read<AgendaCubit>().state.days[i + j].date.day} ${context.read<AgendaCubit>().state.days[i + j].date.toMonthName()}",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                            '${context.read<AgendaCubit>().state.days[i].events.length} ${(context.read<AgendaCubit>().state.dayCount > 1) ? "évé" : "événement(s)"}'),
                      ]),
                ),
                ...context.read<AgendaCubit>().state.days[i].events.map(
                      (e) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.8.h, horizontal: 3.w),
                        child: EventWidget(
                          event: e,
                          compact:
                              context.read<AgendaCubit>().state.dayCount > 1,
                        ),
                      ),
                    ),
              ]),
            ),
          ),
      ],
    );
  }
}
