import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'generated/kholle.g.dart';

@CopyWith()
@HiveType(typeId: 45)
class Kholle extends Equatable {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final String subject;
  @HiveField(2)
  final String kholleur;
  @HiveField(3)
  final String? message;
  @HiveField(4)
  final String? room;

  Kholle(this.date, this.subject, this.kholleur, this.message, this.room);

  @override
  List<Object?> get props => [date, subject, kholleur, message, room];

  @override
  bool? get stringify => true;
}
