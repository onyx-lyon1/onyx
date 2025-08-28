// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../url.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$URLCWProxy {
  URL title(String title);

  URL author(String author);

  URL date(DateTime? date);

  URL position(double position);

  URL value(String value);

  URL isModifiable(bool isModifiable);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `URL(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// URL(...).copyWith(id: 12, name: "My name")
  /// ```
  URL call({
    String title,
    String author,
    DateTime? date,
    double position,
    String value,
    bool isModifiable,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfURL.copyWith(...)` or call `instanceOfURL.copyWith.fieldName(value)` for a single field.
class _$URLCWProxyImpl implements _$URLCWProxy {
  const _$URLCWProxyImpl(this._value);

  final URL _value;

  @override
  URL title(String title) => call(title: title);

  @override
  URL author(String author) => call(author: author);

  @override
  URL date(DateTime? date) => call(date: date);

  @override
  URL position(double position) => call(position: position);

  @override
  URL value(String value) => call(value: value);

  @override
  URL isModifiable(bool isModifiable) => call(isModifiable: isModifiable);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `URL(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// URL(...).copyWith(id: 12, name: "My name")
  /// ```
  URL call({
    Object? title = const $CopyWithPlaceholder(),
    Object? author = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? isModifiable = const $CopyWithPlaceholder(),
  }) {
    return URL(
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      author: author == const $CopyWithPlaceholder() || author == null
          ? _value.author
          // ignore: cast_nullable_to_non_nullable
          : author as String,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime?,
      position: position == const $CopyWithPlaceholder() || position == null
          ? _value.position
          // ignore: cast_nullable_to_non_nullable
          : position as double,
      value: value == const $CopyWithPlaceholder() || value == null
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String,
      isModifiable:
          isModifiable == const $CopyWithPlaceholder() || isModifiable == null
              ? _value.isModifiable
              // ignore: cast_nullable_to_non_nullable
              : isModifiable as bool,
    );
  }
}

extension $URLCopyWith on URL {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfURL.copyWith(...)` or `instanceOfURL.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$URLCWProxy get copyWith => _$URLCWProxyImpl(this);
}
