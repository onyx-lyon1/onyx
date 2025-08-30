import 'package:dart_mappable/dart_mappable.dart';

part 'generated/credential.mapper.dart';

@MappableClass()
class Credential with CredentialMappable {
  late final String username;
  late final String password;
  late final String tgcToken;

  Credential(this.username, this.password, {this.tgcToken = ""});
}
