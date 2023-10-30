part of 'izly_cubit.dart';

@MappableEnum()
enum IzlyStatus {
  @MappableValue(000)
  initial,
  @MappableValue(100)
  connecting,
  @MappableValue(200)
  connected,
  @MappableValue(300)
  loading,
  @MappableValue(400)
  loaded,
  @MappableValue(500)
  cacheLoaded,
  @MappableValue(600)
  error,
  @MappableValue(700)
  noCredentials
}

@MappableClass()
class IzlyState with IzlyStateMappable {
  IzlyStatus status;
  IzlyClient? izlyClient;
  double balance;
  List<int>? qrCode;
  int qrCodeAvailables;
  List<IzlyPaymentModel> paymentList;

  IzlyState({
    this.izlyClient,
    this.status = IzlyStatus.initial,
    this.balance = 0.0,
    this.qrCode,
    this.qrCodeAvailables = 0,
    this.paymentList = const [],
  });
}
