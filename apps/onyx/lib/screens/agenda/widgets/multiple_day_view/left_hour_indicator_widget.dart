import 'package:flutter/material.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/res.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LeftHourIndicatorWidget extends StatelessWidget {
  const LeftHourIndicatorWidget({
    super.key,
    required this.heightFactor,
    required this.leftHourIndicatorWidth,
  });

  final double heightFactor;
  final double leftHourIndicatorWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = Res.agendaDayStart;
            i < Res.agendaDayEnd;
            i += const Duration(hours: 1))
          SizedBox(
            height: ((i + const Duration(hours: 1)) < Res.agendaDayEnd)
                ? (Res.agendaDayDuration.inHours / heightFactor).h
                : 0.0,
            width: leftHourIndicatorWidth.w,
            child: Text(
              "${i.inHours.toFixedLengthString(2)}h",
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
