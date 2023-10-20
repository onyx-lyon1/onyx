import 'package:equatable/equatable.dart';

class Kholle extends Equatable {
  final DateTime date;
  final String subject;
  final String? message;
  final String? kholleur;

  Kholle(this.date, this.subject, this.message, this.kholleur);

  @override
  List<Object?> get props => [date, subject, message, kholleur];

  @override
  bool? get stringify => true;
}
