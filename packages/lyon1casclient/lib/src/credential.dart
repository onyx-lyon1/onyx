import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'generated/credential.g.dart';

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
