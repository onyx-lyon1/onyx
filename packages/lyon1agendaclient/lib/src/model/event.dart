import 'package:dart_mappable/dart_mappable.dart';

part 'event.mapper.dart';

@MappableClass()
class Event with EventMappable {
  late final String location;
  late final String description;
  late final String teacher;
  late final String name;

  late final DateTime start;
  late final DateTime end;
  late final DateTime eventLastModified;

  final dynamic menuCrous;

  Event({
    required this.location,
    required this.description,
    required this.teacher,
    required this.name,
    required this.start,
    required this.end,
    required this.eventLastModified,
    this.menuCrous,
  });

  Event.fromJSON(final dynamic eventJSON) : menuCrous = null {
    location = eventJSON['location'] ?? "";
    description = (eventJSON['description'] ?? "")
        .toString()
        .replaceFirst(RegExp("\\(Exported.*", multiLine: true), "")
        .trim();
    name = eventJSON['summary'] ?? "";

    List<String> descriptionSplited = description.split("\\n");
    teacher = (descriptionSplited.length - 2 >= 0)
        ? ((descriptionSplited[descriptionSplited.length - 2]
                    .split(" ")
                    .length >=
                2)
            ? descriptionSplited[descriptionSplited.length - 2]
            : "")
        : "";
    start = DateTime.parse(eventJSON['dtstart']['dt']).toLocal();
    end = DateTime.parse(eventJSON['dtend']['dt']).toLocal();
    eventLastModified =
        DateTime.parse(eventJSON['lastModified']['dt']).toLocal();
  }
}
