// import 'package:copy_with_extension/copy_with_extension.dart';
// import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';
// import 'package:hive/hive.dart';
//
// part 'generated/stage_code.g.dart';
//
// @CopyWith()
// @HiveType(typeId: 28)
// class StageCode extends TeachingUnitElement {
//   @HiveField(1, defaultValue: "")
//   late final String value;
//
//   StageCode.fromJSON(
//       var id, var json, var stats, var line, var column, String user)
//       : super.fromTomussJson(id, json, stats, line, column, user) {
//     value = line[id][0].toString();
//   }
//
//   StageCode({
//     required super.title,
//     required super.author,
//     required super.date,
//     required super.position,
//     required this.value,
//   });
//
//   @override
//   bool get isVisible => true;
//
//   @override
//   List<Object?> get customProps => [value];
// }
