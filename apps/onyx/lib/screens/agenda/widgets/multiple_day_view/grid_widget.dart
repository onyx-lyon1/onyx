import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'multiple_day_view_res.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(
        dayCount: context.read<AgendaCubit>().state.dayCount,
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final int dayCount;

  GridPainter({
    required this.dayCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;
    //draw horizontal lines
    for (var i = 0;
        i < (Res.agendaDayEnd - Res.agendaDayStart).inHours - 1;
        i++) {
      // Duration i = const Duration(hours: 1);
      canvas.drawLine(
        Offset(
            0,
            (Res.agendaDayDuration.inHours / MultipleDayViewRes.heightFactor)
                    .h *
                i),
        Offset(
            100.w,
            (Res.agendaDayDuration.inHours / MultipleDayViewRes.heightFactor)
                    .h *
                i),
        paint,
      );
    }
    //draw vertical lines
    canvas.drawLine(
      Offset(MultipleDayViewRes.leftHourIndicatorWidth.w, 0),
      Offset(MultipleDayViewRes.leftHourIndicatorWidth.w, 100.h),
      paint,
    );
    for (var i = 1; i < dayCount; i++) {
      canvas.drawLine(
        Offset(
            (MultipleDayViewRes.columnWidth * i) +
                (MultipleDayViewRes.leftHourIndicatorWidth.w),
            0),
        Offset(
            (MultipleDayViewRes.columnWidth * i) +
                (MultipleDayViewRes.leftHourIndicatorWidth.w),
            100.h),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
