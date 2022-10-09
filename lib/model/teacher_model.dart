import 'package:dartus/tomuss.dart';
import 'package:hive_flutter/adapters.dart';


part 'teacher_model.g.dart';

@HiveType(typeId: 7)
class TeacherModel {
  @HiveField(0)
  late String _name;
  @HiveField(1)
  late String _email;

  TeacherModel(this._name, this._email);

  TeacherModel.fromTeacher(Teacher t) {
    _name = t.name;
    _email = t.email;
  }

  String get name => _name;
  String get email => _email;
}
