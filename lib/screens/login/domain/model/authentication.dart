// ignore_for_file: hash_and_equals

import 'package:hive_flutter/hive_flutter.dart';

part 'authentication.g.dart';

@HiveType(typeId: 1)
class Authentication {
  @HiveField(0)
  String username;
  @HiveField(1)
  String password;

  Authentication({this.username = "", this.password = ""});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Authentication &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password;

  @override
  String toString() {
    return 'Authentication{username: $username, password: $password}';
  }




}
