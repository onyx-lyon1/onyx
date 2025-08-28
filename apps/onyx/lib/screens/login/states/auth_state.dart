part of 'auth_cubit.dart';

enum AuthentificationStatus {
  initial,
  authentificating,
  authentificated,
  error,
  waitingBiometric
}

class AuthState extends Equatable {
  final AuthentificationStatus status;

  final String username;

  const AuthState({required this.status, this.username = ""});

  AuthState copyWith(
      {AuthentificationStatus? status,
      Lyon1CasClient? lyon1Cas,
      String? username}) {
    return AuthState(
        status: status ?? this.status, username: username ?? this.username);
  }

  @override
  List<Object?> get props => [status];

  @override
  bool? get stringify => true;
}
