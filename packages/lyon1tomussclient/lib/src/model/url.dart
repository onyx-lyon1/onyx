import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';
import 'package:hive/hive.dart';

part 'generated/url.g.dart';

@CopyWith()
@HiveType(typeId: 31)
class URL extends TeachingUnitElement {
  @HiveField(2, defaultValue: "")
  late final String value;

  URL.fromJSON(var id, var json, var stats, var line, var column, String user)
      : super.fromJson(id, json, stats, line, column, user) {
    value = line[id][0].toString();
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
