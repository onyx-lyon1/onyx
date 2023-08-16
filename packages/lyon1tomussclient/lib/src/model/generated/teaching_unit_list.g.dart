// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../teaching_unit_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TeachingUnitListCWProxy {
  TeachingUnitList teachingUnitModels(List<TeachingUnit> teachingUnitModels);

  TeachingUnitList semesterIndex(int semesterIndex);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TeachingUnitList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TeachingUnitList(...).copyWith(id: 12, name: "My name")
  /// ````
  TeachingUnitList call({
    List<TeachingUnit>? teachingUnitModels,
    int? semesterIndex,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTeachingUnitList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTeachingUnitList.copyWith.fieldName(...)`
class _$TeachingUnitListCWProxyImpl implements _$TeachingUnitListCWProxy {
  const _$TeachingUnitListCWProxyImpl(this._value);

  final TeachingUnitList _value;

  @override
  TeachingUnitList teachingUnitModels(List<TeachingUnit> teachingUnitModels) =>
      this(teachingUnitModels: teachingUnitModels);

  @override
  TeachingUnitList semesterIndex(int semesterIndex) =>
      this(semesterIndex: semesterIndex);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TeachingUnitList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TeachingUnitList(...).copyWith(id: 12, name: "My name")
  /// ````
  TeachingUnitList call({
    Object? teachingUnitModels = const $CopyWithPlaceholder(),
    Object? semesterIndex = const $CopyWithPlaceholder(),
  }) {
    return TeachingUnitList(
      teachingUnitModels == const $CopyWithPlaceholder() ||
              teachingUnitModels == null
          ? _value.teachingUnitModels
          // ignore: cast_nullable_to_non_nullable
          : teachingUnitModels as List<TeachingUnit>,
      semesterIndex == const $CopyWithPlaceholder() || semesterIndex == null
          ? _value.semesterIndex
          // ignore: cast_nullable_to_non_nullable
          : semesterIndex as int,
    );
  }
}

extension $TeachingUnitListCopyWith on TeachingUnitList {
  /// Returns a callable class that can be used as follows: `instanceOfTeachingUnitList.copyWith(...)` or like so:`instanceOfTeachingUnitList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TeachingUnitListCWProxy get copyWith => _$TeachingUnitListCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeachingUnitListAdapter extends TypeAdapter<TeachingUnitList> {
  @override
  final int typeId = 11;

  @override
  TeachingUnitList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeachingUnitList(
      (fields[0] as List).cast<TeachingUnit>(),
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TeachingUnitList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.teachingUnitModels)
      ..writeByte(1)
      ..write(obj.semesterIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeachingUnitListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
