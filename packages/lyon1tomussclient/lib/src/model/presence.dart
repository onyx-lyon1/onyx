import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';
import 'package:lyon1tomussclient/src/parser/condition_parser.dart';
import 'package:lyon1tomussclient/src/parser/dateparser.dart';

part 'presence.mapper.dart';

@MappableEnum()
enum PresenceColor {
  @MappableValue(100)
  green,
  @MappableValue(200)
  red,
  @MappableValue(300)
  unset
}

@MappableClass()
class Presence extends TeachingUnitElement with PresenceMappable {
  late final String value;
  late final String? emptyIs;
  late final PresenceColor color;
  late final DateTime? visibilityDate;
  late final bool? visible;

  Presence.fromJSON(
      var id, var json, var stats, var line, var column, String user)
      : super.fromTomussJson(id, json, stats, line, column, user) {
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

  @MappableConstructor()
  Presence.mappableConstruct({
    super.title = "",
    super.author = "",
    super.date,
    super.position = 0,
    this.value = "",
    this.emptyIs,
    this.color = PresenceColor.unset,
    this.visibilityDate,
    this.visible,
  });
}
