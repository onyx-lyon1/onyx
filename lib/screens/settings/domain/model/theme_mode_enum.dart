import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'theme_mode_enum.g.dart';

@HiveType(typeId: 13)
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
