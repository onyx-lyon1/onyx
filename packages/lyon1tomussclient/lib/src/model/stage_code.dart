import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';

part 'generated/stage_code.g.dart';

@CopyWith()
class StageCode extends TeachingUnitElement {
  late final String value;

  StageCode.fromJSON(
      var id, var json, var stats, var line, var column, String user)
      : super.fromJson(id, json, stats, line, column, user) {
    value = line[id][0].toString();
  }

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
