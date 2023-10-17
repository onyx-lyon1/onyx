import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:lyon1tomussclient/src/model/model_export.dart';

part 'generated/semester.g.dart';

@CopyWith()
@HiveType(typeId: 13)
class Semester extends Equatable {
  @HiveField(0, defaultValue: "")
  final String title;
  @HiveField(1, defaultValue: "")
  final String url;

  @HiveField(2, defaultValue: [])
  final List<TeachingUnit> teachingUnits;

  Semester(this.title, this.url, {this.teachingUnits = const []});

  @override
  List<Object?> get props => [title, url, teachingUnits];

  @override
  bool? get stringify => true;
}
