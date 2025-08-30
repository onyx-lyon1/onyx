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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RestaurantModel(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RestaurantModel(...).copyWith(id: 12, name: "My name")
  /// ```
  RestaurantModel call({
    int id,
    String name,
    String description,
    String shortDescription,
    CrousType type,
    double lat,
    double lon,
    String opening,
    List<MenuCrous> menus,
    String imageUrl,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRestaurantModel.copyWith(...)` or call `instanceOfRestaurantModel.copyWith.fieldName(value)` for a single field.
class _$RestaurantModelCWProxyImpl implements _$RestaurantModelCWProxy {
  const _$RestaurantModelCWProxyImpl(this._value);

  final RestaurantModel _value;

  @override
  RestaurantModel id(int id) => call(id: id);

  @override
  RestaurantModel name(String name) => call(name: name);

  @override
  RestaurantModel description(String description) =>
      call(description: description);

  @override
  RestaurantModel shortDescription(String shortDescription) =>
      call(shortDescription: shortDescription);

  @override
  RestaurantModel type(CrousType type) => call(type: type);

  @override
  RestaurantModel lat(double lat) => call(lat: lat);

  @override
  RestaurantModel lon(double lon) => call(lon: lon);

  @override
  RestaurantModel opening(String opening) => call(opening: opening);

  @override
  RestaurantModel menus(List<MenuCrous> menus) => call(menus: menus);

  @override
  RestaurantModel imageUrl(String imageUrl) => call(imageUrl: imageUrl);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RestaurantModel(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RestaurantModel(...).copyWith(id: 12, name: "My name")
  /// ```
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
      shortDescription:
          shortDescription == const $CopyWithPlaceholder() ||
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRestaurantModel.copyWith(...)` or `instanceOfRestaurantModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RestaurantModelCWProxy get copyWith => _$RestaurantModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) =>
    RestaurantModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      shortDescription: json['shortDescription'] as String,
      type: $enumDecode(_$CrousTypeEnumMap, json['type']),
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      opening: json['opening'] as String,
      menus: (json['menus'] as List<dynamic>)
          .map((e) => MenuCrous.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$RestaurantModelToJson(RestaurantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'type': _$CrousTypeEnumMap[instance.type]!,
      'lat': instance.lat,
      'lon': instance.lon,
      'opening': instance.opening,
      'menus': instance.menus,
      'imageUrl': instance.imageUrl,
    };

const _$CrousTypeEnumMap = {
  CrousType.restaurant: 'restaurant',
  CrousType.cafet: 'cafet',
};
