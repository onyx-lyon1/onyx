import 'package:dartus/tomuss.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'grade_model.g.dart';

@HiveType(typeId: 9)
class GradeModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final double gradeNumerator;
  @HiveField(3)
  final double gradeDenominator;
  @HiveField(4)
  final int rank;
  @HiveField(5)
  final double average;
  @HiveField(6)
  final double mediane;
  @HiveField(7)
  final int groupSize;
  @HiveField(8)
  final bool isValidGrade;
  @HiveField(9)
  final List<GradeModel> children;
  @HiveField(10)
  double? coef;

  GradeModel({
    required this.name,
    required this.author,
    required this.groupSize,
    required this.gradeNumerator,
    required this.gradeDenominator,
    required this.rank,
    required this.average,
    required this.mediane,
    required this.isValidGrade,
    required this.children,
    this.coef,
  });

  GradeModel.fromGrade(Grade grade)
      : name = grade.name,
        author = grade.author,
        groupSize = grade.groupSize,
        gradeNumerator = grade.gradeNumerator,
        gradeDenominator = grade.gradeDenominator,
        rank = grade.rank,
        average = grade.average,
        mediane = grade.mediane,
        isValidGrade = grade.isValidGrade,
        children = grade.children.map((e) => GradeModel.fromGrade(e)).toList(),
        coef = null;

  @override
  String toString() {
    return 'GradeModel{name: $name, author: $author, gradeNumerator: $gradeNumerator, gradeDenominator: $gradeDenominator, rank: $rank, average: $average, mediane: $mediane, groupSize: $groupSize, isValidGrade: $isValidGrade, children: $children, coef: $coef}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradeModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          author == other.author &&
          gradeNumerator == other.gradeNumerator &&
          gradeDenominator == other.gradeDenominator &&
          listEquals(children, other.children);

  @override
  int get hashCode =>
      name.hashCode ^
      author.hashCode ^
      gradeNumerator.hashCode ^
      gradeDenominator.hashCode ^
      children.hashCode;
}
