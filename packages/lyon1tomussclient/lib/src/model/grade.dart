import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';
import 'package:lyon1tomussclient/src/utils/roundtoprecision.dart';
import 'package:hive/hive.dart';

part 'generated/grade.g.dart';

@CopyWith()
@HiveType(typeId: 9)
class Grade extends TeachingUnitElement {
  @HiveField(2, defaultValue: 0.0)
  late final double numerator;
  @HiveField(3, defaultValue: 20.0)
  late final double denominator;
  @HiveField(4, defaultValue: -1)
  late final int rank;
  @HiveField(5, defaultValue: 10.0)
  late final double average;
  @HiveField(6, defaultValue: 10.0)
  late final double mediane;
  @HiveField(7, defaultValue: -1)
  late final int groupeSize;
  @HiveField(8, defaultValue: false)
  late final bool isValid;
  @HiveField(10, defaultValue: 1.0)
  late final double coef;

  // ignore: preferfinalfields
  @HiveField(9, defaultValue: [])
  late final List<Grade> children;

  Grade.fromJSON(var id, var json, var stats, var line, var column, String user)
      : super.fromJson(id, json, stats, line, column, user) {
    rank = stats[json['the_id']]['rank'] ?? -1;
    groupeSize = stats[json['the_id']]['nr'] ?? -1;
    isValid = (rank != -1);
    if (!isValid) {
      return;
    }
    average = Round.round(stats[json['the_id']]['average']);
    mediane = Round.round(stats[json['the_id']]['mediane']);

    numerator = (line.length > 0 && id < line.length && line[id].length > 0)
        ? Round.round(double.tryParse(line[id][0].toString()))
        : double.nan;

    denominator = double.tryParse(
            (json['minmax'] ?? "").split(";").last.replaceAll("]", "") ??
                "20") ??
        20; // "minmax": "[0;22]",

    coef = 1.0;
    children = [];
  }

  Grade({
    required super.title,
    required super.author,
    required super.date,
    required super.position,
    required this.numerator,
    required this.denominator,
    required this.rank,
    required this.average,
    required this.mediane,
    required this.isValid,
    required this.groupeSize,
    required this.children,
    required this.coef,
  });

  void addChild(Grade child) {
    children.add(child);
  }

  void removeChild(Grade child) {
    children.remove(child);
  }

  @override
  bool get isVisible => true;

  @override
  List<Object?> get customProps => [
        numerator,
        denominator,
        rank,
        average,
        mediane,
        isValid,
        groupeSize,
        children
      ];
}
