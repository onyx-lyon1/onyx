part of 'izly_cubit.dart';

enum IzlyStatus {
  initial,
  connecting,
  connected,
  loading,
  loaded,
  cacheLoaded,
  error,
  noCredentials
}

class IzlyState {
  IzlyStatus status;
  IzlyClient? izlyClient;
  double balance;
  Uint8List? qrCode;
  List<IzlyPaymentModel> paymentList;
  bool showQrCode;

  IzlyState({
    this.izlyClient,
    this.status = IzlyStatus.initial,
    this.balance = 0.0,
    this.qrCode,
    this.paymentList = const [],
    this.showQrCode = false,
  });

  IzlyState copyWith({
    IzlyStatus? status,
    double? balance,
    Uint8List? qrCode,
    IzlyClient? izlyClient,
    List<IzlyPaymentModel>? paymentList,
    bool? showQrCode,
  }) {
    return IzlyState(
      status: status ?? this.status,
      balance: balance ?? this.balance,
      qrCode: qrCode ?? this.qrCode,
      izlyClient: izlyClient ?? this.izlyClient,
      paymentList: paymentList ?? this.paymentList,
      showQrCode: showQrCode ?? this.showQrCode,
    );
  }
}
