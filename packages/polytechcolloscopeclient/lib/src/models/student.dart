import 'package:equatable/equatable.dart';

import '../consts.dart';

class Student extends Equatable {
  final Year year;
  final String name;
  final int id;

  Student(this.year, this.name, this.id);

  @override
  List<Object?> get props => [year, name, id];

  @override
  bool? get stringify => true;
}
