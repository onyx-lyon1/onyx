// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../url.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$URLCWProxy {
  URL title(String title);

  URL author(String author);

  URL date(DateTime? date);

  URL position(double position);

  URL value(String value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `URL(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// URL(...).copyWith(id: 12, name: "My name")
  /// ````
  URL call({
    String? title,
    String? author,
    DateTime? date,
    double? position,
    String? value,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfURL.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfURL.copyWith.fieldName(...)`
class _$URLCWProxyImpl implements _$URLCWProxy {
  const _$URLCWProxyImpl(this._value);

  final URL _value;

  @override
  URL title(String title) => this(title: title);

  @override
  URL author(String author) => this(author: author);

  @override
  URL date(DateTime? date) => this(date: date);

  @override
  URL position(double position) => this(position: position);

  @override
  URL value(String value) => this(value: value);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `URL(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// URL(...).copyWith(id: 12, name: "My name")
  /// ````
  URL call({
    Object? title = const $CopyWithPlaceholder(),
    Object? author = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return URL(
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

extension $URLCopyWith on URL {
  /// Returns a callable class that can be used as follows: `instanceOfURL.copyWith(...)` or like so:`instanceOfURL.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$URLCWProxy get copyWith => _$URLCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class URLAdapter extends TypeAdapter<URL> {
  @override
  final int typeId = 31;

  @override
  URL read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return URL(
      title: fields[100] == null ? '' : fields[100] as String,
      author: fields[101] == null ? '' : fields[101] as String,
      date: fields[102] as DateTime?,
      position: fields[103] == null ? 0 : fields[103] as double,
      value: fields[2] == null ? '' : fields[2] as String,
    )..isModifiable = fields[3] == null ? false : fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, URL obj) {
    writer
      ..writeByte(6)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.isModifiable)
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
      other is URLAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
