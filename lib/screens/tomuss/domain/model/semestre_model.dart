import 'package:dartus/tomuss.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'semestre_model.g.dart';

@HiveType(typeId: 13)
class SemestreModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;

  SemestreModel({required this.name, required this.url});

  SemestreModel.fromSemester(Semester s) : name = s.name, url = s.url;

  @override
  String toString() {
    return 'SemesterModel{name: $name, url: $url}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemestreModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          url == other.url;

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
