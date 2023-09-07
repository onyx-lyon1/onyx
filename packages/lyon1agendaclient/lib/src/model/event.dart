import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'generated/event.g.dart';

@CopyWith()
@HiveType(typeId: 3)
class Event extends Equatable {
  @HiveField(0)
  late final String location;
  @HiveField(1)
  late final String description;
  @HiveField(2)
  late final String teacher;
  @HiveField(3)
  late final String name;

  @HiveField(4)
  late final DateTime start;
  @HiveField(5)
  late final DateTime end;
  @HiveField(6)
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

  @override
  List<Object?> get props => [
        location,
        description,
        teacher,
        name,
        start,
        end,
        eventLastModified,
        menuCrous,
      ];

  @override
  bool get stringify => true;
}
