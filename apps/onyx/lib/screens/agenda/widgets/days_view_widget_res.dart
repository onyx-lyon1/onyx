import 'package:responsive_sizer/responsive_sizer.dart';

class DaysViewRes {
  static const double heightFactor = 3.0;
  static const double leftHourIndicatorWidth = 10.0;
  static double topDayIndicatorHeight = 5.5;

  static double columnWidth(int dayCount) =>
      (100 - DaysViewRes.leftHourIndicatorWidth).w / dayCount;
}
