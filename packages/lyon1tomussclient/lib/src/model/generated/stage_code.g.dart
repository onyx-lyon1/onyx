// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../stage_code.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StageCodeCWProxy {
  StageCode title(String title);

  StageCode author(String author);

  StageCode date(DateTime? date);

  StageCode position(double position);

  StageCode value(String value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StageCode(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StageCode(...).copyWith(id: 12, name: "My name")
  /// ````
  StageCode call({
    String? title,
    String? author,
    DateTime? date,
    double? position,
    String? value,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStageCode.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStageCode.copyWith.fieldName(...)`
class _$StageCodeCWProxyImpl implements _$StageCodeCWProxy {
  const _$StageCodeCWProxyImpl(this._value);

  final StageCode _value;

  @override
  StageCode title(String title) => this(title: title);

  @override
  StageCode author(String author) => this(author: author);

  @override
  StageCode date(DateTime? date) => this(date: date);

  @override
  StageCode position(double position) => this(position: position);

  @override
  StageCode value(String value) => this(value: value);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StageCode(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StageCode(...).copyWith(id: 12, name: "My name")
  /// ````
  StageCode call({
    Object? title = const $CopyWithPlaceholder(),
    Object? author = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return StageCode(
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      author: author == const $CopyWithPlaceholder() || author == null
          ? _value.author
          // ignore: cast_nullable_to_non_nullable
          : author as String,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime?,
      position: position == const $CopyWithPlaceholder() || position == null
          ? _value.position
          // ignore: cast_nullable_to_non_nullable
          : position as double,
      value: value == const $CopyWithPlaceholder() || value == null
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String,
    );
  }
}

extension $StageCodeCopyWith on StageCode {
  /// Returns a callable class that can be used as follows: `instanceOfStageCode.copyWith(...)` or like so:`instanceOfStageCode.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StageCodeCWProxy get copyWith => _$StageCodeCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StageCodeAdapter extends TypeAdapter<StageCode> {
  @override
  final int typeId = 28;

  @override
  StageCode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StageCode(
      title: fields[100] == null ? '' : fields[100] as String,
      author: fields[101] == null ? '' : fields[101] as String,
      date: fields[102] as DateTime?,
      position: fields[103] == null ? 0 : fields[103] as double,
      value: fields[1] == null ? '' : fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StageCode obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(100)
      ..write(obj.title)
      ..writeByte(101)
      ..write(obj.author)
      ..writeByte(102)
      ..write(obj.date)
      ..writeByte(103)
      ..write(obj.position);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StageCodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
