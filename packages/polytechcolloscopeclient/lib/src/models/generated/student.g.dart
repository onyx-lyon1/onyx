// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../student.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StudentCWProxy {
  Student year(Year year);

  Student name(String name);

  Student id(int id);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Student(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Student(...).copyWith(id: 12, name: "My name")
  /// ````
  Student call({
    Year? year,
    String? name,
    int? id,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStudent.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStudent.copyWith.fieldName(...)`
class _$StudentCWProxyImpl implements _$StudentCWProxy {
  const _$StudentCWProxyImpl(this._value);

  final Student _value;

  @override
  Student year(Year year) => this(year: year);

  @override
  Student name(String name) => this(name: name);

  @override
  Student id(int id) => this(id: id);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Student(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Student(...).copyWith(id: 12, name: "My name")
  /// ````
  Student call({
    Object? year = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
  }) {
    return Student(
      year == const $CopyWithPlaceholder() || year == null
          ? _value.year
          // ignore: cast_nullable_to_non_nullable
          : year as Year,
      name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
    );
  }
}

extension $StudentCopyWith on Student {
  /// Returns a callable class that can be used as follows: `instanceOfStudent.copyWith(...)` or like so:`instanceOfStudent.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StudentCWProxy get copyWith => _$StudentCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 44;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      fields[0] as Year,
      fields[1] as String,
      fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
