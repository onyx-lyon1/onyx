// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartus/tomuss.dart' as tomusslib;
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/functionalities/authentification_backend/authentification_backend.dart';
import 'package:oloid2/model/authentication.dart';

part 'authentification_event.dart';

part 'authentification_state.dart';

class AuthentificationBloc
    extends Bloc<AuthentificationEvent, AuthentificationState> {
  tomusslib.Dartus? dartus;
  late String usename;
  late String password;

  AuthentificationBloc() : super(AuthentificationInitial()) {
    on<AuthentificationEvent>((event, emit) {
      if (kDebugMode) {
        print("AuthentificationBloc: $event");
      }
    });
    on<AuthentificationLogin>(login);
    on<AuthentificationLogout>(logout);
    on<AuthentificationForgetCredential>(forget);
  }

  Future<void> login(
      AuthentificationLogin event, Emitter<AuthentificationState> emit) async {
    //fetch username and password
    try {
      Authentication auth = await AuthentificationBackend.fetchCredential(
          username: event.username, password: event.password);
      usename = auth.username;
      password = auth.password;
    } catch (e) {
      emit(AuthentificationNeedCredential());
      return;
    }
    //login
    try {
      dartus = await AuthentificationBackend.login(
          username: usename,
          password: password,
          keepLogedIn: event.keepLogedIn);
      emit(AuthentificationAuthentificated());
    } catch (e) {
      emit(AuthentificationError());
      return;
    }
  }

  Future<void> forget(event, Emitter<AuthentificationState> emit) async {
    if (kDebugMode) {
      print("forget credential");
    }
    Box<Authentication> authBox =
        await Hive.openBox<Authentication>("authentification");
    authBox.delete("credential");
  }

  Future<void> logout(event, Emitter<AuthentificationState> emit) async {
    if (kDebugMode) {
      print("logout");
    }
    Box<Authentication> authBox =
        await Hive.openBox<Authentication>("authentification");
    authBox.delete("credential");
    usename = "";
    password = "";
    // await authBox.close();
    if (dartus != null) {
      await dartus!.logout();
    }
    emit(AuthentificationNeedCredential());
  }
}
