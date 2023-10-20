import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String name;
  final int id;

  Student(this.name, this.id);

  @override
  List<Object?> get props => [name, id];

  @override
  bool? get stringify => true;
}
