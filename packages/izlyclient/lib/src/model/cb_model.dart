import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/cb_model.g.dart';

@JsonSerializable()
class CbModel extends Equatable {
  final String name;
  final String id;

  CbModel(this.name, this.id);

  @override
  List<Object?> get props => [name, id];

  @override
  bool get stringify => true;
}
