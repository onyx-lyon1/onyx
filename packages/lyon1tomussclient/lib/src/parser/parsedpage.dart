import 'package:lyon1tomussclient/lyon1tomussclient.dart';

class ParsedPage {
  late List<Semester>? _semesters;
  late List<TeachingUnit>? _teachingunits;
  late bool _isTimedOut;
  late Duration _timeout;
  ParsedPage(
      this._semesters, this._teachingunits, this._isTimedOut, this._timeout);
  ParsedPage.empty() {
    _semesters = [];
    _teachingunits = [];
    _isTimedOut = false;
    _timeout = Duration.zero;
  }

  List<TeachingUnit>? get teachingunits => _teachingunits;
  List<Semester>? get semesters => _semesters;
  bool get isTimedOut => _isTimedOut;
  Duration get timeout => _timeout;
}
