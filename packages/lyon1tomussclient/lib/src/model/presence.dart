import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';
import 'package:lyon1tomussclient/src/parser/condition_parser.dart';
import 'package:lyon1tomussclient/src/parser/dateparser.dart';
import 'package:hive_ce/hive.dart';

part 'generated/presence.g.dart';

@HiveType(typeId: 26)
enum PresenceColor {
  @HiveField(0)
  green,
  @HiveField(1)
  red,
  @HiveField(2)
  unset
}

@CopyWith()
@HiveType(typeId: 27)
class Presence extends TeachingUnitElement {
  @HiveField(1, defaultValue: "")
  late final String value;
  @HiveField(3, defaultValue: "")
  late final String? emptyIs;
  @HiveField(4, defaultValue: PresenceColor.unset)
  late final PresenceColor color;
  @HiveField(5, defaultValue: null)
  late final DateTime? visibilityDate;
  @HiveField(6, defaultValue: null)
  late final bool? visible;

  Presence.fromJSON(
      var id, var json, var stats, var line, var column, String user)
      : super.fromJson(id, json, stats, line, column, user) {
    emptyIs = json['empty_is'];
    if (line[id] == null || (line[id] is List && line[id].isEmpty)) {
      value = "";
    } else {
      value = line[id][0].toString();
    }
    // value = (line[id] ?? "" [0] ?? "").toString();
    String? vDate = json['visibility_date'];
    if (vDate != null) {
      if (vDate.length == 8 && RegExp(r'^[0-9]+$').hasMatch(vDate)) {
        visibilityDate = vDate.toDateTime();
        visible = null;
      } else {
        visible =
            vDate.evaluateCondition(value: value, line: line, column: column);
        visibilityDate = null;
      }
      // exemple de condition:
      // [Grp]<M ou [Grp]\x3EM [Grp]<T ou !=
      // F<M || F>M F<T || !=
    } else {
      visibilityDate = null;
      visible = null;
    }
    if (json['redtext']
            .toString()
            .evaluateCondition(value: value, line: line, column: column) ||
        json['red']
            .toString()
            .evaluateCondition(value: value, line: line, column: column)) {
      color = PresenceColor.red;
    } else if (json['greentext']
            .toString()
            .evaluateCondition(value: value, line: line, column: column) ||
        json['green']
            .toString()
            .evaluateCondition(value: value, line: line, column: column)) {
      color = PresenceColor.green;
    } else {
      color = PresenceColor.unset;
    }
  }

  @override
  bool get isVisible => value != ""; //(visible != null && visible!) ||
  //(visibilityDate != null && visibilityDate!.isBefore(DateTime.now()));

  Presence({
    required super.title,
    required super.author,
    required super.date,
    required super.position,
    required this.value,
    required this.emptyIs,
    required this.color,
    required this.visibilityDate,
    required this.visible,
  });

  @override
  List<Object?> get customProps =>
      [value, emptyIs, color, visibilityDate, visible];
}
