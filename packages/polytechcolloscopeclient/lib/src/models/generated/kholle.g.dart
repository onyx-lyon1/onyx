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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Kholle(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Kholle(...).copyWith(id: 12, name: "My name")
  /// ```
  Kholle call({
    DateTime date,
    String subject,
    String kholleur,
    String? message,
    String? room,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfKholle.copyWith(...)` or call `instanceOfKholle.copyWith.fieldName(value)` for a single field.
class _$KholleCWProxyImpl implements _$KholleCWProxy {
  const _$KholleCWProxyImpl(this._value);

  final Kholle _value;

  @override
  Kholle date(DateTime date) => call(date: date);

  @override
  Kholle subject(String subject) => call(subject: subject);

  @override
  Kholle kholleur(String kholleur) => call(kholleur: kholleur);

  @override
  Kholle message(String? message) => call(message: message);

  @override
  Kholle room(String? room) => call(room: room);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Kholle(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Kholle(...).copyWith(id: 12, name: "My name")
  /// ```
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfKholle.copyWith(...)` or `instanceOfKholle.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$KholleCWProxy get copyWith => _$KholleCWProxyImpl(this);
}
