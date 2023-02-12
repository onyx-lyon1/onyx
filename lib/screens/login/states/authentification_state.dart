part of 'authentification_cubit.dart';

enum AuthentificationStatus {
  initial,
  needCredential,
  authentificating,
  authentificated,
  error
}

class AuthentificationState {
  final AuthentificationStatus status;
  final String? username;
  final String? password;
  final tomusslib.Dartus? dartus;
  final bool firstLogin;

  AuthentificationState(
      {required this.status,
      this.username,
      this.password,
      this.dartus,
      this.firstLogin = true});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthentificationState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          username == other.username &&
          password == other.password &&
          dartus == other.dartus &&
          firstLogin == other.firstLogin;

  @override
  int get hashCode =>
      status.hashCode ^
      username.hashCode ^
      password.hashCode ^
      dartus.hashCode ^
      firstLogin.hashCode;

  AuthentificationState copyWith({
    AuthentificationStatus? status,
    String? username,
    String? password,
    bool? keepLogedIn,
    tomusslib.Dartus? dartus,
    bool? firstLogin,
  }) {
    return AuthentificationState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      dartus: dartus ?? this.dartus,
      firstLogin: firstLogin ?? this.firstLogin,
    );
  }

  @override
  String toString() {
    return 'AuthentificationState{status: $status, username: $username, password: $password, dartus: $dartus, firstLogin: $firstLogin}';
  }
}
