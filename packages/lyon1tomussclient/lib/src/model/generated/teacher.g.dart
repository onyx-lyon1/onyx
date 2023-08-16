// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../teacher.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TeacherCWProxy {
  Teacher name(String name);

  Teacher email(String email);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Teacher(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Teacher(...).copyWith(id: 12, name: "My name")
  /// ````
  Teacher call({
    String? name,
    String? email,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTeacher.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTeacher.copyWith.fieldName(...)`
class _$TeacherCWProxyImpl implements _$TeacherCWProxy {
  const _$TeacherCWProxyImpl(this._value);

  final Teacher _value;

  @override
  Teacher name(String name) => this(name: name);

  @override
  Teacher email(String email) => this(email: email);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Teacher(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Teacher(...).copyWith(id: 12, name: "My name")
  /// ````
  Teacher call({
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
  }) {
    return Teacher(
      name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
    );
  }
}

extension $TeacherCopyWith on Teacher {
  /// Returns a callable class that can be used as follows: `instanceOfTeacher.copyWith(...)` or like so:`instanceOfTeacher.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TeacherCWProxy get copyWith => _$TeacherCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeacherAdapter extends TypeAdapter<Teacher> {
  @override
  final int typeId = 12;

  @override
  Teacher read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Teacher(
      fields[0] == null ? '' : fields[0] as String,
      fields[1] == null ? '' : fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Teacher obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
