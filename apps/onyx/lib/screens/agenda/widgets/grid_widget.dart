import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'days_view_widget_res.dart';

class GridWidget extends StatelessWidget {
  const GridWidget(
      {super.key,
      required this.columnWidth,
      required this.dayCount,
      this.month = false});

  final double columnWidth;
  final int dayCount;
  final bool month;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(
        dayCount: dayCount,
        columnWidth: columnWidth,
        month: month,
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final int dayCount;
  final double columnWidth;
  final bool month;

  GridPainter({
    required this.dayCount,
    required this.columnWidth,
    required this.month,
  });

  @override
  void paint(Canvas canvas, Size size) {
    int dayCountCopy = ((month) ? dayCount ~/ 4 : dayCount);
    dayCountCopy = dayCount ~/ 4;
    var paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;
    //draw horizontal lines
    int lineNumber =
        (month) ? 5 : (Res.agendaDayEnd - Res.agendaDayStart).inHours - 1;
    for (var i = 0; i < lineNumber; i++) {
      if (month) {
        canvas.drawLine(
          Offset(
              0,
              ((100.h - Res.topBarHeight - Res.bottomNavBarHeight) /
                      lineNumber) *
                  i),
          Offset(
              100.w,
              ((100.h - Res.topBarHeight - Res.bottomNavBarHeight) /
                      lineNumber) *
                  i),
          paint,
        );
      } else {
        canvas.drawLine(
          Offset(0,
              (Res.agendaDayDuration.inHours / DaysViewRes.heightFactor).h * i),
          Offset(100.w,
              (Res.agendaDayDuration.inHours / DaysViewRes.heightFactor).h * i),
          paint,
        );
      }
    }
    //draw vertical lines
    for (var i = 0; i < dayCountCopy; i++) {
      canvas.drawLine(
        Offset(
            (columnWidth * i) +
                ((month) ? 0 : DaysViewRes.leftHourIndicatorWidth.w),
            0),
        Offset(
            (columnWidth * i) +
                ((month) ? 0 : DaysViewRes.leftHourIndicatorWidth.w),
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
