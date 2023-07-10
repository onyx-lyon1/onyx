import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
    print("connect");
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
    Box box = await Hive.openBox<double>("cached_izly_amount");
    double amount = box.get("amount") ?? 0.0;
    print("lets get qr code");
    Uint8List qrCode = await IzlyLogic.getQrCode();
    print("end get qr code");
    emit(state.copyWith(
        status: IzlyStatus.connecting, qrCode: qrCode, balance: amount));
    print("connecting");
    print("_izlyClient : $_izlyClient");
    try {
      if (_izlyClient == null || !(await _izlyClient!.isLogged())) {
        credential ??= await CacheService.get<IzlyCredential>(
            secureKey:
                await CacheService.getEncryptionKey(settings.biometricAuth));
        if (credential == null) {
          emit(state.copyWith(status: IzlyStatus.noCredentials));
          return;
        }
        _izlyClient = IzlyClient(credential.username, credential.password,
            corsProxyUrl: (kIsWeb) ? Res.corsProxy : "null");
        bool loginResult = await _izlyClient!.login();
        if (!loginResult) {
          if (await CacheService.exist<IzlyCredential>(
              secureKey: await CacheService.getEncryptionKey(
                  settings.biometricAuth))) {
            emit(state.copyWith(status: IzlyStatus.error));
          } else {
            emit(state.copyWith(status: IzlyStatus.noCredentials));
          }
          return;
        } else {
          await CacheService.set<IzlyCredential>(credential,
              secureKey:
                  await CacheService.getEncryptionKey(settings.biometricAuth));
        }
      }
      emit(state.copyWith(status: IzlyStatus.loading, izlyClient: _izlyClient));
      await IzlyLogic.completeQrCodeCache(_izlyClient!);
      if (listEquals(qrCode,
          (await rootBundle.load('assets/izly.png')).buffer.asUint8List())) {
        qrCode = await IzlyLogic.getQrCode();
        await IzlyLogic.completeQrCodeCache(_izlyClient!);
      }
      double balance = await _izlyClient!.getBalance();
      Box box = await Hive.openBox<double>("cached_izly_amount");
      await box.put("amount", balance);
      box.close();
      emit(state.copyWith(
          status: IzlyStatus.loaded, balance: balance, qrCode: qrCode));
    } catch (e) {
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
