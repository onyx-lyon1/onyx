part of 'izly_cubit.dart';

enum IzlyStatus {
  initial,
  connecting,
  connected,
  loading,
  loaded,
  error,
  noCredentials
}

class IzlyState {
  IzlyStatus status;
  IzlyClient? izlyClient;
  double balance;
  Uint8List? qrCode;

  IzlyState({
    this.izlyClient,
    this.status = IzlyStatus.initial,
    this.balance = 0.0,
    this.qrCode,
  });

  IzlyState copyWith({
    IzlyStatus? status,
    double? balance,
    Uint8List? qrCode,
    IzlyClient? izlyClient,
  }) {
    return IzlyState(
      status: status ?? this.status,
      balance: balance ?? this.balance,
      qrCode: qrCode ?? this.qrCode,
      izlyClient: izlyClient ?? this.izlyClient,
    );
  }
}
