import 'package:dart_mappable/dart_mappable.dart';

part 'generated/izly_credential.mapper.dart';

@MappableClass()
class IzlyCredential with IzlyCredentialMappable {
  final String username;
  final String password;

  IzlyCredential({required this.username, required this.password});
}
