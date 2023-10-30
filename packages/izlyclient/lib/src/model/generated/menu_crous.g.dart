// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../menu_crous.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MenuCrousCWProxy {
  MenuCrous date(DateTime date);

  MenuCrous type(MenuType type);

  MenuCrous plats(List<PlatCrous> plats);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MenuCrous(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MenuCrous(...).copyWith(id: 12, name: "My name")
  /// ````
  MenuCrous call({
    DateTime? date,
    MenuType? type,
    List<PlatCrous>? plats,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMenuCrous.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMenuCrous.copyWith.fieldName(...)`
class _$MenuCrousCWProxyImpl implements _$MenuCrousCWProxy {
  const _$MenuCrousCWProxyImpl(this._value);

  final MenuCrous _value;

  @override
  MenuCrous date(DateTime date) => this(date: date);

  @override
  MenuCrous type(MenuType type) => this(type: type);

  @override
  MenuCrous plats(List<PlatCrous> plats) => this(plats: plats);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MenuCrous(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MenuCrous(...).copyWith(id: 12, name: "My name")
  /// ````
  MenuCrous call({
    Object? date = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? plats = const $CopyWithPlaceholder(),
  }) {
    return MenuCrous(
      date: date == const $CopyWithPlaceholder() || date == null
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as MenuType,
      plats: plats == const $CopyWithPlaceholder() || plats == null
          ? _value.plats
          // ignore: cast_nullable_to_non_nullable
          : plats as List<PlatCrous>,
    );
  }
}

extension $MenuCrousCopyWith on MenuCrous {
  /// Returns a callable class that can be used as follows: `instanceOfMenuCrous.copyWith(...)` or like so:`instanceOfMenuCrous.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MenuCrousCWProxy get copyWith => _$MenuCrousCWProxyImpl(this);
}

abstract class _$PlatCrousCWProxy {
  PlatCrous name(String name);

  PlatCrous variants(List<String> variants);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PlatCrous(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PlatCrous(...).copyWith(id: 12, name: "My name")
  /// ````
  PlatCrous call({
    String? name,
    List<String>? variants,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPlatCrous.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPlatCrous.copyWith.fieldName(...)`
class _$PlatCrousCWProxyImpl implements _$PlatCrousCWProxy {
  const _$PlatCrousCWProxyImpl(this._value);

  final PlatCrous _value;

  @override
  PlatCrous name(String name) => this(name: name);

  @override
  PlatCrous variants(List<String> variants) => this(variants: variants);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PlatCrous(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PlatCrous(...).copyWith(id: 12, name: "My name")
  /// ````
  PlatCrous call({
    Object? name = const $CopyWithPlaceholder(),
    Object? variants = const $CopyWithPlaceholder(),
  }) {
    return PlatCrous(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      variants: variants == const $CopyWithPlaceholder() || variants == null
          ? _value.variants
          // ignore: cast_nullable_to_non_nullable
          : variants as List<String>,
    );
  }
}

extension $PlatCrousCopyWith on PlatCrous {
  /// Returns a callable class that can be used as follows: `instanceOfPlatCrous.copyWith(...)` or like so:`instanceOfPlatCrous.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PlatCrousCWProxy get copyWith => _$PlatCrousCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MenuCrousAdapter extends TypeAdapter<MenuCrous> {
  @override
  final int typeId = 32;

  @override
  MenuCrous read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuCrous(
      date: fields[0] as DateTime,
      type: fields[1] as MenuType,
      plats: (fields[3] as List).cast<PlatCrous>(),
    );
  }

  @override
  void write(BinaryWriter writer, MenuCrous obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.plats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuCrousAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlatCrousAdapter extends TypeAdapter<PlatCrous> {
  @override
  final int typeId = 36;

  @override
  PlatCrous read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlatCrous(
      name: fields[0] as String,
      variants: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlatCrous obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.variants);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlatCrousAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MenuTypeAdapter extends TypeAdapter<MenuType> {
  @override
  final int typeId = 34;

  @override
  MenuType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MenuType.matin;
      case 1:
        return MenuType.midi;
      case 2:
        return MenuType.soir;
      default:
        return MenuType.matin;
    }
  }

  @override
  void write(BinaryWriter writer, MenuType obj) {
    switch (obj) {
      case MenuType.matin:
        writer.writeByte(0);
        break;
      case MenuType.midi:
        writer.writeByte(1);
        break;
      case MenuType.soir:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
