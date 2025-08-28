// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../student_colloscope.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StudentColloscopeCWProxy {
  StudentColloscope student(Student student);

  StudentColloscope trinomeId(int trinomeId);

  StudentColloscope kholles(List<Kholle> kholles);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `StudentColloscope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StudentColloscope(...).copyWith(id: 12, name: "My name")
  /// ```
  StudentColloscope call({
    Student student,
    int trinomeId,
    List<Kholle> kholles,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStudentColloscope.copyWith(...)` or call `instanceOfStudentColloscope.copyWith.fieldName(value)` for a single field.
class _$StudentColloscopeCWProxyImpl implements _$StudentColloscopeCWProxy {
  const _$StudentColloscopeCWProxyImpl(this._value);

  final StudentColloscope _value;

  @override
  StudentColloscope student(Student student) => call(student: student);

  @override
  StudentColloscope trinomeId(int trinomeId) => call(trinomeId: trinomeId);

  @override
  StudentColloscope kholles(List<Kholle> kholles) => call(kholles: kholles);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `StudentColloscope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StudentColloscope(...).copyWith(id: 12, name: "My name")
  /// ```
  StudentColloscope call({
    Object? student = const $CopyWithPlaceholder(),
    Object? trinomeId = const $CopyWithPlaceholder(),
    Object? kholles = const $CopyWithPlaceholder(),
  }) {
    return StudentColloscope(
      student == const $CopyWithPlaceholder()
          ? _value.student
          // ignore: cast_nullable_to_non_nullable
          : student as Student,
      trinomeId == const $CopyWithPlaceholder()
          ? _value.trinomeId
          // ignore: cast_nullable_to_non_nullable
          : trinomeId as int,
      kholles == const $CopyWithPlaceholder()
          ? _value.kholles
          // ignore: cast_nullable_to_non_nullable
          : kholles as List<Kholle>,
    );
  }
}

extension $StudentColloscopeCopyWith on StudentColloscope {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStudentColloscope.copyWith(...)` or `instanceOfStudentColloscope.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StudentColloscopeCWProxy get copyWith =>
      _$StudentColloscopeCWProxyImpl(this);
}
