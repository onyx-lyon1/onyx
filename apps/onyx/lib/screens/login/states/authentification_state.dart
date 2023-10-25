part of 'authentification_cubit.dart';

@MappableEnum()
enum AuthentificationStatus {
  @MappableValue(000)
  initial,
  @MappableValue(100)
  needCredential,
  @MappableValue(200)
  authentificating,
  @MappableValue(300)
  authentificated,
  @MappableValue(400)
  error,
  @MappableValue(500)
  waitingBiometric
}

@MappableClass()
class AuthentificationState with AuthentificationStateMappable {
  final AuthentificationStatus status;
  final Lyon1CasClient lyon1Cas;

  const AuthentificationState({required this.status, required this.lyon1Cas});
}
