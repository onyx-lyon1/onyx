import 'package:dart_mappable/dart_mappable.dart';

part 'examens_model.mapper.dart';

@MappableClass()
class ExamensModel with ExamensModelMappable {
  late final String title;
  late final String codeName;
  late final DateTime date;
  late final Duration duration;
  late final String location;
  late final int place;

  ExamensModel(this.title, this.codeName, this.date, this.duration,
      this.location, this.place);
}
