// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../menu_crous.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MenuCrousCWProxy {
  MenuCrous date(DateTime date);

  MenuCrous type(MenuType type);

  MenuCrous plats(List<PlatCrous> plats);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MenuCrous(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MenuCrous(...).copyWith(id: 12, name: "My name")
  /// ```
  MenuCrous call({
    DateTime date,
    MenuType type,
    List<PlatCrous> plats,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMenuCrous.copyWith(...)` or call `instanceOfMenuCrous.copyWith.fieldName(value)` for a single field.
class _$MenuCrousCWProxyImpl implements _$MenuCrousCWProxy {
  const _$MenuCrousCWProxyImpl(this._value);

  final MenuCrous _value;

  @override
  MenuCrous date(DateTime date) => call(date: date);

  @override
  MenuCrous type(MenuType type) => call(type: type);

  @override
  MenuCrous plats(List<PlatCrous> plats) => call(plats: plats);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MenuCrous(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MenuCrous(...).copyWith(id: 12, name: "My name")
  /// ```
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMenuCrous.copyWith(...)` or `instanceOfMenuCrous.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MenuCrousCWProxy get copyWith => _$MenuCrousCWProxyImpl(this);
}

abstract class _$PlatCrousCWProxy {
  PlatCrous name(String name);

  PlatCrous variants(List<String> variants);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PlatCrous(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PlatCrous(...).copyWith(id: 12, name: "My name")
  /// ```
  PlatCrous call({
    String name,
    List<String> variants,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPlatCrous.copyWith(...)` or call `instanceOfPlatCrous.copyWith.fieldName(value)` for a single field.
class _$PlatCrousCWProxyImpl implements _$PlatCrousCWProxy {
  const _$PlatCrousCWProxyImpl(this._value);

  final PlatCrous _value;

  @override
  PlatCrous name(String name) => call(name: name);

  @override
  PlatCrous variants(List<String> variants) => call(variants: variants);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PlatCrous(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PlatCrous(...).copyWith(id: 12, name: "My name")
  /// ```
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPlatCrous.copyWith(...)` or `instanceOfPlatCrous.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PlatCrousCWProxy get copyWith => _$PlatCrousCWProxyImpl(this);
}
