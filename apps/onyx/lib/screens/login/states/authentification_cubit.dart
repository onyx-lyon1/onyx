import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';

part 'authentification_state.dart';

class AuthentificationCubit extends Cubit<AuthentificationState> {
  Lyon1CasClient _lyon1Cas =
      Lyon1CasClient(corsProxyUrl: (kIsWeb) ? Res.corsProxy : "");

  AuthentificationCubit()
      : super(AuthentificationState(
            status: AuthentificationStatus.initial,
            lyon1Cas: Lyon1CasClient()));

  Future<void> checkIfLoggedIn() async {
    bool ok = (await _lyon1Cas.checkAuthentificated());
    if (ok) {
      emit(state.copyWith(status: AuthentificationStatus.authentificated));
    } else {
      emit(state.copyWith(status: AuthentificationStatus.needCredential));
    }
  }

  Future<void> login(
      {required Credential? creds, required SettingsModel settings}) async {
    if (Res.mock) {
      await CacheService.set<Credential>(
        Credential("mockUsername", "mockPassword"),
        secureKey: await CacheService.getEncryptionKey(settings.biometricAuth),
      );
      emit(state.copyWith(
          status: AuthentificationStatus.authentificated, lyon1Cas: _lyon1Cas));
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
        ({bool authResult, Credential credential}) auth =
            await _lyon1Cas.authenticate(creds);
        emit(state.copyWith(
            status: auth.authResult
                ? AuthentificationStatus.authentificated
                : AuthentificationStatus.error,
            lyon1Cas: _lyon1Cas));
        await CacheService.set<Credential>(
          auth.credential,
          secureKey:
              await CacheService.getEncryptionKey(settings.biometricAuth),
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
    await _lyon1Cas.logout();
    emit(state.copyWith(
      status: AuthentificationStatus.needCredential,
      lyon1Cas: _lyon1Cas,
    ));
  }

  void resetCubit() {
    _lyon1Cas = Lyon1CasClient(corsProxyUrl: (kIsWeb) ? Res.corsProxy : "");
    emit(state.copyWith(
      status: AuthentificationStatus.initial,
      lyon1Cas: _lyon1Cas,
    ));
  }
}
