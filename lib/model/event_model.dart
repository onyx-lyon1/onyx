class EventModel {
  final String location;
  final String description;
  final String teacher;
  final String summary;

  final DateTime start;
  final DateTime end;
  final DateTime eventLastModified;

  EventModel({
    required this.location,
    required this.description,
    required this.teacher,
    required this.summary,
    required this.start,
    required this.end,
    required this.eventLastModified,
  });
}
