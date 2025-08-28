import 'dart:convert';
import 'dart:ui';

import 'package:onyx/core/theme/theme.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class ThemeSettingsModel {
  List<ThemeModel> themesCreated;
  late final String darkThemeSelected;
  late final String lightThemeSelected;
  List<ThemeModel> favoriteThemes;
  final ThemeModeEnum themeMode;
  final bool autoSwitchTheme;
  List<ThemeModel> themesPreset =
      OnyxTheme.themesPreset; //do not save it in hive_ce

  ThemeSettingsModel({
    this.themesCreated = const [],
    this.darkThemeSelected = 'Dark Default',
    this.lightThemeSelected = 'Light Default',
    this.favoriteThemes = const [],
    this.themeMode = ThemeModeEnum.system,
    this.autoSwitchTheme = true,
    String? themesCreatedString,
    String? favoriteThemesString,
  }) {
    if (themesCreatedString != null) {
      themesCreated = jsonDecode(themesCreatedString)
          .map((e) => ThemeModel.fromJson(e))
          .toList()
          .cast<ThemeModel>();
    }
    if (favoriteThemesString != null) {
      favoriteThemes = jsonDecode(favoriteThemesString)
          .map((e) => ThemeModel.fromJson(e))
          .toList()
          .cast<ThemeModel>();
    }
  }

  ThemeSettingsModel copyWith({
    List<ThemeModel>? themesCreated,
    String? darkThemeSelected,
    String? lightThemeSelected,
    List<ThemeModel>? favoriteThemes,
    ThemeModeEnum? themeMode,
    bool? autoSwitchTheme,
  }) {
    return ThemeSettingsModel(
      themesCreated: themesCreated ?? this.themesCreated,
      darkThemeSelected: darkThemeSelected ?? this.darkThemeSelected,
      lightThemeSelected: lightThemeSelected ?? this.lightThemeSelected,
      favoriteThemes: favoriteThemes ?? this.favoriteThemes,
      themeMode: themeMode ?? this.themeMode,
      autoSwitchTheme: autoSwitchTheme ?? this.autoSwitchTheme,
    );
  }

  List<ThemeModel> get lightThemesCreated => themesCreated
      .where((themeInfo) => themeInfo.theme.brightness == Brightness.light)
      .toList();

  List<ThemeModel> get darkThemesCreated => themesCreated
      .where((themeInfo) => themeInfo.theme.brightness == Brightness.dark)
      .toList();

  List<ThemeModel> get lightThemesPreset => themesPreset
      .where((themeInfo) => themeInfo.theme.brightness == Brightness.light)
      .toList();

  List<ThemeModel> get darkThemesPreset => themesPreset
      .where((themeInfo) => themeInfo.theme.brightness == Brightness.dark)
      .toList();

  String get themesCreatedString =>
      jsonEncode(themesCreated.map((e) => e.toJson()).toList());

  String get favoriteThemesString =>
      jsonEncode(favoriteThemes.map((e) => e.toJson()).toList());
}
