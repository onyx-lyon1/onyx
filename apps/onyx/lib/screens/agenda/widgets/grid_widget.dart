import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'days_view_widget_res.dart';

class GridWidget extends StatelessWidget {
  const GridWidget(
      {Key? key, required this.columnWidth, required this.dayCount})
      : super(key: key);

  final double columnWidth;
  final int dayCount;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(
        dayCount: dayCount,
        columnWidth: columnWidth,
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final int dayCount;
  final double columnWidth;

  GridPainter({
    required this.dayCount,
    required this.columnWidth,
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
        Offset(0,
            (Res.agendaDayDuration.inHours / DaysViewRes.heightFactor).h * i),
        Offset(100.w,
            (Res.agendaDayDuration.inHours / DaysViewRes.heightFactor).h * i),
        paint,
      );
    }
    //draw vertical lines
    canvas.drawLine(
      Offset(DaysViewRes.leftHourIndicatorWidth.w, 0),
      Offset(DaysViewRes.leftHourIndicatorWidth.w, 100.h),
      paint,
    );
    for (var i = 1; i < dayCount; i++) {
      canvas.drawLine(
        Offset((columnWidth * i) + (DaysViewRes.leftHourIndicatorWidth.w), 0),
        Offset(
            (columnWidth * i) + (DaysViewRes.leftHourIndicatorWidth.w), 100.h),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
