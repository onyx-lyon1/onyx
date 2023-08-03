// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tomuss_text.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TomussTextCWProxy {
  TomussText title(String title);

  TomussText author(String author);

  TomussText date(DateTime? date);

  TomussText position(double position);

  TomussText value(String value);

  TomussText comment(String comment);

  TomussText isValidText(bool isValidText);

  TomussText isHidden(bool isHidden);

  TomussText theId(String theId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TomussText(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TomussText(...).copyWith(id: 12, name: "My name")
  /// ````
  TomussText call({
    String? title,
    String? author,
    DateTime? date,
    double? position,
    String? value,
    String? comment,
    bool? isValidText,
    bool? isHidden,
    String? theId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTomussText.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTomussText.copyWith.fieldName(...)`
class _$TomussTextCWProxyImpl implements _$TomussTextCWProxy {
  const _$TomussTextCWProxyImpl(this._value);

  final TomussText _value;

  @override
  TomussText title(String title) => this(title: title);

  @override
  TomussText author(String author) => this(author: author);

  @override
  TomussText date(DateTime? date) => this(date: date);

  @override
  TomussText position(double position) => this(position: position);

  @override
  TomussText value(String value) => this(value: value);

  @override
  TomussText comment(String comment) => this(comment: comment);

  @override
  TomussText isValidText(bool isValidText) => this(isValidText: isValidText);

  @override
  TomussText isHidden(bool isHidden) => this(isHidden: isHidden);

  @override
  TomussText theId(String theId) => this(theId: theId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TomussText(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TomussText(...).copyWith(id: 12, name: "My name")
  /// ````
  TomussText call({
    Object? title = const $CopyWithPlaceholder(),
    Object? author = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? isValidText = const $CopyWithPlaceholder(),
    Object? isHidden = const $CopyWithPlaceholder(),
    Object? theId = const $CopyWithPlaceholder(),
  }) {
    return TomussText(
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
      comment: comment == const $CopyWithPlaceholder() || comment == null
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String,
      isValidText:
          isValidText == const $CopyWithPlaceholder() || isValidText == null
              ? _value.isValidText
              // ignore: cast_nullable_to_non_nullable
              : isValidText as bool,
      isHidden: isHidden == const $CopyWithPlaceholder() || isHidden == null
          ? _value.isHidden
          // ignore: cast_nullable_to_non_nullable
          : isHidden as bool,
      theId: theId == const $CopyWithPlaceholder() || theId == null
          ? _value.theId
          // ignore: cast_nullable_to_non_nullable
          : theId as String,
    );
  }
}

extension $TomussTextCopyWith on TomussText {
  /// Returns a callable class that can be used as follows: `instanceOfTomussText.copyWith(...)` or like so:`instanceOfTomussText.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TomussTextCWProxy get copyWith => _$TomussTextCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TomussTextAdapter extends TypeAdapter<TomussText> {
  @override
  final int typeId = 29;

  @override
  TomussText read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TomussText(
      title: fields[100] == null ? '' : fields[100] as String,
      author: fields[101] == null ? '' : fields[101] as String,
      date: fields[102] as DateTime?,
      position: fields[103] == null ? 0 : fields[103] as double,
      value: fields[1] == null ? '' : fields[1] as String,
      comment: fields[3] == null ? '' : fields[3] as String,
      isValidText: fields[4] == null ? false : fields[4] as bool,
      isHidden: fields[6] == null ? false : fields[6] as bool,
      theId: fields[7] == null ? '' : fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TomussText obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.comment)
      ..writeByte(4)
      ..write(obj.isValidText)
      ..writeByte(6)
      ..write(obj.isHidden)
      ..writeByte(7)
      ..write(obj.theId)
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
      other is TomussTextAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
