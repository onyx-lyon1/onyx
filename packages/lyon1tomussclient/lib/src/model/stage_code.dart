import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';

part 'generated/stage_code.mapper.dart';

@MappableClass()
class StageCode extends TeachingUnitElement with StageCodeMappable {
  late final String value;

  StageCode.fromJSON(
    int id,
    Map<String, dynamic> json,
    Map<String, dynamic> stats,
    List<dynamic> line,
    Map<String, dynamic> column,
    String user,
  ) : super.fromJson(id, json, stats, line, column, user) {
    value = line[id][0].toString();
  }

  @MappableConstructor()
  StageCode({
    required super.title,
    required super.author,
    required super.date,
    required super.position,
    this.value = "",
  });

  @override
  bool get isVisible => true;

  @override
  List<Object?> get customProps => [value];
}
