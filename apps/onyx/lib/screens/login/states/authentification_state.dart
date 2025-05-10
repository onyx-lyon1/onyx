part of 'authentification_cubit.dart';

enum AuthentificationStatus {
  initial,
  needCredential,
  authentificating,
  authentificated,
  error,
  waitingBiometric
}

class AuthState extends Equatable {
  final AuthentificationStatus status;
  final Lyon1CasClient lyon1Cas;

  final String username;

  const AuthState(
      {required this.status, required this.lyon1Cas, this.username = ""});

  AuthState copyWith(
      {AuthentificationStatus? status,
      Lyon1CasClient? lyon1Cas,
      String? username}) {
    return AuthState(
        status: status ?? this.status,
        lyon1Cas: lyon1Cas ?? this.lyon1Cas,
        username: username ?? this.username);
  }

  @override
  List<Object?> get props => [status, lyon1Cas];

  @override
  bool? get stringify => true;
}
