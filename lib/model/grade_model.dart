// ignore_for_file: unnecessary_overrides

import 'package:dartus/tomuss.dart';
import 'package:hive_flutter/adapters.dart';

part 'grade_model.g.dart';

@HiveType(typeId: 4)
class GradeModel {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String author;
  @HiveField(2)
  late double gradeNumerator;
  @HiveField(3)
  late double gradeDenominator;
  @HiveField(4)
  late int rank;
  @HiveField(5)
  late double average;
  @HiveField(6)
  late double mediane;
  @HiveField(7)
  late int groupSize;
  @HiveField(8)
  late bool isValidGrade;

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

  GradeModel.fromGrade(Grade grade) {
    name = grade.name;
    author = grade.author;
    gradeNumerator = grade.gradeNumerator;
    gradeDenominator = grade.gradeDenominator;
    rank = grade.rank;
    average = grade.average;
    mediane = grade.mediane;
    groupSize = grade.groupSize;
    isValidGrade = grade.isValidGrade;
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
          rank == other.rank &&
          average == other.average &&
          mediane == other.mediane &&
          groupSize == other.groupSize &&
          isValidGrade == other.isValidGrade;

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() {
    return 'GradeModel{name: $name, author: $author, gradeNumerator: $gradeNumerator, gradeDenominator: $gradeDenominator, rank: $rank, average: $average, mediane: $mediane, groupSize: $groupSize, isValidGrade: $isValidGrade}';
  }
}
