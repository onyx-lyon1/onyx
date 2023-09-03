import 'package:onyx/core/extensions/extensions_export.dart';

extension DateBeautiful on DateTime {
  String dateBeautifull() {
    return "${toWeekDayName(short: false)} ${day.toFixedLengthString(2)}/${month.toFixedLengthString(2)}/${year.toFixedLengthString(4)}";
  }
}
