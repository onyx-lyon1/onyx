import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  DateTime shrink(int precision) {
    switch (precision) {
      case 1:
        return DateTime(year);
      case 2:
        return DateTime(year, month);
      case 3:
        return DateTime(year, month, day);
      case 4:
        return DateTime(year, month, day, hour);
      case 5:
        return DateTime(year, month, day, hour, minute);
      case 6:
        return DateTime(year, month, day, hour, minute, second);
      case 7:
        return DateTime(year, month, day, hour, minute, second, millisecond);
      case 8:
        return DateTime(
            year, month, day, hour, minute, second, millisecond, microsecond);
      default:
        return this;
    }
  }

  bool isSameDay(DateTime b) {
    return shrink(3).isAtSameMomentAs(b.shrink(3));
  }

  String dateBeautifull(String locale) {
    return DateFormat('EEEE dd/MM/yyyy', locale).format(this);
  }

  String toWeekDayName(String locale, {bool short = false}) => short
      ? DateFormat('E', locale).format(this)
      : DateFormat('EEEE', locale).format(this);

  String toHourMinuteString(String locale) {
    return DateFormat('HH:mm', locale).format(this);
  }

  String toMonthName(String locale, {bool short = false}) {
    return short
        ? DateFormat('MMM', locale).format(this)
        : DateFormat('MMMM', locale).format(this);
  }

  int toWeekNumber() {
    return ((difference(DateTime(year, 1, 1)).inDays) / 7).ceil();
  }
}
