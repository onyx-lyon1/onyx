part of 'authentification_cubit.dart';

enum AuthentificationStatus { initial, needCredential, authentificating, authentificated, error }

class AuthentificationState {
  final AuthentificationStatus status;
  final String username;
  final String password;
  final tomusslib.Dartus? dartus;
  AuthentificationState(
      {required this.status,
      this.username = "",
      this.password = "",
      this.dartus});
  AuthentificationState copyWith({
    AuthentificationStatus? status,
    String? username,
    String? password,
    bool? keepLogedIn,
    tomusslib.Dartus? dartus,
  }) {
    return AuthentificationState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      dartus: dartus ?? this.dartus,
    );
  }
}

