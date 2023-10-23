import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/parser/dateparser.dart';

part 'teaching_unit_element.mapper.dart';

@MappableClass(uniqueId: "TeachingUnitElement", discriminatorKey: "type")
abstract class TeachingUnitElement with TeachingUnitElementMappable {
  @MappableField(key: "title")
  late final String title;
  @MappableField(key: "author")
  late final String author;
  @MappableField(key: "date")
  late final DateTime? date;
  @MappableField(key: "position")
  late final double position;

  @MappableConstructor()
  TeachingUnitElement.mappableConstruct({
    this.title = "",
    this.author = "",
    this.date,
    this.position = 0,
  });

  TeachingUnitElement({
    required this.title,
    required this.author,
    required this.date,
    required this.position,
  });

  TeachingUnitElement.fromTomussJson(
      var id, var json, var stats, var line, var column, String user) {
    // title = json['title'] ?? "";
    author = json['author'] ?? "";
    if (line[id].length > 2) {
      String dateString = line[id][2].toString();
      date = dateString.toDateTime();
    } else {
      date = null;
    }
    position = json['position'].toDouble() ?? 0;
  }

// bool get isVisible;
}
