import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/credential.g.dart';

@JsonSerializable()
@CopyWith()
class Credential extends Equatable {
  late final String username;
  late final String password;
  late final String tgcToken;

  Credential(this.username, this.password, {this.tgcToken = ""});

  @override
  List<Object?> get props => [username, password, tgcToken];

  @override
  bool? get stringify => true;
}
