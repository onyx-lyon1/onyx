import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'generated/semester.g.dart';

@CopyWith()
class Semester extends Equatable {
  final String title;
  final String url;

  Semester({
    this.title = "",
    this.url = "",
  });

  @override
  List<Object?> get props => [title, url];

  @override
  bool? get stringify => true;
}
