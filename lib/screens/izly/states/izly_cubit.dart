import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:onyx/screens/izly/izly_export.dart';

part 'izly_state.dart';

class IzlyCubit extends Cubit<IzlyState> {
  IzlyClient? _izlyClient;

  IzlyCubit() : super(IzlyState(status: IzlyStatus.initial));

  void connect({String username = "", String password = ""}) async {
    Box box = await Hive.openBox<double>("cached_izly_amount");
    double amount = box.get("amount") ?? 0.0;
    Uint8List qrCode = await IzlyLogic.getQrCode();
    emit(state.copyWith(
        status: IzlyStatus.connecting, qrCode: qrCode, balance: amount));
    late IzlyCredential creds;
    try {
      if (_izlyClient == null || !(await _izlyClient!.isLogged())) {
        creds = (await IzlyLogic.getIzlyCredential(
            username: username, password: password));
      }
    } catch (e) {
      emit(state.copyWith(status: IzlyStatus.noCredentials));
      return;
    }
    try {
      if (_izlyClient == null || !(await _izlyClient!.isLogged())) {
        _izlyClient = IzlyClient(creds.username, creds.password);
        await _izlyClient!.login();
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

  void resetCubit(){
    emit(state.copyWith(status: IzlyStatus.initial));
  }
}
