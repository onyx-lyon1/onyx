// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../day.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DayCWProxy {
  Day date(DateTime date);

  Day events(List<Event> events);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Day(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Day(...).copyWith(id: 12, name: "My name")
  /// ````
  Day call({
    DateTime? date,
    List<Event>? events,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDay.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDay.copyWith.fieldName(...)`
class _$DayCWProxyImpl implements _$DayCWProxy {
  const _$DayCWProxyImpl(this._value);

  final Day _value;

  @override
  Day date(DateTime date) => this(date: date);

  @override
  Day events(List<Event> events) => this(events: events);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Day(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Day(...).copyWith(id: 12, name: "My name")
  /// ````
  Day call({
    Object? date = const $CopyWithPlaceholder(),
    Object? events = const $CopyWithPlaceholder(),
  }) {
    return Day(
      date == const $CopyWithPlaceholder() || date == null
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime,
      events == const $CopyWithPlaceholder() || events == null
          ? _value.events
          // ignore: cast_nullable_to_non_nullable
          : events as List<Event>,
    );
  }
}

extension $DayCopyWith on Day {
  /// Returns a callable class that can be used as follows: `instanceOfDay.copyWith(...)` or like so:`instanceOfDay.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DayCWProxy get copyWith => _$DayCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayAdapter extends TypeAdapter<Day> {
  @override
  final int typeId = 1;

  @override
  Day read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Day(
      fields[1] as DateTime,
      (fields[0] as List).cast<Event>(),
    );
  }

  @override
  void write(BinaryWriter writer, Day obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.events)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
