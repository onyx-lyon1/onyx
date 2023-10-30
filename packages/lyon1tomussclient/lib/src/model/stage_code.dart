import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';

part 'stage_code.mapper.dart';

@MappableClass()
class StageCode extends TeachingUnitElement with StageCodeMappable {
  late final String value;

  StageCode.fromJSON(
      var id, var json, var stats, var line, var column, String user)
      : super.fromTomussJson(id, json, stats, line, column, user) {
    value = line[id][0].toString();
  }

  StageCode({
    required super.title,
    required super.author,
    required super.date,
    required super.position,
    required this.value,
  });

  @MappableConstructor()
  StageCode.mappableConstruct({
    super.title = "",
    super.author = "",
    super.date,
    super.position = 0,
    this.value = "",
  });

  @override
  bool get isVisible => true;
}
