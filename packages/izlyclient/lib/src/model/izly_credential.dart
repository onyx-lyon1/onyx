import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'generated/izly_credential.g.dart';

@CopyWith()
class IzlyCredential extends Equatable {
  final String username;
  final String password;

  IzlyCredential({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
  @override
  bool get stringify => true;
}
