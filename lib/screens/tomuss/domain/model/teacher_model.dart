import 'package:dartus/tomuss.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'generated/teacher_model.g.dart';

@HiveType(typeId: 12)
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

  @override
  String toString() {
    return 'TeacherModel{_name: $_name, _email: $_email}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherModel &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _email == other._email;

  @override
  int get hashCode => _name.hashCode ^ _email.hashCode;
}
