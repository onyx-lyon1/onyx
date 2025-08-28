import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive_ce/hive.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';

part 'generated/tomuss_text.g.dart';

@CopyWith()
@HiveType(typeId: 29)
class TomussText extends TeachingUnitElement {
  @HiveField(1, defaultValue: "")
  late final String value;
  @HiveField(3, defaultValue: "")
  late final String comment;
  @HiveField(4, defaultValue: false)
  late final bool isValidText;
  @HiveField(6, defaultValue: false)
  late final bool isHidden;
  @HiveField(7, defaultValue: "")
  late final String theId;

  TomussText.fromJSON(
      var id, var json, var stats, var line, var column, String user)
      : super.fromJson(id, json, stats, line, column, user) {
    comment = json['comment'] ?? "";

    value = (line.length > 0 && id < line.length && line[id].length > 0)
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

  @override
  bool get isVisible => !isHidden && !["0_0", "0_1", "0_2"].contains(theId);

  @override
  List<Object?> get customProps =>
      [value, comment, isValidText, theId, isHidden];
}
