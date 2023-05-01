import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:sizer/sizer.dart';

class MiniCalendarWidget extends StatelessWidget {
  final ScrollController scrollController;
  final void Function(DateTime date) onUpdate;

  const MiniCalendarWidget({
    Key? key,
    required this.scrollController,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfiniteScrollLoopWidget(
      key: const Key('MiniCalendarWidget'),
      axisDirection: AxisDirection.right,
      scrollController: scrollController,
      builder: (context, index) {
        if (context.read<AgendaCubit>().state.days.isEmpty) return null;
        DateTime currentDate = DateTime.now().add(Duration(days: index));
        if (currentDate
                .isBefore(context.read<AgendaCubit>().state.days.first.date) ||
            currentDate
                .isAfter(context.read<AgendaCubit>().state.days.last.date)) {
          return null;
        }
        return oneDay(context, currentDate);
      },
    );
  }

  Widget oneDay(BuildContext context, DateTime currentDate) {
    return BlocBuilder<AgendaCubit, AgendaState>(
      buildWhen: (previous, current) =>
          previous.wantedDate.shrink(3) == currentDate.shrink(3) ||
          current.wantedDate.shrink(3) == currentDate.shrink(3),
      builder: (context, state) {
        return SizedBox(
          key: Key(currentDate.shrink(3).toString()),
          height: Res.bottomNavBarHeight,
          width: 15.w,
          child: Padding(
            padding: EdgeInsets.all(0.8.w),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  color: (context.read<AgendaCubit>().state.wantedDate.day ==
                              currentDate.day &&
                          context.read<AgendaCubit>().state.wantedDate.month ==
                              currentDate.month)
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
                        height: 2.9.h,
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
      },
    );
  }
}
