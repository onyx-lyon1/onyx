// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../theme_mode_enum.dart';

class ThemeModeEnumMapper extends EnumMapper<ThemeModeEnum> {
  ThemeModeEnumMapper._();

  static ThemeModeEnumMapper? _instance;
  static ThemeModeEnumMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ThemeModeEnumMapper._());
    }
    return _instance!;
  }

  static ThemeModeEnum fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ThemeModeEnum decode(dynamic value) {
    switch (value) {
      case r'system':
        return ThemeModeEnum.system;
      case r'dark':
        return ThemeModeEnum.dark;
      case r'light':
        return ThemeModeEnum.light;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ThemeModeEnum self) {
    switch (self) {
      case ThemeModeEnum.system:
        return r'system';
      case ThemeModeEnum.dark:
        return r'dark';
      case ThemeModeEnum.light:
        return r'light';
    }
  }
}

extension ThemeModeEnumMapperExtension on ThemeModeEnum {
  String toValue() {
    ThemeModeEnumMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ThemeModeEnum>(this) as String;
  }
}

