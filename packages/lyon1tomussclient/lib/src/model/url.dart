import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';

part 'url.mapper.dart';

@MappableClass()
class URL extends TeachingUnitElement with URLMappable {
  late final String value;

  URL.fromJSON(var id, Map json, var stats, var line, var column, String user)
      : super.fromTomussJson(id, json, stats, line, column, user) {
    var props = line[id];
    if (props is List && props.isNotEmpty) {
      value = props[0].toString();
    } else if (json.containsKey("empty_is")) {
      value = json["empty_is"];
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

  @MappableConstructor()
  URL.mappableConstruct({
    super.title = "",
    super.author = "",
    super.date,
    super.position = 0,
    this.value = "",
  });

  @override
  bool get isVisible => true;
}
