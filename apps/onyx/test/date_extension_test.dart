import 'package:test/test.dart';
import 'package:onyx/core/extensions/date_extension.dart';

void main() {
  group('DateExtension', () {
    test('shrink should return the correct DateTime', () {
      final dateTime = DateTime(2022, 10, 15, 12, 30, 45, 500, 123);

      expect(dateTime.shrink(1), DateTime(2022));
      expect(dateTime.shrink(2), DateTime(2022, 10));
      expect(dateTime.shrink(3), DateTime(2022, 10, 15));
      expect(dateTime.shrink(4), DateTime(2022, 10, 15, 12));
      expect(dateTime.shrink(5), DateTime(2022, 10, 15, 12, 30));
      expect(dateTime.shrink(6), DateTime(2022, 10, 15, 12, 30, 45));
      expect(dateTime.shrink(7), DateTime(2022, 10, 15, 12, 30, 45, 500));
      expect(dateTime.shrink(8), DateTime(2022, 10, 15, 12, 30, 45, 500, 123));
      expect(dateTime.shrink(9), dateTime);
    });

    test('isSameDay should return true if two dates are the same day', () {
      final date1 = DateTime(2022, 10, 15, 12, 30);
      final date2 = DateTime(2022, 10, 15, 18, 45);
      final date3 = DateTime(2022, 10, 16, 8, 0);

      expect(date1.isSameDay(date2), isTrue);
      expect(date1.isSameDay(date3), isFalse);
    });

    test('dateBeautifull should return the formatted date string', () {
      final dateTime = DateTime(2022, 10, 15);

      expect(dateTime.dateBeautifull('en_US'), 'Saturday 15/10/2022');
      expect(dateTime.dateBeautifull('fr_FR'), 'Samedi 15/10/2022');
    });

    test('toWeekDayName should return the formatted week day name', () {
      final dateTime = DateTime(2022, 10, 15);

      expect(dateTime.toWeekDayName('en_US'), 'Saturday');
      expect(dateTime.toWeekDayName('en_US', short: true), 'Sat');
      expect(dateTime.toWeekDayName('fr_FR'), 'Samedi');
      expect(dateTime.toWeekDayName('fr_FR', short: true), 'sam.');
    });

    test('toHourMinuteString should return the formatted hour minute string',
        () {
      final dateTime = DateTime(2022, 10, 15, 12, 30);

      expect(dateTime.toHourMinuteString('en_US'), '12:30');
      expect(dateTime.toHourMinuteString('fr_FR'), '12:30');
    });

    test('toMonthName should return the formatted month name', () {
      final dateTime = DateTime(2022, 10, 15);

      expect(dateTime.toMonthName('en_US'), 'October');
      expect(dateTime.toMonthName('en_US', short: true), 'Oct');
      expect(dateTime.toMonthName('fr_FR'), 'octobre');
      expect(dateTime.toMonthName('fr_FR', short: true), 'oct.');
    });

    test('toWeekNumber should return the correct week number', () {
      final dateTime = DateTime(2022, 10, 15);

      expect(dateTime.toWeekNumber(), 41);
    });
  });
}
