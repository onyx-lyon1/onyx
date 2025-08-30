import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';

part 'generated/teaching_unit.mapper.dart';

@MappableClass()
class TeachingUnit with TeachingUnitMappable {
  final String title;
  final List<Teacher> masters;
  final List<Grade> grades;
  final List<TomussText> textValues;
  final List<Enumeration> enumerations;
  final List<Presence> presences;
  final List<StageCode> stageCodes;
  final List<Upload> uploads;
  final List<URL> urls;
  final String ticket;
  final String ue;

  TeachingUnit({
    this.title = "",
    this.masters = const [],
    this.grades = const [],
    this.textValues = const [],
    this.enumerations = const [],
    this.presences = const [],
    this.stageCodes = const [],
    this.uploads = const [],
    this.urls = const [],
    this.ticket = "",
    this.ue = "",
  });

  List<TeachingUnitElement> get children => [
    ...grades,
    ...textValues,
    ...enumerations,
    ...presences,
    ...stageCodes,
    ...uploads,
    ...urls,
  ];

  List<TeachingUnitElement> get visibleChildren =>
      children.where((element) => element.isVisible).toList();
}
