import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/settings/settings_export.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState()) {
    init();
  }

  /// This function initilize the Hive of ThemeUserData and load the themes selected.
  Future<void> init() async {
    emit(state.copyWith(status: ThemeStateStatus.init));
    ThemeSettingsModel themesUserData;

    if (await CacheService.exist<ThemeSettingsModel>()) {
      themesUserData = (await CacheService.get<ThemeSettingsModel>())!;
    } else {
      themesUserData = ThemeSettingsModel();
      await CacheService.set<ThemeSettingsModel>(themesUserData);
    }

    emit(state.copyWith(
        status: ThemeStateStatus.loaded, themesSettings: themesUserData));
  }

  /// Add a new theme to the themesCreated list in the Hive.
  Future<void> newTheme(ThemeModel themeCreated) async {
    if (state.themesSettings!.themesCreated.contains(themeCreated)) {
      return Future.error("The theme [${themeCreated.name}] already exist !");
    }

    if (kDebugMode) {
      Res.logger.i("Theme builded: ${themeCreated.name}");
    }

    ThemeSettingsModel themesUserData = state.themesSettings!.copyWith(
        themesCreated: state.themesSettings!.themesCreated..add(themeCreated));

    await CacheService.set<ThemeSettingsModel>(themesUserData);
    emit(state.copyWith(themesSettings: themesUserData));
  }

  /// Delete a theme from the themesCreated list in the Hive.
  ///
  /// The theme must be a String, a ThemeData or a ThemeInfo type.
  Future<void> deleteTheme(final ThemeModel theme) async {
    if (!state.themesSettings!.themesCreated.contains(theme)) {
      return Future.error("The theme [$theme] doesn't exist !");
    }

    ThemeSettingsModel themesUserData = state.themesSettings!.copyWith(
        themesCreated: state.themesSettings!.themesCreated..remove(theme));
    await CacheService.set<ThemeSettingsModel>(themesUserData);
    emit(state.copyWith(themesSettings: themesUserData));
  }

  /// Change the theme selected in the Hive at darkThemeSelected or lightThemeSelected.
  Future<void> chooseTheme(ThemeModel theme) async {
    late ThemeSettingsModel updatedUserData;
    if (theme.theme.brightness == Brightness.dark) {
      updatedUserData =
          state.themesSettings!.copyWith(darkThemeSelected: theme.name);
    } else {
      updatedUserData =
          state.themesSettings!.copyWith(lightThemeSelected: theme.name);
    }
    await CacheService.set<ThemeSettingsModel>(updatedUserData);
    emit(state.copyWith(
        themesSettings: updatedUserData, status: ThemeStateStatus.updated));
  }

  /// Add the theme in the Hive at the favoriteThemes list.
  /// If the theme is already in the list, remove it from the list.
  void toggleThemeFavorite(ThemeModel theme) async {
    int index = state.themesSettings!.favoriteThemes
        .indexWhere((element) => element.name == theme.name);
    ThemeSettingsModel themesUserData;
    if (index != -1) {
      themesUserData = state.themesSettings!.copyWith(
          favoriteThemes: state.themesSettings!.favoriteThemes.toList()
            ..removeAt(index));
    } else {
      themesUserData = state.themesSettings!.copyWith(
          favoriteThemes: state.themesSettings!.favoriteThemes.toList()
            ..add(theme));
    }
    await CacheService.set<ThemeSettingsModel>(themesUserData);
    emit(state.copyWith(themesSettings: themesUserData));
  }

  void updateThemeMode(ThemeModeEnum themeMode) async {
    final updatedUserData =
        state.themesSettings!.copyWith(themeMode: themeMode);
    await CacheService.set<ThemeSettingsModel>(updatedUserData);
    emit(state.copyWith(
        themesSettings: updatedUserData, status: ThemeStateStatus.updated));
  }

  void updateAutoSwitchTheme(bool autoSwitchTheme) async {
    final updatedUserData =
        state.themesSettings!.copyWith(autoSwitchTheme: autoSwitchTheme);
    await CacheService.set<ThemeSettingsModel>(updatedUserData);
    emit(state.copyWith(
        themesSettings: updatedUserData, status: ThemeStateStatus.updated));
  }

  void toggleThemeMode() {
    if (state.themesSettings!.themeMode == ThemeModeEnum.dark) {
      emit(state.copyWith(themeMode: ThemeMode.light));
    } else if (state.themesSettings!.themeMode == ThemeModeEnum.light) {
      emit(state.copyWith(themeMode: ThemeMode.dark));
    }
  }
}
