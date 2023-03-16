import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
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

  Future<void> move(
      {required bool oldEnabled,
      required bool newEnabled,
      required int oldIndex,
      required int newIndex}) async {
    if ((oldEnabled && !newEnabled) &&
        state.settings.enabledFunctionalities[oldIndex] !=
            Functionalities.settings) {
      Functionalities item = state.settings.enabledFunctionalities[oldIndex];
      switch (item) {
        case Functionalities.agenda:
          await modify(
              settings: state.settings.copyWith(
            calendarUpdateNotification: false,
          ));
          break;
        case Functionalities.mail:
          await modify(
              settings: state.settings.copyWith(
            newMailNotification: false,
          ));
          break;
        case Functionalities.tomuss:
          await modify(
              settings: state.settings.copyWith(
            newGradeNotification: false,
          ));
          break;
        default:
          break;
      }
      modify(
          settings: state.settings.copyWith(
              enabledFunctionalities: state.settings.enabledFunctionalities
                  .where((element) => element != item)
                  .toList(),
              disabledFunctionalities:
                  state.settings.disabledFunctionalities.toList()
                    ..insert(newIndex, item)));
    } else if (!oldEnabled && newEnabled) {
      Functionalities item = state.settings.disabledFunctionalities[oldIndex];
      modify(
          settings: state.settings.copyWith(
              disabledFunctionalities: state.settings.disabledFunctionalities
                  .where((element) => element != item)
                  .toList(),
              enabledFunctionalities:
                  state.settings.enabledFunctionalities.toList()
                    ..insert(newIndex, item)));
    } else if (oldEnabled && newEnabled) {
      Functionalities item = state.settings.enabledFunctionalities[oldIndex];
      modify(
          settings: state.settings.copyWith(
              enabledFunctionalities:
                  state.settings.enabledFunctionalities.toList()
                    ..removeAt(oldIndex)
                    ..insert(newIndex, item)));
    } else if ((!oldEnabled && !newEnabled) &&
        state.settings.enabledFunctionalities[oldIndex] !=
            Functionalities.settings) {
      Functionalities item = state.settings.disabledFunctionalities[oldIndex];
      modify(
          settings: state.settings.copyWith(
              disabledFunctionalities:
                  state.settings.disabledFunctionalities.toList()
                    ..removeAt(oldIndex)
                    ..insert(newIndex, item)));
    }
  }

  void collapseAll() {
    emit(state.copyWith(collapseAll: true));
  }
}
