import 'package:dart_mappable/dart_mappable.dart';

part 'examen_model.mapper.dart';

@MappableClass()
class ExamenModel with ExamenModelMappable {
  late final String? title;
  late final String codeName;
  late final DateTime? date;
  late final Duration? duration;
  late final String? location;
  late final int? place;

  ExamenModel({
    this.title = '',
    this.codeName = '',
    this.date,
    this.duration = const Duration(hours: 2),
    this.location = '',
    this.place = 0,
  });
}
