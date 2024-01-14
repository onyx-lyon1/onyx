import 'package:dart_mappable/dart_mappable.dart';
import 'package:hive/hive.dart';

part 'examen_model.mapper.dart';
part 'examen_model.g.dart';

@MappableClass()
@HiveType(typeId: 48)
class ExamenModel with ExamenModelMappable {
  @HiveField(0, defaultValue: '')
  late final String title;
  @HiveField(1, defaultValue: '')
  late final String codeName;
  @HiveField(2)
  late final DateTime date;
  @HiveField(3, defaultValue: Duration(hours: 2))
  late final Duration duration;
  @HiveField(4, defaultValue: '')
  late final String location;
  @HiveField(5, defaultValue: 0)
  late final int place;

  ExamenModel(this.title, this.codeName, this.date, this.duration,
      this.location, this.place);
}
