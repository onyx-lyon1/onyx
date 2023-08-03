// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EventCWProxy {
  Event location(String location);

  Event description(String description);

  Event teacher(String teacher);

  Event name(String name);

  Event start(DateTime start);

  Event end(DateTime end);

  Event eventLastModified(DateTime eventLastModified);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Event(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Event(...).copyWith(id: 12, name: "My name")
  /// ````
  Event call({
    String? location,
    String? description,
    String? teacher,
    String? name,
    DateTime? start,
    DateTime? end,
    DateTime? eventLastModified,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEvent.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEvent.copyWith.fieldName(...)`
class _$EventCWProxyImpl implements _$EventCWProxy {
  const _$EventCWProxyImpl(this._value);

  final Event _value;

  @override
  Event location(String location) => this(location: location);

  @override
  Event description(String description) => this(description: description);

  @override
  Event teacher(String teacher) => this(teacher: teacher);

  @override
  Event name(String name) => this(name: name);

  @override
  Event start(DateTime start) => this(start: start);

  @override
  Event end(DateTime end) => this(end: end);

  @override
  Event eventLastModified(DateTime eventLastModified) =>
      this(eventLastModified: eventLastModified);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Event(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Event(...).copyWith(id: 12, name: "My name")
  /// ````
  Event call({
    Object? location = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? teacher = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? start = const $CopyWithPlaceholder(),
    Object? end = const $CopyWithPlaceholder(),
    Object? eventLastModified = const $CopyWithPlaceholder(),
  }) {
    return Event(
      location: location == const $CopyWithPlaceholder() || location == null
          ? _value.location
          // ignore: cast_nullable_to_non_nullable
          : location as String,
      description:
          description == const $CopyWithPlaceholder() || description == null
              ? _value.description
              // ignore: cast_nullable_to_non_nullable
              : description as String,
      teacher: teacher == const $CopyWithPlaceholder() || teacher == null
          ? _value.teacher
          // ignore: cast_nullable_to_non_nullable
          : teacher as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      start: start == const $CopyWithPlaceholder() || start == null
          ? _value.start
          // ignore: cast_nullable_to_non_nullable
          : start as DateTime,
      end: end == const $CopyWithPlaceholder() || end == null
          ? _value.end
          // ignore: cast_nullable_to_non_nullable
          : end as DateTime,
      eventLastModified: eventLastModified == const $CopyWithPlaceholder() ||
              eventLastModified == null
          ? _value.eventLastModified
          // ignore: cast_nullable_to_non_nullable
          : eventLastModified as DateTime,
    );
  }
}

extension $EventCopyWith on Event {
  /// Returns a callable class that can be used as follows: `instanceOfEvent.copyWith(...)` or like so:`instanceOfEvent.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EventCWProxy get copyWith => _$EventCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventAdapter extends TypeAdapter<Event> {
  @override
  final int typeId = 3;

  @override
  Event read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Event(
      location: fields[0] as String,
      description: fields[1] as String,
      teacher: fields[2] as String,
      name: fields[3] as String,
      start: fields[4] as DateTime,
      end: fields[5] as DateTime,
      eventLastModified: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.location)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.teacher)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.start)
      ..writeByte(5)
      ..write(obj.end)
      ..writeByte(6)
      ..write(obj.eventLastModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
