import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'generated/kholle.g.dart';

@CopyWith()
class Kholle extends Equatable {
  final DateTime date;
  final String subject;
  final String kholleur;
  final String? message;
  final String? room;

  Kholle(this.date, this.subject, this.kholleur, this.message, this.room);

  @override
  List<Object?> get props => [date, subject, kholleur, message, room];

  @override
  bool? get stringify => true;
}
