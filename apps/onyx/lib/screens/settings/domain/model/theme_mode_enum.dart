import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

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
  ThemeMode get toThemeMode {
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

extension BrightnessExtension on Brightness {
  ThemeModeEnum get toThemeModeEnum {
    switch (this) {
      case Brightness.light:
        return ThemeModeEnum.light;
      case Brightness.dark:
        return ThemeModeEnum.dark;
    }
  }
}
