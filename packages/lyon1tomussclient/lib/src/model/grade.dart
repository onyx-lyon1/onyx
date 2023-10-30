import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/model/teaching_unit_element.dart';
import 'package:lyon1tomussclient/src/utils/roundtoprecision.dart';

part 'grade.mapper.dart';

@MappableClass()
class Grade extends TeachingUnitElement with GradeMappable {
  late final double numerator;
  late final double denominator;
  late final int rank;
  late final double average;
  late final double mediane;
  late final int groupeSize;
  late final bool isValid;
  late final double coef;

  // ignore: preferfinalfields
  late final List<Grade> children;

  Grade.fromJSON(var id, var json, var stats, var line, var column, String user)
      : super.fromTomussJson(id, json, stats, line, column, user) {
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

  @MappableConstructor()
  Grade.mappableConstruct(
      {super.title = "",
      super.author = "",
      super.date,
      super.position = 0,
      this.numerator = 0.0,
      this.denominator = 20.0,
      this.rank = -1,
      this.average = 10.0,
      this.mediane = 10.0,
      this.isValid = false,
      this.groupeSize = -1,
      this.children = const [],
      this.coef = 1.0});

  void addChild(Grade child) {
    children.add(child);
  }

  void removeChild(Grade child) {
    children.remove(child);
  }

  @override
  bool get isVisible => true;
}
