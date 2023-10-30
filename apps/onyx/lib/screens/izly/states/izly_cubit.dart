import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/settings/domain/model/settings_model.dart';

part 'izly_state.dart';

class IzlyCubit extends Cubit<IzlyState> {
  IzlyClient? _izlyClient;

  IzlyCubit() : super(IzlyState(status: IzlyStatus.initial));

  void connect(
      {IzlyCredential? credential, required SettingsModel settings}) async {
    //mock gestion
    if (Res.mock) {
      _izlyClient = IzlyClient("mockUsername", "mockPassword");
      emit(
        state.copyWith(
            status: IzlyStatus.loaded,
            balance: 100.0,
            qrCode: (await rootBundle.load('assets/izly_mock_qr-code.png'))
                .buffer
                .asUint8List(),
            izlyClient: _izlyClient),
      );

      return;
    }
    //cache loading
    File amountFile = File("${CacheService.cachePath}/cached_izly_amount.data");
    double amount = 0.0;
    if (amountFile.existsSync()) {
      amount = double.tryParse(amountFile.readAsStringSync()) ?? 0.0;
    }
    List<int> qrCode = await IzlyLogic.getQrCode();
    int qrCodeCount = await IzlyLogic.getAvailableQrCodeCount();
    emit(state.copyWith(
        status: IzlyStatus.connecting,
        qrCode: qrCode,
        balance: amount,
        qrCodeAvailables: qrCodeCount));

    //real load
    try {
      if (_izlyClient == null || !(await _izlyClient!.isLogged())) {
        //need to login
        credential ??= CacheService.get<IzlyCredential>(
            secureKey:
                await CacheService.getEncryptionKey(settings.biometricAuth), permanent: true);
        if (credential == null) {
          emit(state.copyWith(status: IzlyStatus.noCredentials));
          return;
        }
        _izlyClient = IzlyClient(credential.username, credential.password,
            corsProxyUrl: (kIsWeb) ? Res.corsProxy : "");
        bool loginResult = await _izlyClient!.login();
        if (!loginResult) {
          if (CacheService.exist<IzlyCredential>()) {
            emit(state.copyWith(status: IzlyStatus.error));
          } else {
            emit(state.copyWith(status: IzlyStatus.noCredentials));
          }
          return;
        } else {
          CacheService.set<IzlyCredential>(credential,
              secureKey:
                  await CacheService.getEncryptionKey(settings.biometricAuth), permanent: true);
        }
      }
      emit(state.copyWith(status: IzlyStatus.loading, izlyClient: _izlyClient));

      //Load qrcode
      await IzlyLogic.completeQrCodeCache(_izlyClient!);
      if (listEquals(qrCode,
          (await rootBundle.load('assets/izly.png')).buffer.asUint8List())) {
        qrCode = await IzlyLogic.getQrCode();
        await IzlyLogic.completeQrCodeCache(_izlyClient!);
      }
      //load balance
      double balance = await _izlyClient!.getBalance();
      File("${CacheService.cachePath}/cached_izly_amount.data")
          .writeAsStringSync(balance.toString());
      int qrCodeCount = await IzlyLogic.getAvailableQrCodeCount();
      emit(state.copyWith(
          status: IzlyStatus.loaded,
          balance: balance,
          qrCode: qrCode,
          qrCodeAvailables: qrCodeCount));
    } catch (e) {
      emit(state.copyWith(status: IzlyStatus.error));
    }
  }

  Future<void> loadPaymentHistory({bool cache = true}) async {
    if (state.izlyClient != null) {
      emit(state.copyWith(status: IzlyStatus.loading));
      if (cache && CacheService.exist<List<IzlyPaymentModel>>()) {
        emit(
          state.copyWith(
              status: IzlyStatus.cacheLoaded,
              paymentList: (CacheService.get<List<IzlyPaymentModel>>())!),
        );
      }
      try {
        List<IzlyPaymentModel> paymentList =
            await IzlyLogic.getUserPayments(state.izlyClient!);
        emit(state.copyWith(
            status: IzlyStatus.loaded, paymentList: paymentList));
        CacheService.set<List<IzlyPaymentModel>>(paymentList);
      } catch (e) {
        emit(state.copyWith(status: IzlyStatus.error));
      }
    } else {
      emit(state.copyWith(status: IzlyStatus.error));
    }
  }

  void disconnect() async {
    if (_izlyClient != null) {
      await _izlyClient!.logout();
    }
    emit(state.copyWith(status: IzlyStatus.initial));
  }

  void resetCubit() {
    emit(state.copyWith(status: IzlyStatus.initial));
  }
}
