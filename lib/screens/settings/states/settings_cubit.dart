import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:workmanager/workmanager.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(
            settings: SettingsModel(), status: SettingsStatus.initial)) {
    load();
  }

  Future<void> reset() async {
    await SettingsLogic.reset();
    emit(state.copyWith(
        status: SettingsStatus.ready, settings: SettingsModel()));
  }

  Future<void> load() async {
    emit(state.copyWith(status: SettingsStatus.loading));
    try {
      emit(state.copyWith(
          status: SettingsStatus.ready, settings: await SettingsLogic.load()));
    } catch (e) {
      emit(state.copyWith(
          status: SettingsStatus.error, settings: SettingsModel()));
    }
    if (!(state.settings.calendarUpdateNotification &&
        state.settings.newMailNotification &&
        state.settings.newGradeNotification)) {
      if (!Platform.environment.containsKey('FLUTTER_TEST') &&
          (!kIsWeb && (Platform.isAndroid || Platform.isIOS))) {
        Workmanager().cancelByUniqueName("updateChecking");
      }
    }
  }

  Future<void> modify({required SettingsModel settings}) async {
    await SettingsLogic.modify(settings: settings);
    emit(state.copyWith(status: SettingsStatus.ready, settings: settings));
  }

  void resetCubit() async {
    emit(SettingsState(
        settings: SettingsModel(), status: SettingsStatus.initial));
  }

  void collapseAll() {
    emit(state.copyWith(collapseAll: true));
  }
}
