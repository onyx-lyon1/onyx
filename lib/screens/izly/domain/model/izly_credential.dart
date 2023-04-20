import 'package:hive_flutter/hive_flutter.dart';

part 'generated/izly_credential.g.dart';

@HiveType(typeId: 15)
class IzlyCredential {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  IzlyCredential({
    required this.username,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IzlyCredential &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password;

  @override
  int get hashCode => username.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'IzlyCredential{username: $username, password: $password}';
  }
}
