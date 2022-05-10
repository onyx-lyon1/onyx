import 'package:dartus/tomuss.dart';

class TeachingUnitModel {
  final String _name;
  final List<Teacher> _masters;
  final List<Grade> _grades;
  final List<Text> _textValues;

  final bool isSeen;

  TeachingUnitModel(
    this.isSeen,
    this._name,
    this._masters,
    this._grades,
    this._textValues,
  );

  String get name => _name;
  List<Teacher> get masters => _masters;

  String mastersShort() {
    String masters = "";
    for (Teacher m in _masters) {
      masters += m.name.split(" ")[1] + ', ';
    }
    return masters.length > 2
        ? masters.substring(0, masters.length - 2)
        : masters;
  }

  List<Grade> get grades => _grades;
  Grade latestGrade() {
    // TODO: can do better ?
    return _grades.isNotEmpty ? _grades.first : Grade.fromJSON('', {}, [], []);
  }

  List<Text> get textValues => _textValues;
}
