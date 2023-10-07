import 'package:onyx/core/extensions/extensions_export.dart';

const List<String> weekDays = [
  "Lundi",
  "Mardi",
  "Mercredi",
  "Jeudi",
  "Vendredi",
  "Samedi",
  "Dimanche"
];
const List<String> weekDaysShort = [
  "Lun.",
  "Mar.",
  "Mer.",
  "Jeu.",
  "Ven.",
  "Sam.",
  "Dim."
];

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

  String dateBeautifull() {
    return "${toWeekDayName(short: false)} ${day.toFixedLengthString(2)}/${month.toFixedLengthString(2)}/${year.toFixedLengthString(4)}";
  }

  String toWeekDayName({bool short = false}) =>
      short ? weekDaysShort[weekday - 1] : weekDays[weekday - 1];

  String toMonthName({bool short = false}) {
    return short ? monthNamesShort[month - 1] : monthNames[month - 1];
  }

  int toWeekNumber() {
    return ((difference(DateTime(year, 1, 1)).inDays) / 7).ceil();
  }
}
