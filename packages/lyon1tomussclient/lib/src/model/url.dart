import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';

part 'generated/url.mapper.dart';

@MappableClass()
class URL extends TeachingUnitElement with URLMappable {
  late final String value;
  late final bool isModifiable;

  URL.fromJSON(
    int id,
    Map<String, dynamic> json,
    Map<String, dynamic> stats,
    List<dynamic> line,
    Map<String, dynamic> column,
    String user,
  ) : super.fromJson(id, json, stats, line, column, user) {
    var props = line[id];
    bool isModifiable;
    if (json.containsKey("modifiable")) {
      isModifiable = json["modifiable"] != 0;
    } else {
      isModifiable = false;
    }
    if (props is List && props.isNotEmpty) {
      isModifiable = false;
      value = props[0].toString();
    } else if (json.containsKey("empty_is")) {
      isModifiable = false;
      value = json["empty_is"];
    } else {
      value = "";
    }
    this.isModifiable = isModifiable;
  }

  @MappableConstructor()
  URL({
    required super.title,
    required super.author,
    required super.date,
    required super.position,
    this.value = "",
    this.isModifiable = false,
  });

  @override
  bool get isVisible => true;

  @override
  List<Object?> get customProps => [title, author, value, position];
}
