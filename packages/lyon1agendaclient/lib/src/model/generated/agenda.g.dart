// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../agenda.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AgendaCWProxy {
  Agenda days(List<Day> days);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Agenda(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Agenda(...).copyWith(id: 12, name: "My name")
  /// ```
  Agenda call({
    List<Day> days,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAgenda.copyWith(...)` or call `instanceOfAgenda.copyWith.fieldName(value)` for a single field.
class _$AgendaCWProxyImpl implements _$AgendaCWProxy {
  const _$AgendaCWProxyImpl(this._value);

  final Agenda _value;

  @override
  Agenda days(List<Day> days) => call(days: days);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Agenda(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Agenda(...).copyWith(id: 12, name: "My name")
  /// ```
  Agenda call({
    Object? days = const $CopyWithPlaceholder(),
  }) {
    return Agenda(
      days == const $CopyWithPlaceholder()
          ? _value.days
          // ignore: cast_nullable_to_non_nullable
          : days as List<Day>,
    );
  }
}

extension $AgendaCopyWith on Agenda {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAgenda.copyWith(...)` or `instanceOfAgenda.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AgendaCWProxy get copyWith => _$AgendaCWProxyImpl(this);
}
