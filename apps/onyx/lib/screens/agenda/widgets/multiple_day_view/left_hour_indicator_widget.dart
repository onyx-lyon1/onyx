import 'package:flutter/material.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/res.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'multiple_day_view_res.dart';

class LeftHourIndicatorWidget extends StatelessWidget {
  const LeftHourIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = Res.agendaDayStart;
            i < Res.agendaDayEnd;
            i += const Duration(hours: 1))
          SizedBox(
            height: ((i + const Duration(hours: 1)) < Res.agendaDayEnd)
                ? (Res.agendaDayDuration.inHours /
                        MultipleDayViewRes.heightFactor)
                    .h
                : 0.0,
            width: MultipleDayViewRes.leftHourIndicatorWidth.w,
            child: Text(
              "${i.inHours.toFixedLengthString(2)}h",
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
