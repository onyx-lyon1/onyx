import 'package:equatable/equatable.dart';

class Kholle extends Equatable {
  final DateTime date;
  final String subject;
  final String kholleur;
  final String? message;

  Kholle(this.date, this.subject, this.kholleur, this.message);

  @override
  List<Object?> get props => [date, subject, kholleur, message];

  @override
  bool? get stringify => true;
}
