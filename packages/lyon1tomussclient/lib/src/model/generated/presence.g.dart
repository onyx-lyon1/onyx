// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../presence.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PresenceCWProxy {
  Presence title(String title);

  Presence author(String author);

  Presence date(DateTime? date);

  Presence position(double position);

  Presence value(String value);

  Presence emptyIs(String? emptyIs);

  Presence color(PresenceColor color);

  Presence visibilityDate(DateTime? visibilityDate);

  Presence visible(bool? visible);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Presence(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Presence(...).copyWith(id: 12, name: "My name")
  /// ````
  Presence call({
    String? title,
    String? author,
    DateTime? date,
    double? position,
    String? value,
    String? emptyIs,
    PresenceColor? color,
    DateTime? visibilityDate,
    bool? visible,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPresence.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPresence.copyWith.fieldName(...)`
class _$PresenceCWProxyImpl implements _$PresenceCWProxy {
  const _$PresenceCWProxyImpl(this._value);

  final Presence _value;

  @override
  Presence title(String title) => this(title: title);

  @override
  Presence author(String author) => this(author: author);

  @override
  Presence date(DateTime? date) => this(date: date);

  @override
  Presence position(double position) => this(position: position);

  @override
  Presence value(String value) => this(value: value);

  @override
  Presence emptyIs(String? emptyIs) => this(emptyIs: emptyIs);

  @override
  Presence color(PresenceColor color) => this(color: color);

  @override
  Presence visibilityDate(DateTime? visibilityDate) =>
      this(visibilityDate: visibilityDate);

  @override
  Presence visible(bool? visible) => this(visible: visible);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Presence(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Presence(...).copyWith(id: 12, name: "My name")
  /// ````
  Presence call({
    Object? title = const $CopyWithPlaceholder(),
    Object? author = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? emptyIs = const $CopyWithPlaceholder(),
    Object? color = const $CopyWithPlaceholder(),
    Object? visibilityDate = const $CopyWithPlaceholder(),
    Object? visible = const $CopyWithPlaceholder(),
  }) {
    return Presence(
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
      emptyIs: emptyIs == const $CopyWithPlaceholder()
          ? _value.emptyIs
          // ignore: cast_nullable_to_non_nullable
          : emptyIs as String?,
      color: color == const $CopyWithPlaceholder() || color == null
          ? _value.color
          // ignore: cast_nullable_to_non_nullable
          : color as PresenceColor,
      visibilityDate: visibilityDate == const $CopyWithPlaceholder()
          ? _value.visibilityDate
          // ignore: cast_nullable_to_non_nullable
          : visibilityDate as DateTime?,
      visible: visible == const $CopyWithPlaceholder()
          ? _value.visible
          // ignore: cast_nullable_to_non_nullable
          : visible as bool?,
    );
  }
}

extension $PresenceCopyWith on Presence {
  /// Returns a callable class that can be used as follows: `instanceOfPresence.copyWith(...)` or like so:`instanceOfPresence.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PresenceCWProxy get copyWith => _$PresenceCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PresenceAdapter extends TypeAdapter<Presence> {
  @override
  final int typeId = 27;

  @override
  Presence read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Presence(
      title: fields[100] == null ? '' : fields[100] as String,
      author: fields[101] == null ? '' : fields[101] as String,
      date: fields[102] as DateTime?,
      position: fields[103] == null ? 0 : fields[103] as double,
      value: fields[1] == null ? '' : fields[1] as String,
      emptyIs: fields[3] == null ? '' : fields[3] as String?,
      color:
          fields[4] == null ? PresenceColor.unset : fields[4] as PresenceColor,
      visibilityDate: fields[5] as DateTime?,
      visible: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Presence obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.emptyIs)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.visibilityDate)
      ..writeByte(6)
      ..write(obj.visible)
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
      other is PresenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PresenceColorAdapter extends TypeAdapter<PresenceColor> {
  @override
  final int typeId = 26;

  @override
  PresenceColor read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PresenceColor.green;
      case 1:
        return PresenceColor.red;
      case 2:
        return PresenceColor.unset;
      default:
        return PresenceColor.green;
    }
  }

  @override
  void write(BinaryWriter writer, PresenceColor obj) {
    switch (obj) {
      case PresenceColor.green:
        writer.writeByte(0);
        break;
      case PresenceColor.red:
        writer.writeByte(1);
        break;
      case PresenceColor.unset:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PresenceColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
