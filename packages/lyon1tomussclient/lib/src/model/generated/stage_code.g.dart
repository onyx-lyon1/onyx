// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../stage_code.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StageCodeCWProxy {
  StageCode title(String title);

  StageCode author(String author);

  StageCode date(DateTime? date);

  StageCode position(double position);

  StageCode value(String value);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `StageCode(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StageCode(...).copyWith(id: 12, name: "My name")
  /// ```
  StageCode call({
    String title,
    String author,
    DateTime? date,
    double position,
    String value,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStageCode.copyWith(...)` or call `instanceOfStageCode.copyWith.fieldName(value)` for a single field.
class _$StageCodeCWProxyImpl implements _$StageCodeCWProxy {
  const _$StageCodeCWProxyImpl(this._value);

  final StageCode _value;

  @override
  StageCode title(String title) => call(title: title);

  @override
  StageCode author(String author) => call(author: author);

  @override
  StageCode date(DateTime? date) => call(date: date);

  @override
  StageCode position(double position) => call(position: position);

  @override
  StageCode value(String value) => call(value: value);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `StageCode(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StageCode(...).copyWith(id: 12, name: "My name")
  /// ```
  StageCode call({
    Object? title = const $CopyWithPlaceholder(),
    Object? author = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return StageCode(
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      author: author == const $CopyWithPlaceholder()
          ? _value.author
          // ignore: cast_nullable_to_non_nullable
          : author as String,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime?,
      position: position == const $CopyWithPlaceholder()
          ? _value.position
          // ignore: cast_nullable_to_non_nullable
          : position as double,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String,
    );
  }
}

extension $StageCodeCopyWith on StageCode {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStageCode.copyWith(...)` or `instanceOfStageCode.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StageCodeCWProxy get copyWith => _$StageCodeCWProxyImpl(this);
}
