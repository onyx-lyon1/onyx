// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../teacher.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TeacherCWProxy {
  Teacher name(String name);

  Teacher email(String email);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Teacher(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Teacher(...).copyWith(id: 12, name: "My name")
  /// ```
  Teacher call({
    String name,
    String email,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTeacher.copyWith(...)` or call `instanceOfTeacher.copyWith.fieldName(value)` for a single field.
class _$TeacherCWProxyImpl implements _$TeacherCWProxy {
  const _$TeacherCWProxyImpl(this._value);

  final Teacher _value;

  @override
  Teacher name(String name) => call(name: name);

  @override
  Teacher email(String email) => call(email: email);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Teacher(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Teacher(...).copyWith(id: 12, name: "My name")
  /// ```
  Teacher call({
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
  }) {
    return Teacher(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
    );
  }
}

extension $TeacherCopyWith on Teacher {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTeacher.copyWith(...)` or `instanceOfTeacher.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TeacherCWProxy get copyWith => _$TeacherCWProxyImpl(this);
}
