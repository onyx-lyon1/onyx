// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';

part 'authentication.g.dart';

@HiveType(typeId: 1)
class Authentication {
  @HiveField(0)
  String username;
  @HiveField(1)
  String password;

  Authentication({this.username = "", this.password = ""});
}
