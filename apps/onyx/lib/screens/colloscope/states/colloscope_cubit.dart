import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:polytechcolloscopeclient/polytechcolloscopeclient.dart';

part 'colloscope_state.dart';

class ColloscopeCubit extends Cubit<ColloscopeState> {
  PolytechColloscopeClient? _colloscopeClient;

  ColloscopeCubit()
      : super(const ColloscopeState(
            status: ColloscopeStatus.initial, studentColloscope: null));

  void load(
      String name, String surname, String username, int yearOverride) async {
    emit(state.copyWith(status: ColloscopeStatus.loading));

    if (Res.mock) {
      emit(state.copyWith(
        status: ColloscopeStatus.ready,
        studentColloscope:
            StudentColloscope(Student(Year.second, "Oui", 351), 10, [
          Kholle(DateTime.now(), "Oui Matiere", "Oui Kholleur", "Oui message",
              "Oui Room"),
          Kholle(DateTime.now(), "Oui Matiere", "Oui Kholleur", "Oui message",
              "Oui Room"),
          Kholle(DateTime.now(), "Oui Matiere", "Oui Kholleur", "Oui message",
              "Oui Room"),
          Kholle(DateTime.now(), "Oui Matiere", "Oui Kholleur", "Oui message",
              null),
        ]),
      ));

      return;
    }

    if (name.isEmpty || surname.isEmpty) {
      emit(state.copyWith(status: ColloscopeStatus.error));
      return;
    }

    final encrypted = await rootBundle.loadString(Res.colloscopeIdsPath);
    final key = Key.fromBase64(await rootBundle.loadString(Res.keyPath));
    final iv = IV.fromBase64(await rootBundle.loadString(Res.ivPath));
    final encrypter = Encrypter(AES(key));
    final decrypted =
        encrypter.decrypt(Encrypted.fromBase64(encrypted), iv: iv);
    final decoded = base64.decode(decrypted);
    final deziped = gzip.decode(decoded);
    final jsonText = utf8.decode(deziped);

    final json = jsonDecode(jsonText);

    _colloscopeClient =
        PolytechColloscopeClient(json["username"], json["password"]);

    int year;

    if (yearOverride != 0) {
      year = yearOverride;
    } else if (RegExp(r"^([pP])\d{7}$").hasMatch(username.trim())) {
      year = int.parse(username.substring(1, 3));
      year = DateTime.now().year - 2000 - year + 1;
    } else {
      emit(state.copyWith(status: ColloscopeStatus.error));
      return;
    }

    final student = await _colloscopeClient?.fetchStudent(
        Year.values[year - 1], name, surname);

    if (student == null) {
      emit(state.copyWith(status: ColloscopeStatus.error));
      return;
    }

    emit(state.copyWith(
      status: ColloscopeStatus.ready,
      studentColloscope: await _colloscopeClient!.getColloscope(student),
    ));
  }

//cache loading
/*Box box = await Hive.openBox<double>("cached_izly_amount");
    double amount = box.get("amount") ?? 0.0;
    Uint8List qrCode = await IzlyLogic.getQrCode();
    int qrCodeCount = await IzlyLogic.getAvailableQrCodeCount();
    emit(state.copyWith(
        status: IzlyStatus.connecting,
        qrCode: qrCode,
        balance: amount,
        qrCodeAvailables: qrCodeCount));*/

//real load
/*try {
      if (_izlyClient == null || !(await _izlyClient!.isLogged())) {
        //need to login
        credential ??= await CacheService.get<IzlyCredential>(
            secureKey:
            await CacheService.getEncryptionKey(settings.biometricAuth));
        if (credential == null) {
          emit(state.copyWith(status: IzlyStatus.noCredentials));
          return;
        }
        _izlyClient = IzlyClient(credential.username, credential.password,
            corsProxyUrl: (kIsWeb) ? Res.corsProxy : "");
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

      //Load qrcode
      await IzlyLogic.completeQrCodeCache(_izlyClient!);
      if (listEquals(qrCode,
          (await rootBundle.load('assets/izly.png')).buffer.asUint8List())) {
        qrCode = await IzlyLogic.getQrCode();
        await IzlyLogic.completeQrCodeCache(_izlyClient!);
      }
      //load balance
      double balance = await _izlyClient!.getBalance();
      Box box = await Hive.openBox<double>("cached_izly_amount");
      await box.put("amount", balance);
      box.close();
      int qrCodeCount = await IzlyLogic.getAvailableQrCodeCount();
      emit(state.copyWith(
          status: IzlyStatus.loaded,
          balance: balance,
          qrCode: qrCode,
          qrCodeAvailables: qrCodeCount));
    } catch (e) {
      emit(state.copyWith(status: IzlyStatus.error));
    }*/
//}

/*Future<void> loadPaymentHistory({bool cache = true}) async {
    if (state.izlyClient != null) {
      emit(state.copyWith(status: IzlyStatus.loading));
      if (cache && await CacheService.exist<IzlyPaymentModelList>()) {
        emit(state.copyWith(
            status: IzlyStatus.cacheLoaded,
            paymentList:
            (await CacheService.get<IzlyPaymentModelList>())!.payments));
      }
      try {
        List<IzlyPaymentModel> paymentList =
        await IzlyLogic.getUserPayments(state.izlyClient!);
        emit(state.copyWith(
            status: IzlyStatus.loaded, paymentList: paymentList));
        await CacheService.set<IzlyPaymentModelList>(
            IzlyPaymentModelList(payments: paymentList));
      } catch (e) {
        emit(state.copyWith(status: IzlyStatus.error));
      }
    } else {
      emit(state.copyWith(status: IzlyStatus.error));
    }
  }*/

/*void disconnect() async {
    if (_izlyClient != null) {
      await _izlyClient!.logout();
    }
    emit(state.copyWith(status: IzlyStatus.initial));
  }*/

  void resetCubit() {
    emit(state.copyWith(status: ColloscopeStatus.initial));
  }
}
