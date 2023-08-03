import 'package:equatable/equatable.dart';

class CbModel extends Equatable {
  final String name;
  final String id;

  CbModel(this.name, this.id);

  @override
  List<Object?> get props => [name, id];
  @override
  bool get stringify => true;
}
