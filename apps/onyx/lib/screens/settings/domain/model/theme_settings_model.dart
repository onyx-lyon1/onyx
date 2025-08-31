import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/cupertino.dart';
import 'package:onyx/core/theme/theme.dart';
import 'package:onyx/screens/settings/settings_export.dart';

part 'generated/theme_settings_model.mapper.dart';

@MappableClass(ignore: ["themesCreated", "favoriteThemes", "themesPreset"])
class ThemeSettingsModel with ThemeSettingsModelMappable {
  late List<ThemeModel> themesCreated;
  late final String darkThemeSelected;
  late final String lightThemeSelected;
  late List<ThemeModel> favoriteThemes;
  final ThemeModeEnum themeMode;
  final bool autoSwitchTheme;
  final List<ThemeModel> themesPreset =
      OnyxTheme.themesPreset;

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
      themesCreated = jsonDecode(
        themesCreatedString,
      ).map((e) => ThemeModel.fromJson(e)).toList().cast<ThemeModel>();
    }
    if (favoriteThemesString != null) {
      favoriteThemes = jsonDecode(
        favoriteThemesString,
      ).map((e) => ThemeModel.fromJson(e)).toList().cast<ThemeModel>();
    }
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
