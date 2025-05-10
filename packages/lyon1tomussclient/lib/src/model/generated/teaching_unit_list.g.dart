// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../teaching_unit_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TeachingUnitListCWProxy {
  TeachingUnitList teachingUnitModels(List<TeachingUnit> teachingUnitModels);

  TeachingUnitList semesterIndex(int semesterIndex);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TeachingUnitList(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TeachingUnitList(...).copyWith(id: 12, name: "My name")
  /// ```
  TeachingUnitList call({
    List<TeachingUnit> teachingUnitModels,
    int semesterIndex,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTeachingUnitList.copyWith(...)` or call `instanceOfTeachingUnitList.copyWith.fieldName(value)` for a single field.
class _$TeachingUnitListCWProxyImpl implements _$TeachingUnitListCWProxy {
  const _$TeachingUnitListCWProxyImpl(this._value);

  final TeachingUnitList _value;

  @override
  TeachingUnitList teachingUnitModels(List<TeachingUnit> teachingUnitModels) =>
      call(teachingUnitModels: teachingUnitModels);

  @override
  TeachingUnitList semesterIndex(int semesterIndex) =>
      call(semesterIndex: semesterIndex);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TeachingUnitList(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TeachingUnitList(...).copyWith(id: 12, name: "My name")
  /// ```
  TeachingUnitList call({
    Object? teachingUnitModels = const $CopyWithPlaceholder(),
    Object? semesterIndex = const $CopyWithPlaceholder(),
  }) {
    return TeachingUnitList(
      teachingUnitModels == const $CopyWithPlaceholder()
          ? _value.teachingUnitModels
          // ignore: cast_nullable_to_non_nullable
          : teachingUnitModels as List<TeachingUnit>,
      semesterIndex == const $CopyWithPlaceholder()
          ? _value.semesterIndex
          // ignore: cast_nullable_to_non_nullable
          : semesterIndex as int,
    );
  }
}

extension $TeachingUnitListCopyWith on TeachingUnitList {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTeachingUnitList.copyWith(...)` or `instanceOfTeachingUnitList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TeachingUnitListCWProxy get copyWith => _$TeachingUnitListCWProxyImpl(this);
}
