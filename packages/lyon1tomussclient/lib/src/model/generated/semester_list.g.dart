// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../semester_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SemesterListCWProxy {
  SemesterList semestres(List<Semester> semestres);

  SemesterList currentSemesterIndex(int currentSemesterIndex);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SemesterList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SemesterList(...).copyWith(id: 12, name: "My name")
  /// ````
  SemesterList call({
    List<Semester>? semestres,
    int? currentSemesterIndex,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSemesterList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSemesterList.copyWith.fieldName(...)`
class _$SemesterListCWProxyImpl implements _$SemesterListCWProxy {
  const _$SemesterListCWProxyImpl(this._value);

  final SemesterList _value;

  @override
  SemesterList semestres(List<Semester> semestres) =>
      this(semestres: semestres);

  @override
  SemesterList currentSemesterIndex(int currentSemesterIndex) =>
      this(currentSemesterIndex: currentSemesterIndex);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SemesterList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SemesterList(...).copyWith(id: 12, name: "My name")
  /// ````
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
  /// Returns a callable class that can be used as follows: `instanceOfSemesterList.copyWith(...)` or like so:`instanceOfSemesterList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SemesterListCWProxy get copyWith => _$SemesterListCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SemesterListAdapter extends TypeAdapter<SemesterList> {
  @override
  final int typeId = 14;

  @override
  SemesterList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SemesterList(
      (fields[0] as List).cast<Semester>(),
      currentSemesterIndex: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SemesterList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.semestres)
      ..writeByte(1)
      ..write(obj.currentSemesterIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemesterListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
