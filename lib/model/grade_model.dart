import 'package:dartus/tomuss.dart';

class GradeModel {
  late String name;
  late String author;
  late double gradeNumerator;
  late int gradeDenominator;
  late int rank;
  late double average;
  late double mediane;
  late int groupSize;
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
}
