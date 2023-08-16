// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../semester.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SemesterCWProxy {
  Semester title(String title);

  Semester url(String url);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Semester(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Semester(...).copyWith(id: 12, name: "My name")
  /// ````
  Semester call({
    String? title,
    String? url,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSemester.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSemester.copyWith.fieldName(...)`
class _$SemesterCWProxyImpl implements _$SemesterCWProxy {
  const _$SemesterCWProxyImpl(this._value);

  final Semester _value;

  @override
  Semester title(String title) => this(title: title);

  @override
  Semester url(String url) => this(url: url);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Semester(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Semester(...).copyWith(id: 12, name: "My name")
  /// ````
  Semester call({
    Object? title = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
  }) {
    return Semester(
      title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      url == const $CopyWithPlaceholder() || url == null
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
    );
  }
}

extension $SemesterCopyWith on Semester {
  /// Returns a callable class that can be used as follows: `instanceOfSemester.copyWith(...)` or like so:`instanceOfSemester.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SemesterCWProxy get copyWith => _$SemesterCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SemesterAdapter extends TypeAdapter<Semester> {
  @override
  final int typeId = 13;

  @override
  Semester read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Semester(
      fields[0] == null ? '' : fields[0] as String,
      fields[1] == null ? '' : fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Semester obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemesterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
