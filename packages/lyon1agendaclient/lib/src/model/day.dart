import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';

part 'generated/day.g.dart';

@CopyWith()
@HiveType(typeId: 1)
class Day extends Equatable {
  @HiveField(0)
  final List<Event> events;
  @HiveField(1)
  final DateTime date;

  Day(this.date, this.events);

  Event firstEventForDay(final DateTime dt) {
    return events.firstWhere(
        (event) => dt.isAfter(event.start) && dt.isBefore(event.end));
  }

  List<Event> allEventsForDay(final DateTime dt) {
    return events
        .where((event) => dt.isAfter(event.start) && dt.isBefore(event.end))
        .toList();
  }

  List<Event> searchEvents(final String keyword) {
    final RegExp r = RegExp(keyword, multiLine: true, caseSensitive: false);

    return events
        .where((event) =>
            event.location.contains(r) ||
            event.teacher.contains(r) ||
            event.name.contains(r) ||
            event.description.contains(r))
        .toList();
  }

  @override
  List<Object?> get props => [events, date];

  @override
  bool get stringify => true;
}
