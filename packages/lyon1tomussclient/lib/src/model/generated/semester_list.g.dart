// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../semester_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SemesterListCWProxy {
  SemesterList semestres(List<Semester> semestres);

  SemesterList currentSemesterIndex(int currentSemesterIndex);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SemesterList(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SemesterList(...).copyWith(id: 12, name: "My name")
  /// ```
  SemesterList call({
    List<Semester> semestres,
    int currentSemesterIndex,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSemesterList.copyWith(...)` or call `instanceOfSemesterList.copyWith.fieldName(value)` for a single field.
class _$SemesterListCWProxyImpl implements _$SemesterListCWProxy {
  const _$SemesterListCWProxyImpl(this._value);

  final SemesterList _value;

  @override
  SemesterList semestres(List<Semester> semestres) =>
      call(semestres: semestres);

  @override
  SemesterList currentSemesterIndex(int currentSemesterIndex) =>
      call(currentSemesterIndex: currentSemesterIndex);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SemesterList(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SemesterList(...).copyWith(id: 12, name: "My name")
  /// ```
  SemesterList call({
    Object? semestres = const $CopyWithPlaceholder(),
    Object? currentSemesterIndex = const $CopyWithPlaceholder(),
  }) {
    return SemesterList(
      semestres == const $CopyWithPlaceholder() || semestres == null
          ? _value.semestres
          // ignore: cast_nullable_to_non_nullable
          : semestres as List<Semester>,
      currentSemesterIndex:
          currentSemesterIndex == const $CopyWithPlaceholder() ||
                  currentSemesterIndex == null
              ? _value.currentSemesterIndex
              // ignore: cast_nullable_to_non_nullable
              : currentSemesterIndex as int,
    );
  }
}

extension $SemesterListCopyWith on SemesterList {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSemesterList.copyWith(...)` or `instanceOfSemesterList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SemesterListCWProxy get copyWith => _$SemesterListCWProxyImpl(this);
}
