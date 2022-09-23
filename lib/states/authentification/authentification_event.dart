part of 'authentification_bloc.dart';

@immutable
abstract class AuthentificationEvent {}

// ignore: must_be_immutable
class AuthentificationLogin extends AuthentificationEvent {
  final bool keepLogedIn;
  final String? username;
  final String? password;
  AuthentificationLogin({this.username, this.password, required this.keepLogedIn});
}
class AuthentificationLogout extends AuthentificationEvent {}
class AuthentificationForgetCredential extends AuthentificationEvent{}