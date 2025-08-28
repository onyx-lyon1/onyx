// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../semester.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SemesterCWProxy {
  Semester title(String title);

  Semester url(String url);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Semester(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Semester(...).copyWith(id: 12, name: "My name")
  /// ```
  Semester call({
    String title,
    String url,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSemester.copyWith(...)` or call `instanceOfSemester.copyWith.fieldName(value)` for a single field.
class _$SemesterCWProxyImpl implements _$SemesterCWProxy {
  const _$SemesterCWProxyImpl(this._value);

  final Semester _value;

  @override
  Semester title(String title) => call(title: title);

  @override
  Semester url(String url) => call(url: url);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Semester(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Semester(...).copyWith(id: 12, name: "My name")
  /// ```
  Semester call({
    Object? title = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
  }) {
    return Semester(
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      url: url == const $CopyWithPlaceholder() || url == null
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
    );
  }
}

extension $SemesterCopyWith on Semester {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSemester.copyWith(...)` or `instanceOfSemester.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SemesterCWProxy get copyWith => _$SemesterCWProxyImpl(this);
}
