import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/others/month_to_string.dart';
import 'package:oloid2/others/weekday_to_string.dart';
import 'package:oloid2/states/agenda/agenda_bloc.dart';
import 'package:sizer/sizer.dart';

class MiniCalendar extends StatelessWidget {
  final ScrollController scrollController;
  final void Function(DateTime date) onUpdate;
  final DateTime wantedDate;

  const MiniCalendar(
      {Key? key,
      required this.scrollController,
      required this.onUpdate,
      required this.wantedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Key forwardListKey = const Key("list");
    Widget forwardList = SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        DateTime currentDate = DateTime.now().add(Duration(days: index));
        if (currentDate
            .subtract(const Duration(days: 1))
            .isAfter(context.read<AgendaBloc>().dayModels.last.date)) {
          return null;
        }
        return oneDay(context, currentDate);
      }),
      key: forwardListKey,
    );

    Widget reverseList = SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        DateTime currentDate =
            DateTime.now().subtract(Duration(days: index + 1));
        if (currentDate
            .isBefore(context.read<AgendaBloc>().dayModels.first.date)) {
          return null;
        }
        return oneDay(context, currentDate);
      }),
    );

    return Container(
      height: 10.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
      ),
      child: Scrollable(
        axisDirection: AxisDirection.right,
        controller: scrollController,
        viewportBuilder: (BuildContext context, ViewportOffset offset) {
          return Viewport(
            axisDirection: AxisDirection.right,
            offset: offset,
            center: forwardListKey,
            slivers: [
              reverseList,
              forwardList,
            ],
          );
        },
      ),
    );
  }

  Widget oneDay(BuildContext context, DateTime currentDate) {
    return SizedBox(
      height: 10.h,
      width: 15.w,
      child: Padding(
        padding: EdgeInsets.all(0.8.w),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              color: (wantedDate.day == currentDate.day &&
                      wantedDate.year == currentDate.year)
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => onUpdate(currentDate),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 3.h,
                    child: Text(
                      currentDate.toMonthName(short: true),
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                    child: Text(
                      currentDate.day.toString(),
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                    child: Text(
                      currentDate.toWeekDayName(short: true),
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
