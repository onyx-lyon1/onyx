import 'package:hive_flutter/hive_flutter.dart';

part 'generated/authentication_model.g.dart';

@HiveType(typeId: 4)
class AuthenticationModel {
  @HiveField(0)
  String username;
  @HiveField(1)
  String password;

  AuthenticationModel({this.username = "", this.password = ""});

  @override
  String toString() {
    return 'AuthenticationModel{username: $username, password: $password}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationModel &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password;

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
