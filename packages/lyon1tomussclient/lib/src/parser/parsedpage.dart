import 'package:lyon1tomussclient/lyon1tomussclient.dart';

class ParsedPage {
  late List<Semester> _semesters;
  late bool _isTimedOut;
  late Duration _timeout;
  late final int _semesterIndex;

  ParsedPage(this._semesters, this._isTimedOut, this._timeout) {
    _semesterIndex =
        _semesters.indexWhere((element) => element.teachingUnits.isNotEmpty);
  }

  ParsedPage.empty() {
    _semesters = [];
    _isTimedOut = false;
    _timeout = Duration.zero;
    _semesterIndex = -1;
  }

  List<Semester> get semesters => _semesters;

  List<TeachingUnit> get teachingunits => (_semesters.length > _semesterIndex)
      ? semesters[_semesterIndex].teachingUnits
      : [];

  bool get isTimedOut => _isTimedOut;

  Duration get timeout => _timeout;
}
