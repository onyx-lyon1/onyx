import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/agenda/widgets/days_view_widget_res.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MiniCalendarWidget extends StatelessWidget {
  final PageController scrollController;

  const MiniCalendarWidget({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

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
              for (int i = index; i < index + dayCount; i++) oneDay(context, i),
            ],
          );
        }
        return null;
      },
    );
  }

  Widget oneDay(BuildContext context, int currentDateIndex) {
    final SettingsModel settings = context.read<SettingsCubit>().state.settings;
    return BlocBuilder<AgendaCubit, AgendaState>(
      buildWhen: (previous, current) =>
          previous.days(settings)[previous.wantedDate].date.shrink(3) ==
              current.days(settings)[currentDateIndex].date.shrink(3) ||
          current.days(settings)[current.wantedDate].date.shrink(3) ==
              current.days(settings)[currentDateIndex].date.shrink(3),
      builder: (context, state) {
        return SizedBox(
          key: Key(
              state.days(settings)[currentDateIndex].date.shrink(3).toString()),
          height: Res.bottomNavBarHeight,
          width: (100 - DaysViewRes.leftHourIndicatorWidth).w /
              context.read<SettingsCubit>().state.settings.agendaWeekLength,
          child: Padding(
            padding: EdgeInsets.all(0.8.w),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  color: (state.days(settings)[state.wantedDate].date.day ==
                              state.days(settings)[currentDateIndex].date.day &&
                          state.days(settings)[state.wantedDate].date.month ==
                              state.days(settings)[currentDateIndex].date.month)
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    context.read<AgendaCubit>().updateDisplayedDate(
                        wantedDate: currentDateIndex,
                        fromMiniCalendar: true,
                        settings: context.read<SettingsCubit>().state.settings,
                        fromHorizontalScroll: false);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 2.9.h,
                        child: Text(
                          state
                              .days(settings)[currentDateIndex]
                              .date
                              .toMonthName(short: true),
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                        child: Text(
                          state
                              .days(settings)[currentDateIndex]
                              .date
                              .day
                              .toString(),
                          style: TextStyle(fontSize: 17.sp),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                        child: Text(
                          state
                              .days(settings)[currentDateIndex]
                              .date
                              .toWeekDayName(short: true),
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
