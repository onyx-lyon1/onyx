// ignore_for_file: hash_and_equals

import 'package:hive_flutter/hive_flutter.dart';


part 'authentication_model.g.dart';

@HiveType(typeId: 4)
class AuthenticationModel {
  @HiveField(0)
  String username;
  @HiveField(1)
  String password;

  AuthenticationModel({this.username = "", this.password = ""});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationModel &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password;

  @override
  String toString() {
    return 'Authentication{username: $username, password: $password}';
  }




}
