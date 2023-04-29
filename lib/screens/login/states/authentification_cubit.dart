import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartus/tomuss.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agenda/lyon1agenda.dart';
import 'package:lyon1mail/lyon1mail.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';

part 'authentification_state.dart';

class AuthentificationCubit extends Cubit<AuthentificationState> {
  Dartus _dartus = Dartus();

  AuthentificationCubit()
      : super(const AuthentificationState(
      status: AuthentificationStatus.initial));

  Future<void> checkIfLoggedIn() async {
    bool ok = (await _dartus.checkAuthentificated());
    if (ok) {
      emit(state.copyWith(status: AuthentificationStatus.authentificated));
    } else {
      emit(state.copyWith(status: AuthentificationStatus.needCredential));
    }
  }

  Future<void> login(
      {required Credential? creds, required SettingsModel settings}) async {
    if (Res.mock) {
      emit(state.copyWith(
          status: AuthentificationStatus.authentificated,
          dartus: _dartus));
      return;
    }
    if (creds == null) {
      emit(state.copyWith(status: AuthentificationStatus.needCredential));
      return;
    }
    //fetch username and password
    emit(state.copyWith(status: AuthentificationStatus.authentificating));

    //login
    if ((await (Connectivity().checkConnectivity())) !=
        ConnectivityResult.none) {
      try {
        ({bool authResult, Credential credential}) auth = await _dartus
            .authenticate(creds);
        emit(state.copyWith(
            status: auth.authResult
                ? AuthentificationStatus.authentificated
                : AuthentificationStatus.error,
            dartus: _dartus));
        await CacheService.set<Credential>(auth.credential,
          secureKey: await CacheService.getEncryptionKey(
              settings.biometricAuth),
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(
          state.copyWith(status: AuthentificationStatus.error),
        );
        return;
      }
    } else {
      Connectivity().onConnectivityChanged.listen((event) {
        if (event != ConnectivityResult.none) {
          if (kDebugMode) {
            print("retrieve connection");
          }
          login(creds: creds, settings: settings);
        }
      });
    }
  }

  Future<void> forget() async {
    if (kDebugMode) {
      print("forget credential");
    }
    CacheService.reset<Credential>();
  }

  Future<void> logout() async {
    if (kDebugMode) {
      print("logout");
    }
    CacheService.reset<TeachingUnitList>();
    CacheService.reset<Agenda>();
    CacheService.reset<MailBoxList>();
    CacheService.reset<Credential>();
    SettingsLogic.reset();
    await _dartus.logout();
    emit(state.copyWith(
      status: AuthentificationStatus.needCredential,
      dartus: _dartus,
    ));
  }

  void resetCubit() {
    _dartus = Dartus();
    emit(state.copyWith(
      status: AuthentificationStatus.initial,
      dartus: _dartus,
    ));
  }
}
