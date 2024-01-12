// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../student_colloscope.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StudentColloscopeCWProxy {
  StudentColloscope student(Student student);

  StudentColloscope trinomeId(int trinomeId);

  StudentColloscope kholles(List<Kholle> kholles);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StudentColloscope(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StudentColloscope(...).copyWith(id: 12, name: "My name")
  /// ````
  StudentColloscope call({
    Student? student,
    int? trinomeId,
    List<Kholle>? kholles,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStudentColloscope.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStudentColloscope.copyWith.fieldName(...)`
class _$StudentColloscopeCWProxyImpl implements _$StudentColloscopeCWProxy {
  const _$StudentColloscopeCWProxyImpl(this._value);

  final StudentColloscope _value;

  @override
  StudentColloscope student(Student student) => this(student: student);

  @override
  StudentColloscope trinomeId(int trinomeId) => this(trinomeId: trinomeId);

  @override
  StudentColloscope kholles(List<Kholle> kholles) => this(kholles: kholles);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StudentColloscope(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StudentColloscope(...).copyWith(id: 12, name: "My name")
  /// ````
  StudentColloscope call({
    Object? student = const $CopyWithPlaceholder(),
    Object? trinomeId = const $CopyWithPlaceholder(),
    Object? kholles = const $CopyWithPlaceholder(),
  }) {
    return StudentColloscope(
      student == const $CopyWithPlaceholder() || student == null
          ? _value.student
          // ignore: cast_nullable_to_non_nullable
          : student as Student,
      trinomeId == const $CopyWithPlaceholder() || trinomeId == null
          ? _value.trinomeId
          // ignore: cast_nullable_to_non_nullable
          : trinomeId as int,
      kholles == const $CopyWithPlaceholder() || kholles == null
          ? _value.kholles
          // ignore: cast_nullable_to_non_nullable
          : kholles as List<Kholle>,
    );
  }
}

extension $StudentColloscopeCopyWith on StudentColloscope {
  /// Returns a callable class that can be used as follows: `instanceOfStudentColloscope.copyWith(...)` or like so:`instanceOfStudentColloscope.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StudentColloscopeCWProxy get copyWith =>
      _$StudentColloscopeCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentColloscopeAdapter extends TypeAdapter<StudentColloscope> {
  @override
  final int typeId = 46;

  @override
  StudentColloscope read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentColloscope(
      fields[0] as Student,
      fields[1] as int,
      (fields[2] as List).cast<Kholle>(),
    );
  }

  @override
  void write(BinaryWriter writer, StudentColloscope obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.student)
      ..writeByte(1)
      ..write(obj.trinomeId)
      ..writeByte(2)
      ..write(obj.kholles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentColloscopeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
