import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'theme_mode_enum.mapper.dart';

@MappableEnum()
enum ThemeModeEnum {
  @MappableValue(000)
  system,
  @MappableValue(100)
  dark,
  @MappableValue(200)
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
