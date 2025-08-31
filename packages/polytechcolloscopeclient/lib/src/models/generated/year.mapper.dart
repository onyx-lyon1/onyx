// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../year.dart';

class YearMapper extends EnumMapper<Year> {
  YearMapper._();

  static YearMapper? _instance;
  static YearMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = YearMapper._());
    }
    return _instance!;
  }

  static Year fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Year decode(dynamic value) {
    switch (value) {
      case r'first':
        return Year.first;
      case r'second':
        return Year.second;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Year self) {
    switch (self) {
      case Year.first:
        return r'first';
      case Year.second:
        return r'second';
    }
  }
}

extension YearMapperExtension on Year {
  String toValue() {
    YearMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Year>(this) as String;
  }
}

