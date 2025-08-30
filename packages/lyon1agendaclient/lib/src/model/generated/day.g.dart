// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../day.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DayCWProxy {
  Day date(DateTime date);

  Day events(List<Event> events);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Day(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Day(...).copyWith(id: 12, name: "My name")
  /// ```
  Day call({DateTime date, List<Event> events});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDay.copyWith(...)` or call `instanceOfDay.copyWith.fieldName(value)` for a single field.
class _$DayCWProxyImpl implements _$DayCWProxy {
  const _$DayCWProxyImpl(this._value);

  final Day _value;

  @override
  Day date(DateTime date) => call(date: date);

  @override
  Day events(List<Event> events) => call(events: events);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Day(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Day(...).copyWith(id: 12, name: "My name")
  /// ```
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDay.copyWith(...)` or `instanceOfDay.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DayCWProxy get copyWith => _$DayCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Day _$DayFromJson(Map<String, dynamic> json) => Day(
  DateTime.parse(json['date'] as String),
  (json['events'] as List<dynamic>)
      .map((e) => Event.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
  'events': instance.events,
  'date': instance.date.toIso8601String(),
};
