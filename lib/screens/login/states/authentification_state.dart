part of 'authentification_cubit.dart';

enum AuthentificationStatus {
  initial,
  needCredential,
  authentificating,
  authentificated,
  error
}

class AuthentificationState extends Equatable {
  final AuthentificationStatus status;
  final Dartus? dartus;

  const AuthentificationState({required this.status, this.dartus});

  AuthentificationState copyWith(
      {AuthentificationStatus? status, Dartus? dartus}) {
    return AuthentificationState(
        status: status ?? this.status, dartus: dartus ?? this.dartus);
  }

  @override
  List<Object?> get props => [status, dartus];

  @override
  bool? get stringify => true;
}
