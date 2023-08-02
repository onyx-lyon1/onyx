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
  final Lyon1CasClient lyon1Cas;

  const AuthentificationState({required this.status, required this.lyon1Cas});

  AuthentificationState copyWith(
      {AuthentificationStatus? status, Lyon1CasClient? lyon1Cas}) {
    return AuthentificationState(
        status: status ?? this.status, lyon1Cas: lyon1Cas ?? this.lyon1Cas);
  }

  @override
  List<Object?> get props => [status, lyon1Cas];

  @override
  bool? get stringify => true;
}
