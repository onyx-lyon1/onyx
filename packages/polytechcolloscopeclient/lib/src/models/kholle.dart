import 'package:equatable/equatable.dart';

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
