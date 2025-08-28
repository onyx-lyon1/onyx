import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';

part 'generated/teaching_unit.g.dart';

@CopyWith()
class TeachingUnit extends Equatable {
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

  @override
  List<Object?> get props => [
        title,
        masters,
        grades,
        textValues,
        enumerations,
        presences,
        stageCodes,
        uploads,
        urls,
        ticket,
        ue
      ];

  @override
  bool? get stringify => true;

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
