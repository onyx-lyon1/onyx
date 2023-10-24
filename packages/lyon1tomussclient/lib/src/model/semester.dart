import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/src/model/model_export.dart';

part 'semester.mapper.dart';

@MappableClass()
class Semester with SemesterMappable {
  final String title;
  final String url;
  final List<TeachingUnit> teachingUnits;

  Semester(this.title, this.url, {this.teachingUnits = const []});

  @MappableConstructor()
  Semester.mappableConstruct(
      {this.title = "", this.url = "", this.teachingUnits = const []});
}
