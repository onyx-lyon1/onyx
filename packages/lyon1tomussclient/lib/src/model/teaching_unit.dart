import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';

part 'generated/teaching_unit.g.dart';

@CopyWith()
@HiveType(typeId: 10)
class TeachingUnit extends Equatable {
  @HiveField(0, defaultValue: "")
  final String title;
  @HiveField(1, defaultValue: [])
  final List<Teacher> masters;
  @HiveField(2, defaultValue: [])
  final List<Grade> grades;
  @HiveField(6, defaultValue: [])
  final List<TomussText> textValues;
  @HiveField(7, defaultValue: [])
  final List<Enumeration> enumerations;
  @HiveField(8, defaultValue: [])
  final List<Presence> presences;
  @HiveField(9, defaultValue: [])
  final List<StageCode> stageCodes;
  @HiveField(10, defaultValue: [])
  final List<Upload> uploads;
  @HiveField(11, defaultValue: [])
  final List<URL> urls;
  @HiveField(12, defaultValue: "")
  final String ticket;
  @HiveField(13, defaultValue: "")
  final String ue;

  TeachingUnit(
      this.title,
      this.masters,
      this.grades,
      this.textValues,
      this.enumerations,
      this.presences,
      this.stageCodes,
      this.uploads,
      this.urls,
      this.ticket,
      this.ue);

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
