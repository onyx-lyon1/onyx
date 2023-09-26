import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GridWidget extends StatelessWidget {
  final double heightFactor;
  final double leftHourIndicatorWidth;
  final double columnWidth;

  const GridWidget({
    Key? key,
    required this.heightFactor,
    required this.leftHourIndicatorWidth,
    required this.columnWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(
        primaryColor: Theme.of(context).primaryColor,
        heightFactor: heightFactor,
        dayCount: context.read<AgendaCubit>().state.dayCount,
        leftHourIndicatorWidth: leftHourIndicatorWidth,
        columnWidth: columnWidth,
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final Color primaryColor;
  final double heightFactor;
  final int dayCount;
  final double leftHourIndicatorWidth;
  final double columnWidth;

  GridPainter({
    required this.primaryColor,
    required this.heightFactor,
    required this.dayCount,
    required this.leftHourIndicatorWidth,
    required this.columnWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = primaryColor.withOpacity(1)
      ..strokeWidth = 1.0;
    //draw horizontal lines
    for (var i = 1;
        i < (Res.agendaDayEnd - Res.agendaDayStart).inHours - 1;
        i++) {
      // Duration i = const Duration(hours: 1);
      canvas.drawLine(
        Offset(0, (Res.agendaDayDuration.inHours / heightFactor).h * i),
        Offset(100.w, (Res.agendaDayDuration.inHours / heightFactor).h * i),
        paint,
      );
    }
    //draw vertical lines
    for (var i = 1; i < dayCount; i++) {
      canvas.drawLine(
        Offset((columnWidth * i) + (leftHourIndicatorWidth.w), 0),
        Offset((columnWidth * i) + (leftHourIndicatorWidth.w), 100.h),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
