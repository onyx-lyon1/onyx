// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../res.dart';

class FunctionalitiesMapper extends EnumMapper<Functionalities> {
  FunctionalitiesMapper._();

  static FunctionalitiesMapper? _instance;
  static FunctionalitiesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FunctionalitiesMapper._());
    }
    return _instance!;
  }

  static Functionalities fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Functionalities decode(dynamic value) {
    switch (value) {
      case r'tomuss':
        return Functionalities.tomuss;
      case r'agenda':
        return Functionalities.agenda;
      case r'mail':
        return Functionalities.mail;
      case r'map':
        return Functionalities.map;
      case r'izly':
        return Functionalities.izly;
      case r'settings':
        return Functionalities.settings;
      case r'examen':
        return Functionalities.examen;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Functionalities self) {
    switch (self) {
      case Functionalities.tomuss:
        return r'tomuss';
      case Functionalities.agenda:
        return r'agenda';
      case Functionalities.mail:
        return r'mail';
      case Functionalities.map:
        return r'map';
      case Functionalities.izly:
        return r'izly';
      case Functionalities.settings:
        return r'settings';
      case Functionalities.examen:
        return r'examen';
    }
  }
}

extension FunctionalitiesMapperExtension on Functionalities {
  String toValue() {
    FunctionalitiesMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Functionalities>(this) as String;
  }
}

