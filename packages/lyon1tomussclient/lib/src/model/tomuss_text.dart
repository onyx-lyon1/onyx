import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';

part 'tomuss_text.mapper.dart';

@MappableClass()
class TomussText extends TeachingUnitElement with TomussTextMappable {
  late final String value;
  late final String comment;
  late final bool isValidText;
  late final bool isHidden;
  late final String theId;

  TomussText.fromJSON(
      var id, var json, var stats, var line, var column, String user)
      : super.fromTomussJson(id, json, stats, line, column, user) {
    comment = json['comment'] ?? "";

    value = (line.length > 0 && id < line.length - 1 && line[id].length > 0)
        ? line[id][0].toString()
        : "";
    isValidText = value.isNotEmpty;
    isHidden = (json['hidden'] ?? 0) == 1;
    theId = json['the_id'] ?? "";
  }

  TomussText({
    required super.title,
    required super.author,
    required super.date,
    required super.position,
    required this.value,
    required this.comment,
    required this.isValidText,
    required this.isHidden,
    required this.theId,
  });

  @MappableConstructor()
  TomussText.mappableConstruct({
    super.title = "",
    super.author = "",
    super.date,
    super.position = 0,
    this.value = "",
    this.comment = "",
    this.isValidText = false,
    this.isHidden = false,
    this.theId = "",
  });

  @override
  bool get isVisible => !isHidden && !["0_0", "0_1", "0_2"].contains(theId);
}
