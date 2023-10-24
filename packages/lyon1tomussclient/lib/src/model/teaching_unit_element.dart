import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/model/model_export.dart';
import 'package:lyon1tomussclient/src/parser/dateparser.dart';

part 'teaching_unit_element.mapper.dart';

@MappableClass(
    uniqueId: "TeachingUnitElement",
    discriminatorKey: "type",
    includeSubClasses: [
      Enumeration,
      Grade,
      Presence,
      StageCode,
      TomussText,
      Upload,
      URL
    ])
abstract class TeachingUnitElement with TeachingUnitElementMappable {
  late final String title;
  late final String author;
  late final DateTime? date;
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
    title = json['title'] ?? "";
    author = json['author'] ?? "";
    if (line[id].length > 2) {
      String dateString = line[id][2].toString();
      date = dateString.toDateTime();
    } else {
      date = null;
    }
    position = json['position'].toDouble() ?? 0;
  }

  bool get isVisible;
}
