// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../student.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StudentCWProxy {
  Student name(String name);

  Student surname(String surname);

  Student email(String email);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Student(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Student(...).copyWith(id: 12, name: "My name")
  /// ```
  Student call({
    String name,
    String surname,
    String email,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStudent.copyWith(...)` or call `instanceOfStudent.copyWith.fieldName(value)` for a single field.
class _$StudentCWProxyImpl implements _$StudentCWProxy {
  const _$StudentCWProxyImpl(this._value);

  final Student _value;

  @override
  Student name(String name) => call(name: name);

  @override
  Student surname(String surname) => call(surname: surname);

  @override
  Student email(String email) => call(email: email);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Student(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Student(...).copyWith(id: 12, name: "My name")
  /// ```
  Student call({
    Object? name = const $CopyWithPlaceholder(),
    Object? surname = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
  }) {
    return Student(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      surname: surname == const $CopyWithPlaceholder() || surname == null
          ? _value.surname
          // ignore: cast_nullable_to_non_nullable
          : surname as String,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
    );
  }
}

extension $StudentCopyWith on Student {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStudent.copyWith(...)` or `instanceOfStudent.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StudentCWProxy get copyWith => _$StudentCWProxyImpl(this);
}
