import 'package:dartus/tomuss.dart';

class TeacherModel {
  late String _name;
  late String _email;

  TeacherModel(this._name, this._email);

  TeacherModel.fromTeacher(Teacher t) {
    _name = t.name;
    _email = t.email;
  }

  String get name => _name;
  String get email => _email;
}
