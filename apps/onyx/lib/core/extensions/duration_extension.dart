import 'package:intl/intl.dart';

extension DateBeautifull on Duration {
  String durationBeautifull() {
    final dateTime = DateTime(0, 0, 0, inHours, inMinutes.remainder(60));
    return DateFormat.Hm().format(dateTime);
  }
}
