import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/core/theme/theme_export.dart';
import 'package:json_theme/json_theme.dart';

part 'generated/theme_mode_enum.g.dart';

@HiveType(typeId: 8)
enum ThemeModeEnum {
  @HiveField(0)
  system,
  @HiveField(1)
  dark,
  @HiveField(2)
  light,
}

extension ThemeModeEnumExtension on ThemeModeEnum {
  ThemeMode get themeMode {
    switch (this) {
      case ThemeModeEnum.system:
        return ThemeMode.system;
      case ThemeModeEnum.light:
        return ThemeMode.light;
      case ThemeModeEnum.dark:
        return ThemeMode.dark;
    }
  }
}

@HiveType(typeId: 42)
class ThemesUserData {
  @HiveField(0)
  List<Map<String, dynamic>> themesCreated;
  @HiveField(1)
  String darkThemeSelected;
  @HiveField(2)
  String lightThemeSelected;
  @HiveField(3)
  List<Map<String, dynamic>> favoriteThemes;
  @HiveField(4)
  bool changeAutoTheme;

  ThemesUserData()
      : themesCreated = [
          themeInfoToJson(ThemeInfo('Dark Test', OnyxTheme().darkTheme)),
        ],
        darkThemeSelected = 'Dark Default',
        lightThemeSelected = 'Light Default',
        favoriteThemes = [],
        changeAutoTheme = true;
}

class ThemeInfo {
  final String name;
  final ThemeData theme;

  ThemeInfo(
    this.name,
    this.theme,
  );

  ThemeInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        theme = ThemeDecoder.decodeThemeData(['theme']) ?? ThemeData();

  Map<String, dynamic> toJson() => {
        'name': name,
        'theme': ThemeEncoder.encodeThemeData(theme),
      };
}

/// Transform a Json type to a ThemeInfo type and return it. If the json is not a theme, return a default theme.
ThemeInfo jsonToThemeInfo(Map<String, dynamic> json) {
  return ThemeInfo(json['name'] as String,
      ThemeDecoder.decodeThemeData(json['theme']) ?? ThemeData());
}

/// Transform a ThemeInfo type to a Json type and return it.
Map<String, dynamic> themeInfoToJson(ThemeInfo theme) {
  return {
    'name': theme.name,
    'theme': ThemeEncoder.encodeThemeData(theme.theme),
  };
}

/// Transform a Json list to a ThemeInfo list and return it.
List<ThemeInfo> listJsonToThemeInfo(List<Map<String, dynamic>> jsonList) {
  List<ThemeInfo> themeList = [];
  for (Map<String, dynamic> json in jsonList) {
    themeList.add(jsonToThemeInfo(json));
  }
  return themeList;
}
