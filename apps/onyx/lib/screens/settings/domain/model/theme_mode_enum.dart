import 'package:flutter/material.dart';

enum ThemeModeEnum {
  system,
  dark,
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
