import 'package:dart_mappable/dart_mappable.dart';

part 'generated/semester.mapper.dart';

@MappableClass()
class Semester with SemesterMappable {
  final String title;
  final String url;

  Semester({this.title = "", this.url = ""});
}
