import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/core/extensions/extensions_export.dart';
import 'package:oloid2/screens/agenda/agenda_export.dart';
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
    Key forwardListKey = const Key("list");
    Widget forwardList = SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        DateTime currentDate = DateTime.now().add(Duration(days: index));
        if (context.read<AgendaCubit>().state.dayModels.isNotEmpty &&
            currentDate.subtract(const Duration(days: 1)).isAfter(
                context.read<AgendaCubit>().state.dayModels.last.date)) {
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
        if (context.read<AgendaCubit>().state.dayModels.isNotEmpty &&
            currentDate.isBefore(
                context.read<AgendaCubit>().state.dayModels.first.date)) {
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
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
      ),
    );
  }

  Widget oneDay(BuildContext context, DateTime currentDate) {
    return BlocBuilder<AgendaCubit, AgendaState>(
      buildWhen: (previous, current) =>
          previous.wantedDate != current.wantedDate,
      builder: (context, state) {
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
