import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';

part 'generated/semester.g.dart';

@CopyWith()
@HiveType(typeId: 13)
class Semester extends Equatable {
  @HiveField(0, defaultValue: "")
  final String title;
  @HiveField(1, defaultValue: "")
  final String url;

  Semester(this.title, this.url);

  @override
  List<Object?> get props => [title, url];
  @override
  bool? get stringify => true;
}
