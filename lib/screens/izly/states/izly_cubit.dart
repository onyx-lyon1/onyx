import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:izlyclient/dart_izlyclient.dart';
import 'package:onyx/screens/izly/izly_export.dart';

part 'izly_state.dart';

class IzlyCubit extends Cubit<IzlyState> {
  IzlyClient? _izlyClient;

  IzlyCubit() : super(IzlyState(status: IzlyStatus.initial));

  void login({String username = "", String password = ""}) async {
    Box box = await Hive.openBox<double>("cached_izly_amount");
    double amount = box.get("amount") ?? 0.0;
    Uint8List qrCode = await IzlyLogic.getQrCode(_izlyClient);
    emit(state.copyWith(
        status: IzlyStatus.connecting, qrCode: qrCode, balance: amount));
    try {
      IzlyCredential creds = (await IzlyLogic.getIzlyCredential(
          username: username, password: password))!;
      _izlyClient = IzlyClient(creds.username, creds.password);
      await _izlyClient!.login();
      emit(state.copyWith(status: IzlyStatus.connected));
    } catch (e) {
      emit(state.copyWith(status: IzlyStatus.noCredentials));
    }
  }

  void loadEveryone() async {
    if (_izlyClient == null) {
      emit(state.copyWith(status: IzlyStatus.error));
      return;
    }
    emit(state.copyWith(status: IzlyStatus.loading));
    try {
      double balance = await _izlyClient!.getBalance();
      Box box = await Hive.openBox<double>("cached_izly_amount");
      box.put("amount", balance);
      Uint8List qrCode = await IzlyLogic.getQrCode(_izlyClient);
      emit(state.copyWith(
          status: IzlyStatus.loaded, balance: balance, qrCode: qrCode));
    } catch (e) {
      emit(state.copyWith(status: IzlyStatus.error));
    }
  }

  void loadBalance() async {
    if (_izlyClient == null) {
      emit(state.copyWith(status: IzlyStatus.error));
      return;
    }
    emit(state.copyWith(status: IzlyStatus.loading));
    try {
      var balance = await _izlyClient!.getBalance();
      emit(state.copyWith(status: IzlyStatus.loaded, balance: balance));
    } catch (e) {
      emit(state.copyWith(status: IzlyStatus.error));
    }
  }

  void loadQrCode() async {
    if (_izlyClient == null) {
      emit(state.copyWith(status: IzlyStatus.error));
      return;
    }
    emit(state.copyWith(status: IzlyStatus.loading));
    try {
      Uint8List qrCode = await IzlyLogic.getQrCode(_izlyClient);
      emit(state.copyWith(status: IzlyStatus.loaded, qrCode: qrCode));
    } catch (e) {
      emit(state.copyWith(status: IzlyStatus.error));
    }
  }
}
