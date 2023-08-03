// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../agenda.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AgendaCWProxy {
  Agenda days(List<Day> days);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Agenda(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Agenda(...).copyWith(id: 12, name: "My name")
  /// ````
  Agenda call({
    List<Day>? days,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAgenda.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAgenda.copyWith.fieldName(...)`
class _$AgendaCWProxyImpl implements _$AgendaCWProxy {
  const _$AgendaCWProxyImpl(this._value);

  final Agenda _value;

  @override
  Agenda days(List<Day> days) => this(days: days);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Agenda(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Agenda(...).copyWith(id: 12, name: "My name")
  /// ````
  Agenda call({
    Object? days = const $CopyWithPlaceholder(),
  }) {
    return Agenda(
      days == const $CopyWithPlaceholder() || days == null
          ? _value.days
          // ignore: cast_nullable_to_non_nullable
          : days as List<Day>,
    );
  }
}

extension $AgendaCopyWith on Agenda {
  /// Returns a callable class that can be used as follows: `instanceOfAgenda.copyWith(...)` or like so:`instanceOfAgenda.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AgendaCWProxy get copyWith => _$AgendaCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgendaAdapter extends TypeAdapter<Agenda> {
  @override
  final int typeId = 2;

  @override
  Agenda read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Agenda(
      (fields[0] as List).cast<Day>(),
    );
  }

  @override
  void write(BinaryWriter writer, Agenda obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.days);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgendaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
