import 'dart:convert';
import 'dart:ui';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/core/theme/theme.dart';
import 'package:onyx/screens/settings/settings_export.dart';
part 'generated/theme_settings_model.g.dart';

@HiveType(typeId: 42)
class ThemeSettingsModel {
  List<ThemeModel> themesCreated;
  @HiveField(1)
  late final String darkThemeSelected;
  @HiveField(2)
  late final String lightThemeSelected;
  List<ThemeModel> favoriteThemes;
  @HiveField(4)
  final ThemeModeEnum themeMode;
  @HiveField(5)
  final bool autoSwitchTheme;
  List<ThemeModel> themesPreset =
      OnyxTheme.themesPreset; //do not save it in hive

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

  copyWith({
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

  @HiveField(0)
  String get themesCreatedString =>
      jsonEncode(themesCreated.map((e) => e.toJson()).toList());

  @HiveField(3)
  String get favoriteThemesString =>
      jsonEncode(favoriteThemes.map((e) => e.toJson()).toList());
}
