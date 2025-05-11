import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:workmanager/workmanager.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({SettingsModel? settings}) : super(SettingsInitial()) {
    load();
  }

  Future<void> reset() async {
    final currentState = state;
    if (currentState is SettingsReady) {
      emit(currentState.copyWith(settings: const SettingsModel()));
    } else {
      emit(const SettingsReady(settings: SettingsModel()));
    }
    await SettingsLogic.set(settings: const SettingsModel());
  }

  Future<SettingsModel> load() async {
    SettingsModel settings;
    try {
      settings = await SettingsLogic.load();
    } catch (e) {
      settings = const SettingsModel();
    }

    final currentState = SettingsReady(settings: settings);
    emit(currentState);
    settings = currentState.settings.copyWith();
    var enabled = settings.enabledFunctionalities;
    var disabled = settings.disabledFunctionalities;

    final unclassifiedFunctionalities =
        Functionalities.values.where((e) => !(enabled + disabled).contains(e));

    enabled.addAll(unclassifiedFunctionalities
        .where((element) => defaultEnabledFunctionalities.contains(element)));
    disabled.addAll(unclassifiedFunctionalities
        .where((element) => defaultDisabledFunctionalities.contains(element)));

    if (currentState.settings != settings) {
      emit(currentState.copyWith(settings: settings));
    }

    // disable notification worker if none of the functionalities are enabled
    if (!(settings.calendarUpdateNotification &&
        settings.newMailNotification &&
        settings.newGradeNotification)) {
      if ((!kIsWeb && (Platform.isAndroid || Platform.isIOS)) &&
          !Platform.environment.containsKey('FLUTTER_TEST')) {
        Workmanager().cancelByUniqueName("updateChecking");
      }
    }
    return settings;
  }

  Future<void> modify({required SettingsModel settings}) async {
    await SettingsLogic.set(settings: settings);
    if (state is SettingsReady) {
      emit((state as SettingsReady).copyWith(settings: settings));
    } else {
      emit(SettingsReady(settings: settings));
    }
  }

  void resetCubit() async {
    emit(SettingsInitial());
  }

  Future<void> move(
      {required bool oldEnabled,
      required bool newEnabled,
      required int oldIndex,
      required int newIndex}) async {
    final currentState = state;
    if (currentState is! SettingsReady) return;

    final settings = currentState.settings;

    // Disable an item (move from enabled to disabled)
    if (oldEnabled && !newEnabled) {
      final item = settings.enabledFunctionalities[oldIndex];
      if (item != Functionalities.settings) {
        final updatedSettings = switch (item) {
          Functionalities.agenda =>
            settings.copyWith(calendarUpdateNotification: false),
          Functionalities.mail => settings.copyWith(newMailNotification: false),
          Functionalities.tomuss =>
            settings.copyWith(newGradeNotification: false),
          _ => settings
        };

        modify(
          settings: updatedSettings.copyWith(
            enabledFunctionalities: updatedSettings.enabledFunctionalities
                .where((element) => element != item)
                .toList(),
            disabledFunctionalities: [
              ...updatedSettings.disabledFunctionalities
            ]..insert(newIndex, item),
          ),
        );
      }
    }

    // enable an item (move from disabled to enabled)
    else if (!oldEnabled && newEnabled) {
      final item = settings.disabledFunctionalities[oldIndex];
      modify(
        settings: settings.copyWith(
          disabledFunctionalities: settings.disabledFunctionalities
              .where((element) => element != item)
              .toList(),
          enabledFunctionalities: [...settings.enabledFunctionalities]
            ..insert(newIndex, item),
        ),
      );
    }

    // reorder in the same category (enabled or disabled)
    else {
      final sourceList = oldEnabled
          ? settings.enabledFunctionalities
          : settings.disabledFunctionalities;

      if (!oldEnabled &&
          settings.enabledFunctionalities[oldIndex] ==
              Functionalities.settings) {
        return;
      }

      final item = sourceList[oldIndex];
      final updatedList = [...sourceList]
        ..removeAt(oldIndex)
        ..insert(newIndex, item);

      modify(
        settings: settings.copyWith(
          enabledFunctionalities:
              oldEnabled ? updatedList : settings.enabledFunctionalities,
          disabledFunctionalities:
              !oldEnabled ? updatedList : settings.disabledFunctionalities,
        ),
      );
    }
  }

  void collapseAll() {
    final currentState = state;
    if (currentState is SettingsReady) {
      emit(currentState.copyWith(collapseAll: !currentState.collapseAll));
    } else {
      throw Exception("State is not SettingsReady");
    }
  }

  SettingsReady getReady() {
    final currentState = state;
    if (currentState is SettingsReady) {
      return currentState;
    } else {
      throw Exception("State is not SettingsReady");
    }
  }

  SettingsModel get settings {
    return getReady().settings;
  }
}
