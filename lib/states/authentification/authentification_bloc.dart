// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartus/tomuss.dart' as tomusslib;
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/model/authentication.dart';

part 'authentification_event.dart';

part 'authentification_state.dart';

class AuthentificationBloc
    extends Bloc<AuthentificationEvent, AuthentificationState> {
  late tomusslib.Dartus dartus;
  late String usename;
  late String password;

  AuthentificationBloc() : super(AuthentificationInitial()) {
    on<AuthentificationEvent>((event, emit) {
      if (kDebugMode) {
        print("event authentification: $event");
      }
    });
    on<AuthentificationLogin>(login);
    on<AuthentificationLogout>(logout);
    on<AuthentificationForgetCredential>(forget);
  }

  Future<void> login(
      AuthentificationLogin event, Emitter<AuthentificationState> emit) async {
    if (kDebugMode) {
      print("login");
    }
    Box<Authentication> authBox =
        await Hive.openBox<Authentication>("authentification");
    Authentication? auth;
    if (event.username != null && event.password != null) {
      auth =
          Authentication(username: event.username!, password: event.password!);
      usename = event.username!;
      password = event.password!;
    } else {
      auth = authBox.get("credential");
    }
    if (auth == null) {
      emit(AuthentificationNeedCredential());
    } else {
      usename = auth.username;
      password = auth.password;
      emit(AuthentificationAuthentificating());
      final tomusslib.Dartus tomuss = tomusslib.Dartus(
          tomusslib.Authentication(auth.username, auth.password));
      if (await tomuss.authenticate()) {
        dartus = tomuss;
        if (event.keepLogedIn) {
          await authBox.put("credential", auth);
        }
        emit(AuthentificationAuthentificated());
      } else {
        emit(AuthentificationError());
      }
    }
    await authBox.close();
  }

  Future<void> forget(event, Emitter<AuthentificationState> emit) async {
    if (kDebugMode) {
      print("forget credential");
    }
    Box<Authentication> authBox =
        await Hive.openBox<Authentication>("authentification");
    authBox.delete("credential");
    await authBox.close();
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
    await authBox.close();
    await dartus.logout();
    emit(AuthentificationNeedCredential());
  }
}
