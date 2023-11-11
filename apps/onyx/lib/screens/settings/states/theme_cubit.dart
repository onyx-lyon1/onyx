import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/screens/settings/settings_export.dart';

part 'theme_state.dart';

List<ThemeInfo> themesCreated = [];

class ThemeCubit extends Cubit<ThemeState> {
  late ThemesUserData themesUserData;
  List<ThemeInfo> themesPreset;

  ThemeCubit(this.themesPreset) : super(const ThemeState()) {
    _initializeThemes();
  }

  Future<void> _initializeThemes() async {
    if (!Hive.isAdapterRegistered(ThemesUserDataAdapter().typeId)) {
      Hive.registerAdapter(ThemesUserDataAdapter());
    }

    Box box = await Hive.openBox('themesUserData');

    if (box.containsKey('data')) {
      themesUserData = box.get('data');
    } else {
      themesUserData = ThemesUserData();
      await box.put('data', themesUserData);
    }

    await loadTheme(themesUserData.lightThemeSelected);
    await loadTheme(themesUserData.darkThemeSelected);
  }

  Future<void> loadTheme(final theme) async {
    ThemeData themeSelected;
    if (theme is String) {
      int indexThemesCreated = await searchIndexTheme(theme, themesCreated);
      int indexThemesPreset = await searchIndexTheme(theme, themesPreset);
      if (indexThemesCreated != -1) {
        themeSelected = themesCreated[indexThemesCreated].theme;
      } else if (indexThemesPreset != -1) {
        themeSelected = themesPreset[indexThemesPreset].theme;
      } else {
        return Future.error("The theme [$theme] doesn't exist !");
      }
    } else if (theme is ThemeData) {
      themeSelected = theme;
    } else if (theme is ThemeInfo) {
      themeSelected = theme.theme;
    } else {
      return Future.error("Wrong type entered at loading a theme !");
    }

    //Set the theme depending of the brightness
    themeSelected.brightness == Brightness.dark
        ? emit(state.copyWith(darkTheme: themeSelected))
        : emit(state.copyWith(lightTheme: themeSelected));

    toggleThemeMode();
  }

  Future<List<Color>> extractThemeColor(ThemeData theme) async {
    Color fontColor = theme.textTheme.labelLarge?.color ?? Colors.black;
    return [fontColor, theme.cardColor, theme.colorScheme.primary];
  }

  Future<void> newTheme(ThemeInfo themeCreated) async {
    if (await searchIndexTheme(themeCreated.name, themesCreated) != -1) {
      return Future.error("The theme [${themeCreated.name}] already exist !");
    }

    if (kDebugMode) {
      print("Theme builded: ${themeCreated.name}");
    }
    themesCreated.add(themeCreated);
  }

  Future<void> deleteTheme(final theme) async {
    Box box = await Hive.openBox('themesUserData');
    int index = await searchIndexTheme(
        theme, listJsonToThemeInfo(themesUserData.themesCreated, -1));
    if (index == -1) {
      if (theme is String) {
        return Future.error("The theme [$theme] doesn't exist !");
      } else if (theme is ThemeInfo) {
        return Future.error("The theme [${theme.name}] doesn't exist !");
      } else {
        return Future.error("The theme doesn't exist !");
      }
    }
    themesUserData.themesCreated.removeAt(index);
    await box.put('data', themesUserData);
  }

  Future<int> searchThemeInJsonList(
      ThemeInfo theme, List<Map<String, dynamic>> jsonList) async {
    int index = 0;
    for (Map<String, dynamic> json in jsonList) {
      if (json['name'] == theme.name) {
        return index;
      }
      index++;
    }
    return -1;
  }

  Future<int> searchIndexTheme(final theme, List<ThemeInfo> themesList) async {
    if (theme is String) {
      int index = 0;
      for (ThemeInfo themeFromList in themesList) {
        if (themeFromList.name == theme) {
          return index;
        }
        index++;
      }
      return -1;
    } else if (theme is ThemeData) {
      int index = 0;
      for (ThemeInfo themeFromList in themesList) {
        if (themeFromList.theme == theme) {
          return index;
        }
        index++;
      }
      return -1;
    } else if (theme is ThemeInfo) {
      int index = 0;
      for (ThemeInfo themeFromList in themesList) {
        if (themeFromList == theme) {
          return index;
        }
        index++;
      }
      return -1;
    } else {
      return Future.error("Wrong type entered at searching a index !");
    }
  }

  void setChangeAutoTheme(bool value) async {
    Box box = await Hive.openBox('themesUserData');
    themesUserData.changeAutoTheme = value;
    await box.put('data', themesUserData);
  }

  void setThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  void toggleThemeMode() {
    if (state.themeMode == ThemeMode.dark) {
      setThemeMode(ThemeMode.light);
    } else if (state.themeMode == ThemeMode.dark) {
      setThemeMode(ThemeMode.dark);
    }
  }
}
