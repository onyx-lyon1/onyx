import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/agenda/widgets/days_view_widget_res.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MiniCalendarWidget extends StatelessWidget {
  final PageController scrollController;

  const MiniCalendarWidget({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final int dayCount = 5;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: scrollController,
      onPageChanged: (index) {
        context.read<AgendaCubit>().updateDisplayedDate(
            wantedDate: index * dayCount, fromMiniCalendar: true);
      },
      itemBuilder: (context, rawIndex) {
        int index = rawIndex * dayCount; //TODO adapt to week length
        if (index + dayCount < context.read<AgendaCubit>().state.days.length) {
          return Row(
            children: [
              GestureDetector(
                onTap: () => () {
                  print("taaaaap");
                },
                child: SizedBox(
                  width: DaysViewRes.leftHourIndicatorWidth.w,
                  child: Center(
                    child: Text(
                      "S: ${context.read<AgendaCubit>().state.days[index].date.toWeekNumber()}",
                    ),
                  ),
                ),
              ),
              for (int i = index; i < index + dayCount; i++)
                GestureDetector(
                    onTap: () => () {
                          print("taaaaap");
                        },
                    child: oneDay(context, i)),
            ],
          );
        }
        return null;
      },
    );
  }

  Widget oneDay(BuildContext context, int currentDateIndex) {
    return BlocBuilder<AgendaCubit, AgendaState>(
      buildWhen: (previous, current) =>
          previous.days[previous.wantedDate].date.shrink(3) ==
              current.days[currentDateIndex].date.shrink(3) ||
          current.days[current.wantedDate].date.shrink(3) ==
              current.days[currentDateIndex].date.shrink(3),
      builder: (context, state) {
        return SizedBox(
          key: Key(state.days[currentDateIndex].date.shrink(3).toString()),
          height: Res.bottomNavBarHeight,
          width: (100 - DaysViewRes.leftHourIndicatorWidth).w / dayCount,
          child: Padding(
            padding: EdgeInsets.all(0.8.w),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  color: (state.days[state.wantedDate].date.day ==
                              state.days[currentDateIndex].date.day &&
                          state.days[state.wantedDate].date.month ==
                              state.days[currentDateIndex].date.month)
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => () {
                    print("!!!!!!!!!!!!!");
                    print("update to $currentDateIndex");
                    context.read<AgendaCubit>().updateDisplayedDate(
                        wantedDate: currentDateIndex, fromMiniCalendar: true);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 2.9.h,
                        child: Text(
                          state.days[currentDateIndex].date
                              .toMonthName(short: true),
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                        child: Text(
                          state.days[currentDateIndex].date.day.toString(),
                          style: TextStyle(fontSize: 17.sp),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                        child: Text(
                          state.days[currentDateIndex].date
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
