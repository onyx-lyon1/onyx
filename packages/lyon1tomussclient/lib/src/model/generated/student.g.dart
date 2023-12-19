// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../student.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StudentCWProxy {
  Student name(String name);

  Student surname(String surname);

  Student email(String email);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Student(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Student(...).copyWith(id: 12, name: "My name")
  /// ````
  Student call({
    String? name,
    String? surname,
    String? email,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStudent.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStudent.copyWith.fieldName(...)`
class _$StudentCWProxyImpl implements _$StudentCWProxy {
  const _$StudentCWProxyImpl(this._value);

  final Student _value;

  @override
  Student name(String name) => this(name: name);

  @override
  Student surname(String surname) => this(surname: surname);

  @override
  Student email(String email) => this(email: email);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Student(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Student(...).copyWith(id: 12, name: "My name")
  /// ````
  Student call({
    Object? name = const $CopyWithPlaceholder(),
    Object? surname = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
  }) {
    return Student(
      name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      surname == const $CopyWithPlaceholder() || surname == null
          ? _value.surname
          // ignore: cast_nullable_to_non_nullable
          : surname as String,
      email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
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
  final int typeId = 43;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      fields[0] == null ? '' : fields[0] as String,
      fields[1] == null ? '' : fields[1] as String,
      fields[2] == null ? '' : fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.surname)
      ..writeByte(2)
      ..write(obj.email);
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
