part of 'authentification_bloc.dart';

@immutable
abstract class AuthentificationState {}

class AuthentificationInitial extends AuthentificationState {}
class AuthentificationNeedCredential extends AuthentificationState {}
class AuthentificationAuthentificating extends AuthentificationState {}
class AuthentificationAuthentificated extends AuthentificationState {}
class AuthentificationError extends AuthentificationState {}
