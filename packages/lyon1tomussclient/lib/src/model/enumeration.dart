import 'package:lyon1tomussclient/src/constant/constants.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';
import 'package:hive/hive.dart';
import 'package:requests_plus/requests_plus.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'generated/enumeration.g.dart';

@CopyWith()
@HiveType(typeId: 25)
class Enumeration extends TeachingUnitElement {
  @HiveField(1, defaultValue: null)
  late final String? value;
  @HiveField(2, defaultValue: [])
  late final List<String> values;
  @HiveField(4, defaultValue: "")
  late final String comment;

  @HiveField(6, defaultValue: "")
  late final String theId;

  @HiveField(7, defaultValue: "")
  late final String lineId;
  @HiveField(8, defaultValue: "")
  late final String ue;
  @HiveField(9, defaultValue: "")
  late final String semester;
  @HiveField(10, defaultValue: "")
  late final String year;
  @HiveField(12, defaultValue: true)
  late final bool modifiable;

  Enumeration.fromJSON(
      var id, var json, var stats, var line, var column, String user)
      : super.fromJson(id, json, stats, line, column, user) {
    comment = json['comment'] ?? "";
    if (json["type"] == "Bool") {
      values = ['OUI', 'NON'];
    } else {
      List<String> tmpValues = [];
      //if the elements are a list do something else do something else
      for (var i in stats[json['the_id']]['enumeration'] ?? []) {
        if (i is List && i.length == 2) {
          String secondElement = "";
          if (i[1] is int) {
            secondElement = "(${i[1]} disponibles)";
          } else {
            secondElement = "(${i[1]})";
          }
          tmpValues.add("${i[0]} $secondElement");
        } else {
          tmpValues.add(i.toString());
        }
      }
      values = List<String>.from(tmpValues);
    }

    if (line[id] is List && line[id].isNotEmpty) {
      value = line[id][0];
    } else if (json.keys.contains("empty_is")) {
      value = json["empty_is"];
    } else {
      if (json["type"] == "Bool") {
        value = json["empty_is"];
      } else {
        value = null;
      }
    }
    modifiable = json.keys.contains("modifiable") &&
        json["modifiable"] == 2 &&
        ((line[id].length > 1 && line[id][1] == user) || line[id].length <= 1);
    theId = json['the_id'] ?? "";
    lineId = column['line_id'] ?? "";
    ue = column['ue'] ?? "";
    semester = column['semester'] ?? "";
    year = (column['year'] ?? "").toString();
  }

  Enumeration(
      {required super.title,
      required super.author,
      required super.date,
      required super.position,
      required this.value,
      required this.values,
      required this.comment,
      required this.theId,
      required this.lineId,
      required this.ue,
      required this.semester,
      required this.year,
      required this.modifiable});

  Future<Enumeration> updateValue(String value, String ticket) async {
    try {
      var response = await RequestsPlus.post(
        "${Constants.tomuss}/POST",
        body: {
          'content':
              "/$year/$semester/$ue/cell/$theId/$lineId/$value?%E2%9C%80_________________________________________________________________$ticket"
        },
        bodyEncoding: RequestBodyEncoding.FormData,
      );
      if (response.statusCode != 200 || response.body != "OK!") {
        throw Exception("Error while updating value");
      }
    } catch (e) {
      rethrow;
    }
    return copyWith(value: value);
  }

  @override
  bool get isVisible => true;

  @override
  List<Object?> get customProps => [values, comment, modifiable, value];
}
