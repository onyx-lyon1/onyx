// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'res.dart';

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
      case 000:
        return Functionalities.tomuss;
      case 100:
        return Functionalities.agenda;
      case 200:
        return Functionalities.mail;
      case 300:
        return Functionalities.map;
      case 400:
        return Functionalities.izly;
      case 500:
        return Functionalities.settings;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Functionalities self) {
    switch (self) {
      case Functionalities.tomuss:
        return 000;
      case Functionalities.agenda:
        return 100;
      case Functionalities.mail:
        return 200;
      case Functionalities.map:
        return 300;
      case Functionalities.izly:
        return 400;
      case Functionalities.settings:
        return 500;
    }
  }
}

extension FunctionalitiesMapperExtension on Functionalities {
  dynamic toValue() {
    FunctionalitiesMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Functionalities>(this);
  }
}
