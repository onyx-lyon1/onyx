// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../student.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StudentCWProxy {
  Student year(Year year);

  Student name(String name);

  Student id(int id);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Student(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Student(...).copyWith(id: 12, name: "My name")
  /// ```
  Student call({
    Year year,
    String name,
    int id,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStudent.copyWith(...)` or call `instanceOfStudent.copyWith.fieldName(value)` for a single field.
class _$StudentCWProxyImpl implements _$StudentCWProxy {
  const _$StudentCWProxyImpl(this._value);

  final Student _value;

  @override
  Student year(Year year) => call(year: year);

  @override
  Student name(String name) => call(name: name);

  @override
  Student id(int id) => call(id: id);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Student(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Student(...).copyWith(id: 12, name: "My name")
  /// ```
  Student call({
    Object? year = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
  }) {
    return Student(
      year == const $CopyWithPlaceholder()
          ? _value.year
          // ignore: cast_nullable_to_non_nullable
          : year as Year,
      name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
    );
  }
}

extension $StudentCopyWith on Student {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStudent.copyWith(...)` or `instanceOfStudent.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StudentCWProxy get copyWith => _$StudentCWProxyImpl(this);
}
