import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/date_extension.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'multiple_day_view_res.dart';

class TopDayIndicator extends StatelessWidget {
  const TopDayIndicator({Key? key, required this.i}) : super(key: key);
  final int i;

  @override
  Widget build(BuildContext context) {
    AgendaState agendaState = context.read<AgendaCubit>().state;
    return Row(children: [
      SizedBox(
          width: MultipleDayViewRes.leftHourIndicatorWidth.w,
          child: Text("S: ${agendaState.days[i].date.toWeekNumber()}")),
      for (int j = 0; j < agendaState.dayCount; j++)
        SizedBox(
          width: MultipleDayViewRes.columnWidth,
          child: Text(
            "${agendaState.days[i + j].date.toWeekDayName(short: true)}\n${agendaState.days[i + j].date.day}",
            textAlign: TextAlign.center,
          ),
        ),
    ]);
  }
}
