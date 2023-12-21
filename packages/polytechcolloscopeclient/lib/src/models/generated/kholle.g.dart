// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../kholle.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$KholleCWProxy {
  Kholle date(DateTime date);

  Kholle subject(String subject);

  Kholle kholleur(String kholleur);

  Kholle message(String? message);

  Kholle room(String? room);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Kholle(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Kholle(...).copyWith(id: 12, name: "My name")
  /// ````
  Kholle call({
    DateTime? date,
    String? subject,
    String? kholleur,
    String? message,
    String? room,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfKholle.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfKholle.copyWith.fieldName(...)`
class _$KholleCWProxyImpl implements _$KholleCWProxy {
  const _$KholleCWProxyImpl(this._value);

  final Kholle _value;

  @override
  Kholle date(DateTime date) => this(date: date);

  @override
  Kholle subject(String subject) => this(subject: subject);

  @override
  Kholle kholleur(String kholleur) => this(kholleur: kholleur);

  @override
  Kholle message(String? message) => this(message: message);

  @override
  Kholle room(String? room) => this(room: room);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Kholle(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Kholle(...).copyWith(id: 12, name: "My name")
  /// ````
  Kholle call({
    Object? date = const $CopyWithPlaceholder(),
    Object? subject = const $CopyWithPlaceholder(),
    Object? kholleur = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? room = const $CopyWithPlaceholder(),
  }) {
    return Kholle(
      date == const $CopyWithPlaceholder() || date == null
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime,
      subject == const $CopyWithPlaceholder() || subject == null
          ? _value.subject
          // ignore: cast_nullable_to_non_nullable
          : subject as String,
      kholleur == const $CopyWithPlaceholder() || kholleur == null
          ? _value.kholleur
          // ignore: cast_nullable_to_non_nullable
          : kholleur as String,
      message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      room == const $CopyWithPlaceholder()
          ? _value.room
          // ignore: cast_nullable_to_non_nullable
          : room as String?,
    );
  }
}

extension $KholleCopyWith on Kholle {
  /// Returns a callable class that can be used as follows: `instanceOfKholle.copyWith(...)` or like so:`instanceOfKholle.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$KholleCWProxy get copyWith => _$KholleCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KholleAdapter extends TypeAdapter<Kholle> {
  @override
  final int typeId = 45;

  @override
  Kholle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kholle(
      fields[0] as DateTime,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String?,
      fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Kholle obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.kholleur)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.room);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KholleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
