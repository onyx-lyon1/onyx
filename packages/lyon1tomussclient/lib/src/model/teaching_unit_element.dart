import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/parser/dateparser.dart';

abstract class TeachingUnitElement {
  late final String title;
  late final String author;
  late final DateTime? date;
  late final double position;

  @MappableConstructor()
  TeachingUnitElement({
    this.title = "",
    this.author = "",
    this.date,
    this.position = 0,
  });

  TeachingUnitElement.fromJson(
    int id,
    Map<String, dynamic> json,
    Map<String, dynamic> stats,
    List<dynamic> line,
    Map<String, dynamic> column,
    String user,
  ) {
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

  List<Object?> get customProps;
}
