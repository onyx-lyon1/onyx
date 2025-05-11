import 'dart:async';

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

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  Lyon1CasClient lyon1Cas =
      Lyon1CasClient(corsProxyUrl: (kIsWeb) ? Res.corsProxy : "");

  AuthCubit() : super(AuthState(status: AuthentificationStatus.initial));

  Future<bool> checkIfLoggedIn() async {
    bool ok = (await lyon1Cas.checkAuthentificated());
    if (ok) {
      emit(state.copyWith(status: AuthentificationStatus.authentificated));
    } else {
      emit(state.copyWith(status: AuthentificationStatus.initial));
    }
    return ok;
  }

  Future<bool> login(
      {Credential? creds, required SettingsModel settings}) async {
    if (Res.mock) {
      await CacheService.set<Credential>(
        Credential("mockUsername", "mockPassword"),
        secureKey: await CacheService.getEncryptionKey(settings.biometricAuth),
      );
      lyon1Cas.isAuthenticated = true;
      emit(state.copyWith(
          status: AuthentificationStatus.authentificated, lyon1Cas: lyon1Cas));
      return true;
    }

    if (settings.biometricAuth) {
      emit(state.copyWith(status: AuthentificationStatus.waitingBiometric));
    }
    List<int> key = await CacheService.getEncryptionKey(settings.biometricAuth);
    creds ??= await CacheService.get<Credential>(secureKey: key);
    if (creds == null) {
      emit(state.copyWith(status: AuthentificationStatus.initial));
      return false;
    }
    emit(state.copyWith(status: AuthentificationStatus.authentificating));

    //login
    if (!(await (Connectivity().checkConnectivity()))
        .contains(ConnectivityResult.none)) {
      try {
        bool authenticated = await lyon1Cas.authenticate(creds);
        emit(state.copyWith(
            status: authenticated
                ? AuthentificationStatus.authentificated
                : AuthentificationStatus.error,
            username: creds.username));
        await CacheService.set<Credential>(creds, secureKey: key);
        return authenticated;
      } catch (e) {
        Res.logger.e(e);
        emit(
          state.copyWith(status: AuthentificationStatus.error),
        );
        return false;
      }
    } else {
      StreamSubscription? connectivitySubscription;

      connectivitySubscription =
          Connectivity().onConnectivityChanged.listen((event) {
        if (!event.contains(ConnectivityResult.none)) {
          Res.logger.d("retrieve connection");
          connectivitySubscription?.cancel();
          login(
            creds: creds,
            settings: settings,
          );
        }
      });
    }
    return false;
  }

  Future<void> forget() async {
    Res.logger.t("forget credential");
    CacheService.reset<Credential>();
  }

  Future<void> logout() async {
    Res.logger.t("logout");
    CacheService.reset<TeachingUnitList>();
    CacheService.reset<Agenda>();
    CacheService.reset<MailBoxList>();
    CacheService.reset<Credential>();
    SettingsLogic.reset();
    await lyon1Cas.logout();
    emit(state.copyWith(
      status: AuthentificationStatus.initial,
      lyon1Cas: lyon1Cas,
    ));
  }

  void resetCubit() {
    lyon1Cas = Lyon1CasClient(corsProxyUrl: (kIsWeb) ? Res.corsProxy : "");
    emit(state.copyWith(
      status: AuthentificationStatus.initial,
      lyon1Cas: lyon1Cas,
    ));
  }
}
