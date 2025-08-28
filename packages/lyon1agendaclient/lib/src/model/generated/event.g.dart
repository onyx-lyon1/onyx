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

  Event menuCrous(dynamic menuCrous);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Event(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Event(...).copyWith(id: 12, name: "My name")
  /// ```
  Event call({
    String location,
    String description,
    String teacher,
    String name,
    DateTime start,
    DateTime end,
    dynamic menuCrous,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEvent.copyWith(...)` or call `instanceOfEvent.copyWith.fieldName(value)` for a single field.
class _$EventCWProxyImpl implements _$EventCWProxy {
  const _$EventCWProxyImpl(this._value);

  final Event _value;

  @override
  Event location(String location) => call(location: location);

  @override
  Event description(String description) => call(description: description);

  @override
  Event teacher(String teacher) => call(teacher: teacher);

  @override
  Event name(String name) => call(name: name);

  @override
  Event start(DateTime start) => call(start: start);

  @override
  Event end(DateTime end) => call(end: end);

  @override
  Event menuCrous(dynamic menuCrous) => call(menuCrous: menuCrous);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Event(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Event(...).copyWith(id: 12, name: "My name")
  /// ```
  Event call({
    Object? location = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? teacher = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? start = const $CopyWithPlaceholder(),
    Object? end = const $CopyWithPlaceholder(),
    Object? menuCrous = const $CopyWithPlaceholder(),
  }) {
    return Event(
      location: location == const $CopyWithPlaceholder()
          ? _value.location
          // ignore: cast_nullable_to_non_nullable
          : location as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
      teacher: teacher == const $CopyWithPlaceholder()
          ? _value.teacher
          // ignore: cast_nullable_to_non_nullable
          : teacher as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      start: start == const $CopyWithPlaceholder()
          ? _value.start
          // ignore: cast_nullable_to_non_nullable
          : start as DateTime,
      end: end == const $CopyWithPlaceholder()
          ? _value.end
          // ignore: cast_nullable_to_non_nullable
          : end as DateTime,
      menuCrous: menuCrous == const $CopyWithPlaceholder()
          ? _value.menuCrous
          // ignore: cast_nullable_to_non_nullable
          : menuCrous as dynamic,
    );
  }
}

extension $EventCopyWith on Event {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEvent.copyWith(...)` or `instanceOfEvent.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EventCWProxy get copyWith => _$EventCWProxyImpl(this);
}
