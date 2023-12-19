import 'package:lyon1tomussclient/lyon1tomussclient.dart';

import '../model/model_export.dart';

class ParsedPage {
  late Student? _student;
  late List<Semester>? _semesters;
  late List<TeachingUnit>? _teachingunits;
  late bool _isTimedOut;
  late Duration _timeout;

  ParsedPage(this._student, this._semesters, this._teachingunits,
      this._isTimedOut, this._timeout);

  ParsedPage.empty() {
    _student = null;
    _semesters = [];
    _teachingunits = [];
    _isTimedOut = false;
    _timeout = Duration.zero;
  }

  Student? get student => _student;

  List<TeachingUnit>? get teachingunits => _teachingunits;

  List<Semester>? get semesters => _semesters;

  bool get isTimedOut => _isTimedOut;

  Duration get timeout => _timeout;
}
