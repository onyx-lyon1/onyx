import 'package:dartus/tomuss.dart';

class GradeModel {
  late String _name;
  late String _author;

  late double _gradeNumerator;
  late int _gradeDenominator;
  late int _rank;
  late double _average;
  late double _mediane;

  GradeModel(
    this._name,
    this._author,
    this._average,
    this._gradeDenominator,
    this._gradeNumerator,
    this._mediane,
    this._rank,
  );

  GradeModel.fromGrade(Grade g) {
    _name = g.name;
    _author = g.author;
    _gradeNumerator = g.gradeNumerator;
    _gradeDenominator = g.gradeDenominator;
    _rank = g.rank;
    _average = g.average;
    _mediane = g.mediane;
  }

  String get name => _name;
  String get author => _author;
  int get rank => _rank;
  int get gradeDenominator => _gradeDenominator;
  double get average => _average;
  double get gradeNumerator => _gradeNumerator;
  double get mediane => _mediane;
  String get humanGrade => "$_gradeNumerator/$_gradeDenominator";
}
