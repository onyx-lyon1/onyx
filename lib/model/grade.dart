import 'package:dartus/tomuss.dart';

class GradeModel {
  late String _name;
  late String _author;
  late double _gradeNumerator;
  late int _gradeDenominator;
  late int _rank;
  late double _average;
  late double _mediane;
  late bool _isValidGrade;

  final bool isSeen;

  GradeModel(
    this.isSeen,
    this._name,
    this._author,
    this._gradeNumerator,
    this._gradeDenominator,
    this._rank,
    this._average,
    this._mediane,
    this._isValidGrade,
  );

  GradeModel.fromGrade(Grade grade, this.isSeen) {
    _name = grade.name;
    _author = grade.author;
    _gradeNumerator = grade.gradeNumerator;
    _gradeDenominator = grade.gradeDenominator;
    _rank = grade.rank;
    _average = grade.average;
    _mediane = grade.mediane;
    _isValidGrade = grade.isValidGrade;
  }

  String get name => _name;
  String get author => _author;
  int get rank => _rank;
  int get gradeDenominator => _gradeDenominator;
  double get average => _average;
  double get gradeNumerator => _gradeNumerator;
  double get mediane => _mediane;
  bool get isValidGrade => _isValidGrade;
  String get humanGrade => "$_gradeNumerator/$_gradeDenominator";
}
