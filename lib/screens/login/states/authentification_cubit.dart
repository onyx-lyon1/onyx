import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartus/tomuss.dart' as tomusslib;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

part 'authentification_state.dart';

class AuthentificationCubit extends Cubit<AuthentificationState> {
  tomusslib.Dartus? _dartus;
  late String _usename;
  late String _password;

  AuthentificationCubit()
      : super(AuthentificationState(status: AuthentificationStatus.initial));

  Future<void> login(
      {required bool keepLogedIn, String? username, String? password}) async {
    //fetch username and password
    emit(state.copyWith(status: AuthentificationStatus.authentificating));
    try {
      AuthenticationModel auth = await AuthentificationLogic.fetchCredential(
          username: username, password: password);
      _usename = auth.username;
      _password = auth.password;
    } catch (e) {
      emit(state.copyWith(
          status: AuthentificationStatus.needCredential, dartus: _dartus));
      return;
    }
    //login
    if ((await (Connectivity().checkConnectivity())) !=
        ConnectivityResult.none) {
      try {
        _dartus = await AuthentificationLogic.login(
            username: _usename, password: _password, keepLogedIn: keepLogedIn);
        emit(state.copyWith(
            status: AuthentificationStatus.authentificated,
            username: _usename,
            password: _password,
            dartus: _dartus));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(state.copyWith(status: AuthentificationStatus.error));
        return;
      }
    } else {
      Connectivity().onConnectivityChanged.listen((event) {
        if (event != ConnectivityResult.none) {
          if (kDebugMode) {
            print("retrieve connection");
          }
          login(
              keepLogedIn: keepLogedIn, password: password, username: username);
        }
      });
    }
  }

  Future<void> forget() async {
    if (kDebugMode) {
      print("forget credential");
    }
    Box<AuthenticationModel> authBox =
        await Hive.openBox<AuthenticationModel>("authentification");
    authBox.delete("credential");
  }

  Future<void> logout() async {
    if (kDebugMode) {
      print("logout");
    }
    Box<AuthenticationModel> authBox =
        await Hive.openBox<AuthenticationModel>("authentification");
    authBox.delete("credential");
    CacheService.reset<SchoolSubjectModelWrapper>();
    CacheService.reset<DayModelWrapper>();
    CacheService.reset<EmailModelWrapper>();
    SettingsLogic.reset();
    _usename = "";
    _password = "";
    // await authBox.close();
    if (_dartus != null) {
      await _dartus!.logout();
    }
    emit(state.copyWith(
        status: AuthentificationStatus.needCredential,
        username: "",
        password: "",
        dartus: _dartus));
  }
}
