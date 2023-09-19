import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/int_to_sized_string.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MultipleDayView extends StatelessWidget {
  final bool animating;
  final PageController pageController;

  const MultipleDayView({
    Key? key,
    required this.animating,
    required this.pageController,
  }) : super(key: key);

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
            child: Row(
              children: [
                Column(
                  children: [
                    for (var i = const Duration(hours: 6);
                        i < const Duration(hours: 22);
                        i += const Duration(hours: 1))
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          "${i.inHours.toFixedLengthString(2)}h",
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  width: 100.w / context.read<AgendaCubit>().state.dayCount,
                  child: Column(children: [
                    ...context.read<AgendaCubit>().state.days[i].events.map(
                          (e) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.8.h, horizontal: 3.w),
                            child: EventWidget(
                              event: e,
                              compact: true,
                            ),
                          ),
                        ),
                  ]),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
