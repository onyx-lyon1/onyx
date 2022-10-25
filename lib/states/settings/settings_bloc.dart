// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:oloid2/model/settings.dart';
import 'package:workmanager/workmanager.dart';

import 'package:oloid2/functionalities/settings_backend/settings_backend.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsModel settings = SettingsModel();

  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {
      if (kDebugMode) {
        print("SettingsBloc: $event");
      }
    });
    on<SettingsLoad>(load);
    on<SettingsReset>(reset);
    on<SettingsModify>(modify);
    add(SettingsLoad());
  }

  Future<void> reset(SettingsReset event, Emitter<SettingsState> emit) async {
    settings = SettingsModel();
    await SettingsBackend.reset();
    emit(SettingsReady());
  }

  Future<void> load(SettingsLoad event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    try{
      settings = await SettingsBackend.load();
    }catch(e){
      settings = SettingsModel();
    }
    emit(SettingsReady());
    if (!(settings.calendarUpdateNotification &&
        settings.newMailNotification &&
        settings.newGradeNotification)) {
      Workmanager().cancelByUniqueName("updateChecking");
    }
  }

  Future<void> modify(SettingsModify event, Emitter<SettingsState> emit) async {
    settings = event.settings;
    await SettingsBackend.modify(settings: settings);
    emit(SettingsReady());
  }
}
