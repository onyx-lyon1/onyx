// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../restaurant.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RestaurantModelCWProxy {
  RestaurantModel id(int id);

  RestaurantModel name(String name);

  RestaurantModel description(String description);

  RestaurantModel shortDescription(String shortDescription);

  RestaurantModel type(CrousType type);

  RestaurantModel lat(double lat);

  RestaurantModel lon(double lon);

  RestaurantModel opening(String opening);

  RestaurantModel menus(List<MenuCrous> menus);

  RestaurantModel imageUrl(String imageUrl);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RestaurantModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RestaurantModel(...).copyWith(id: 12, name: "My name")
  /// ````
  RestaurantModel call({
    int? id,
    String? name,
    String? description,
    String? shortDescription,
    CrousType? type,
    double? lat,
    double? lon,
    String? opening,
    List<MenuCrous>? menus,
    String? imageUrl,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRestaurantModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRestaurantModel.copyWith.fieldName(...)`
class _$RestaurantModelCWProxyImpl implements _$RestaurantModelCWProxy {
  const _$RestaurantModelCWProxyImpl(this._value);

  final RestaurantModel _value;

  @override
  RestaurantModel id(int id) => this(id: id);

  @override
  RestaurantModel name(String name) => this(name: name);

  @override
  RestaurantModel description(String description) =>
      this(description: description);

  @override
  RestaurantModel shortDescription(String shortDescription) =>
      this(shortDescription: shortDescription);

  @override
  RestaurantModel type(CrousType type) => this(type: type);

  @override
  RestaurantModel lat(double lat) => this(lat: lat);

  @override
  RestaurantModel lon(double lon) => this(lon: lon);

  @override
  RestaurantModel opening(String opening) => this(opening: opening);

  @override
  RestaurantModel menus(List<MenuCrous> menus) => this(menus: menus);

  @override
  RestaurantModel imageUrl(String imageUrl) => this(imageUrl: imageUrl);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RestaurantModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RestaurantModel(...).copyWith(id: 12, name: "My name")
  /// ````
  RestaurantModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? shortDescription = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? lat = const $CopyWithPlaceholder(),
    Object? lon = const $CopyWithPlaceholder(),
    Object? opening = const $CopyWithPlaceholder(),
    Object? menus = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
  }) {
    return RestaurantModel(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      description:
          description == const $CopyWithPlaceholder() || description == null
              ? _value.description
              // ignore: cast_nullable_to_non_nullable
              : description as String,
      shortDescription: shortDescription == const $CopyWithPlaceholder() ||
              shortDescription == null
          ? _value.shortDescription
          // ignore: cast_nullable_to_non_nullable
          : shortDescription as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as CrousType,
      lat: lat == const $CopyWithPlaceholder() || lat == null
          ? _value.lat
          // ignore: cast_nullable_to_non_nullable
          : lat as double,
      lon: lon == const $CopyWithPlaceholder() || lon == null
          ? _value.lon
          // ignore: cast_nullable_to_non_nullable
          : lon as double,
      opening: opening == const $CopyWithPlaceholder() || opening == null
          ? _value.opening
          // ignore: cast_nullable_to_non_nullable
          : opening as String,
      menus: menus == const $CopyWithPlaceholder() || menus == null
          ? _value.menus
          // ignore: cast_nullable_to_non_nullable
          : menus as List<MenuCrous>,
      imageUrl: imageUrl == const $CopyWithPlaceholder() || imageUrl == null
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String,
    );
  }
}

extension $RestaurantModelCopyWith on RestaurantModel {
  /// Returns a callable class that can be used as follows: `instanceOfRestaurantModel.copyWith(...)` or like so:`instanceOfRestaurantModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RestaurantModelCWProxy get copyWith => _$RestaurantModelCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RestaurantModelAdapter extends TypeAdapter<RestaurantModel> {
  @override
  final int typeId = 33;

  @override
  RestaurantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RestaurantModel(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      shortDescription: fields[3] as String,
      type: fields[4] as CrousType,
      lat: fields[5] as double,
      lon: fields[6] as double,
      opening: fields[7] as String,
      menus: (fields[8] as List).cast<MenuCrous>(),
      imageUrl: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RestaurantModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.shortDescription)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.lat)
      ..writeByte(6)
      ..write(obj.lon)
      ..writeByte(7)
      ..write(obj.opening)
      ..writeByte(8)
      ..write(obj.menus)
      ..writeByte(9)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CrousTypeAdapter extends TypeAdapter<CrousType> {
  @override
  final int typeId = 38;

  @override
  CrousType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CrousType.restaurant;
      case 1:
        return CrousType.cafet;
      default:
        return CrousType.restaurant;
    }
  }

  @override
  void write(BinaryWriter writer, CrousType obj) {
    switch (obj) {
      case CrousType.restaurant:
        writer.writeByte(0);
        break;
      case CrousType.cafet:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CrousTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
