import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';
import 'package:hive/hive.dart';

part 'generated/url.g.dart';

@CopyWith()
@HiveType(typeId: 31)
class URL extends TeachingUnitElement {
  @HiveField(2, defaultValue: "")
  late final String value;
  @HiveField(3, defaultValue: false)
  late final bool isModifiable;

  URL.fromJSON(var id, Map json, var stats, var line, var column, String user)
      : super.fromJson(id, json, stats, line, column, user) {
    var props = line[id];
    if (props is List && props.isNotEmpty) {
      isModifiable = false;
      value = props[0].toString();
    } else if (json.containsKey("empty_is")) {
      isModifiable = false;
      value = json["empty_is"];
    } else if (json.containsKey("modifiable")) {
      isModifiable = json["modifiable"] != 0;
      value = "";
    } else {
      throw ("Couldn't find url in URL object...");
    }
  }

  URL({
    required super.title,
    required super.author,
    required super.date,
    required super.position,
    required this.value,
  });

  @override
  bool get isVisible => true;

  @override
  List<Object?> get customProps => [title, author, value, position];
}
