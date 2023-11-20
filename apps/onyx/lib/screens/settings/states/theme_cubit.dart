import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/screens/settings/settings_export.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  late Box box;
  late ThemesUserData themesUserData;
  late List<ThemeInfo> themesCreated;
  List<ThemeInfo> themesPreset;

  ThemeCubit(this.themesPreset) : super(const ThemeState()) {
    _initializeThemes();
  }

  /// This function initilize the Hive of ThemeUserData and load the themes selected.
  Future<void> _initializeThemes() async {
    if (!Hive.isAdapterRegistered(ThemesUserDataAdapter().typeId)) {
      Hive.registerAdapter(ThemesUserDataAdapter());
    }

    box = await Hive.openBox('themesUserData');

    if (box.containsKey('data')) {
      themesUserData = box.get('data');
    } else {
      themesUserData = const ThemesUserData();
      await box.put('data', themesUserData);
    }

    themesCreated = listJsonToThemeInfo(themesUserData.themesCreated);

    await loadTheme(themesUserData.lightThemeSelected);
    await loadTheme(themesUserData.darkThemeSelected);

    emit(state.copyWith(
        status: ThemeStateStatus.loaded, themesUserData: themesUserData));
  }

  /// Load the theme from the input.
  ///
  /// The theme must be a String, a ThemeData or a ThemeInfo type.
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

  /// Return a list of the main colors of a theme : The font, the background and the button.
  Future<List<Color>> extractThemeColor(ThemeData theme) async {
    Color fontColor = theme.textTheme.labelLarge!.color!;
    return [fontColor, theme.cardColor, theme.colorScheme.primary];
  }

  /// Add a new theme to the themesCreated list in the Hive.
  Future<void> newTheme(ThemeInfo themeCreated) async {
    if (await searchIndexTheme(
            themeCreated.name, state.themesUserData!.themesCreated) !=
        -1) {
      return Future.error("The theme [${themeCreated.name}] already exist !");
    }

    if (kDebugMode) {
      print("Theme builded: ${themeCreated.name}");
    }

    themesUserData.themesCreated.add(themeInfoToJson(themeCreated));

    final updatedUserData = themesUserData.copyWith();
    await box.put('data', updatedUserData);
    emit(state.copyWith(themesUserData: updatedUserData));
  }

  /// Delete a theme from the themesCreated list in the Hive.
  ///
  /// The theme must be a String, a ThemeData or a ThemeInfo type.
  Future<void> deleteTheme(final theme) async {
    int index = await searchIndexTheme(theme, themesCreated);
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
    final updatedUserData = themesUserData.copyWith();
    await box.put('data', updatedUserData);
    emit(state.copyWith(themesUserData: updatedUserData));
  }

  /// Part of searchIndexTheme.
  int searchThemeInJsonList(String theme, List<Map<String, dynamic>> jsonList) {
    int index = 0;
    for (Map<String, dynamic> json in jsonList) {
      if (json['name'] == theme) {
        return index;
      }
      index++;
    }
    return -1;
  }

  /// Part of searchIndexTheme.
  Future<int> searchThemeInThemeInfo(
      final theme, List<ThemeInfo> themesList) async {
    int index = 0;
    if (theme is String) {
      int index = 0;
      for (ThemeInfo themeFromList in themesList) {
        if (themeFromList.name == theme) {
          return index;
        }
        index++;
      }
    } else if (theme is ThemeData) {
      for (ThemeInfo themeFromList in themesList) {
        if (themeFromList.theme == theme) {
          return index;
        }
        index++;
      }
    } else if (theme is ThemeInfo) {
      for (ThemeInfo themeFromList in themesList) {
        if (themeFromList == theme) {
          return index;
        }
        index++;
      }
    } else {
      return Future.error("Wrong type entered at searching a index !");
    }
    return -1;
  }

  /// Return the index of the theme in the themesList. If the theme isn't in the list, the function return -1.
  ///
  /// The theme must be a String, a ThemeData or a ThemeInfo type.
  ///
  /// The themesList must be a list of ThemeInfo or Json.
  Future<int> searchIndexTheme(final theme, final themesList) async {
    if (themesList is List<ThemeInfo>) {
      return searchThemeInThemeInfo(theme, themesList);
    } else if (themesList is List<Map<String, dynamic>>) {
      return searchThemeInJsonList(theme, themesList);
    }
    return Future.error("Wrong type entered at searching an index !");
  }

  /// Change the theme selected in the Hive at darkThemeSelected or lightThemeSelected.
  void saveChangeTheme(ThemeInfo theme) async {
    late ThemesUserData updatedUserData;
    if (theme.theme.brightness == Brightness.dark) {
      updatedUserData = themesUserData.copyWith(darkThemeSelected: theme.name);
    } else {
      updatedUserData = themesUserData.copyWith(lightThemeSelected: theme.name);
    }
    themesUserData = updatedUserData;
    await box.put('data', updatedUserData);
    emit(state.copyWith(themesUserData: updatedUserData));
  }

  /// Add the theme in the Hive at the favoriteThemes list.
  /// If the theme is already in the list, remove it from the list.
  void setThemeFavorite(BuildContext context, ThemeInfo theme) async {
    int index = await context
        .read<ThemeCubit>()
        .searchIndexTheme(theme.name, themesUserData.favoriteThemes);
    if (kDebugMode) {
      print(index);
    }
    if (index != -1) {
      themesUserData.favoriteThemes.removeAt(index);
    } else {
      themesUserData.favoriteThemes.add(themeInfoToJson(theme));
    }
    final updatedUserData = themesUserData.copyWith();

    await box.put('data', updatedUserData);
    emit(state.copyWith(themesUserData: updatedUserData));
  }

  void setChangeAutoTheme(bool value) async {
    final updatedUserData = themesUserData.copyWith(changeAutoTheme: value);
    themesUserData = updatedUserData;
    await box.put('data', themesUserData);
    emit(state.copyWith(themesUserData: updatedUserData));
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
