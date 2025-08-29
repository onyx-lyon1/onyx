import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:onyx/core/theme/theme.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class ThemeSettingsModel {
  late List<ThemeModel> _themesCreated;
  late final String darkThemeSelected;
  late final String lightThemeSelected;
  late List<ThemeModel> _favoriteThemes;
  final ThemeModeEnum themeMode;
  final bool autoSwitchTheme;
  final List<ThemeModel> _themesPreset =
      OnyxTheme.themesPreset; //do not save it in hive_ce

  ThemeSettingsModel({
    List<ThemeModel> themesCreated = const [],
    this.darkThemeSelected = 'Dark Default',
    this.lightThemeSelected = 'Light Default',
    List<ThemeModel> favoriteThemes = const [],
    this.themeMode = ThemeModeEnum.system,
    this.autoSwitchTheme = true,
    String? themesCreatedString,
    String? favoriteThemesString,
  }) {
    _themesCreated = themesCreated;
    _favoriteThemes = favoriteThemes;
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

  List<ThemeModel> get lightThemesPreset => _themesPreset
      .where((themeInfo) => themeInfo.theme.brightness == Brightness.light)
      .toList();

  List<ThemeModel> get darkThemesPreset => _themesPreset
      .where((themeInfo) => themeInfo.theme.brightness == Brightness.dark)
      .toList();

  List<ThemeModel> get themesCreated => _themesCreated;

  set themesCreated(List<ThemeModel> value) {
    _themesCreated = value;
  }

  List<ThemeModel> get favoriteThemes => _favoriteThemes;

  set favoriteThemes(List<ThemeModel> value) {
    _favoriteThemes = value;
  }

  List<ThemeModel> get themesPreset => _themesPreset;

  String get themesCreatedString =>
      jsonEncode(themesCreated.map((e) => e.toJson()).toList());

  String get favoriteThemesString =>
      jsonEncode(favoriteThemes.map((e) => e.toJson()).toList());
}
