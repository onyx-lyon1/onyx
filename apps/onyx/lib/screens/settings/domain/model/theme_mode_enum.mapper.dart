// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'theme_mode_enum.dart';

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
      case 000:
        return ThemeModeEnum.system;
      case 100:
        return ThemeModeEnum.dark;
      case 200:
        return ThemeModeEnum.light;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ThemeModeEnum self) {
    switch (self) {
      case ThemeModeEnum.system:
        return 000;
      case ThemeModeEnum.dark:
        return 100;
      case ThemeModeEnum.light:
        return 200;
    }
  }
}

extension ThemeModeEnumMapperExtension on ThemeModeEnum {
  dynamic toValue() {
    ThemeModeEnumMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ThemeModeEnum>(this);
  }
}
