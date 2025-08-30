import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';

part 'generated/tomuss_text.mapper.dart';

@MappableClass()
class TomussText extends TeachingUnitElement with TomussTextMappable {
  late final String value;
  late final String comment;
  late final bool isValidText;
  late final bool isHidden;
  late final String theId;

  TomussText.fromJSON(
    int id,
    Map<String, dynamic> json,
    Map<String, dynamic> stats,
    List<dynamic> line,
    Map<String, dynamic> column,
    String user,
  ) : super.fromJson(id, json, stats, line, column, user) {
    comment = json['comment'] ?? "";

    value = (line.isNotEmpty && id < line.length && line[id].length > 0)
        ? line[id][0].toString()
        : "";
    isValidText = value.isNotEmpty;
    isHidden = (json['hidden'] ?? 0) == 1;
    theId = json['the_id'] ?? "";
  }

  @MappableConstructor()
  TomussText({
    required super.title,
    required super.author,
    required super.date,
    required super.position,
    this.value = "",
    this.comment = "",
    this.isValidText = false,
    this.isHidden = false,
    this.theId = "",
  });

  @override
  bool get isVisible => !isHidden && !["0_0", "0_1", "0_2"].contains(theId);

  @override
  List<Object?> get customProps => [
    value,
    comment,
    isValidText,
    theId,
    isHidden,
  ];
}
