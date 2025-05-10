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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Presence(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Presence(...).copyWith(id: 12, name: "My name")
  /// ```
  Presence call({
    String title,
    String author,
    DateTime? date,
    double position,
    String value,
    String? emptyIs,
    PresenceColor color,
    DateTime? visibilityDate,
    bool? visible,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPresence.copyWith(...)` or call `instanceOfPresence.copyWith.fieldName(value)` for a single field.
class _$PresenceCWProxyImpl implements _$PresenceCWProxy {
  const _$PresenceCWProxyImpl(this._value);

  final Presence _value;

  @override
  Presence title(String title) => call(title: title);

  @override
  Presence author(String author) => call(author: author);

  @override
  Presence date(DateTime? date) => call(date: date);

  @override
  Presence position(double position) => call(position: position);

  @override
  Presence value(String value) => call(value: value);

  @override
  Presence emptyIs(String? emptyIs) => call(emptyIs: emptyIs);

  @override
  Presence color(PresenceColor color) => call(color: color);

  @override
  Presence visibilityDate(DateTime? visibilityDate) =>
      call(visibilityDate: visibilityDate);

  @override
  Presence visible(bool? visible) => call(visible: visible);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Presence(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Presence(...).copyWith(id: 12, name: "My name")
  /// ```
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
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      author: author == const $CopyWithPlaceholder()
          ? _value.author
          // ignore: cast_nullable_to_non_nullable
          : author as String,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime?,
      position: position == const $CopyWithPlaceholder()
          ? _value.position
          // ignore: cast_nullable_to_non_nullable
          : position as double,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String,
      emptyIs: emptyIs == const $CopyWithPlaceholder()
          ? _value.emptyIs
          // ignore: cast_nullable_to_non_nullable
          : emptyIs as String?,
      color: color == const $CopyWithPlaceholder()
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPresence.copyWith(...)` or `instanceOfPresence.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PresenceCWProxy get copyWith => _$PresenceCWProxyImpl(this);
}
