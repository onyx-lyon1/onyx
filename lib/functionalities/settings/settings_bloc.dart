// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/model/settings.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsModel settings = SettingsModel();

  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SettingsLoad>(load);
    on<SettingsReset>(reset);
    on<SettingsModify>(modify);
    add(SettingsLoad());
  }

  Future<void> reset(SettingsReset event, Emitter<SettingsState> emit) async {
    settings = SettingsModel();
    Box<SettingsModel> box = Hive.box<SettingsModel>('settings');
    await box.put('settings', settings);
    await box.close();
    emit(SettingsReady());
  }

  Future<void> load(SettingsLoad event, Emitter<SettingsState> emit) async {
    Box<SettingsModel> box = await Hive.openBox<SettingsModel>('settings');
    SettingsModel? tmpSettings = box.get('settings');
    if (tmpSettings != null) {
      settings = tmpSettings;
    }
    await box.close();
    emit(SettingsReady());
  }

  Future<void> modify(SettingsModify event, Emitter<SettingsState> emit) async {
    if (kDebugMode) {
      print("modify settings");
    }
    settings = event.settings;
    Box<SettingsModel> box = await Hive.openBox<SettingsModel>('settings');
    await box.put('settings', settings);
    await box.close();
    emit(SettingsReady());
  }
}
