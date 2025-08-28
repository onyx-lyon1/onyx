import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'generated/event.g.dart';

@CopyWith()
class Event extends Equatable {
  late final String location;
  late final String description;
  late final String teacher;
  late final String name;

  late final DateTime start;
  late final DateTime end;

  final dynamic menuCrous;

  Event({
    required this.location,
    required this.description,
    required this.teacher,
    required this.name,
    required this.start,
    required this.end,
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
  }

  @override
  List<Object?> get props => [
        location,
        description,
        teacher,
        name,
        start,
        end,
        menuCrous,
      ];

  @override
  bool get stringify => true;
}
