// ignore_for_file: unnecessary_overrides

import 'package:dartus/tomuss.dart';
import 'package:hive_flutter/adapters.dart';

part 'grade_model.g.dart';

@HiveType(typeId: 4)
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
        isValidGrade = grade.isValidGrade;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradeModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          author == other.author &&
          (gradeNumerator == other.gradeNumerator ||
              (gradeNumerator.isNaN && other.gradeNumerator.isNaN)) &&
          (gradeDenominator == other.gradeDenominator ||
              (gradeDenominator.isNaN && other.gradeDenominator.isNaN)) &&
          isValidGrade == other.isValidGrade;

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() {
    return 'GradeModel{name: $name, author: $author, gradeNumerator: $gradeNumerator, gradeDenominator: $gradeDenominator, rank: $rank, average: $average, mediane: $mediane, groupSize: $groupSize, isValidGrade: $isValidGrade}';
  }
}
