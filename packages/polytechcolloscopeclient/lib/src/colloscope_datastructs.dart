import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String name;
  final String id;

  Student(this.name, this.id);

  @override
  List<Object?> get props => [name, id];

  @override
  bool? get stringify => true;
}

class StudentColloscope extends Equatable {
  final int studentId;
  final int trinomeId;
  final List kholles;

  StudentColloscope(this.studentId, this.trinomeId, this.kholles);

  @override
  List<Object?> get props => [studentId, trinomeId, kholles];

  @override
  bool? get stringify => true;
}

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
