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
  int qrCodeAvailables;

  IzlyState({
    this.izlyClient,
    this.status = IzlyStatus.initial,
    this.balance = 0.0,
    this.qrCode,
    this.qrCodeAvailables = 0,
  });

  IzlyState copyWith({
    IzlyStatus? status,
    double? balance,
    Uint8List? qrCode,
    IzlyClient? izlyClient,
    int? qrCodeAvailables,
  }) {
    return IzlyState(
      status: status ?? this.status,
      balance: balance ?? this.balance,
      qrCode: qrCode ?? this.qrCode,
      izlyClient: izlyClient ?? this.izlyClient,
      qrCodeAvailables: qrCodeAvailables ?? this.qrCodeAvailables,
    );
  }
}
