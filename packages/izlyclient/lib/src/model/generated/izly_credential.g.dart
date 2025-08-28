// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../izly_credential.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$IzlyCredentialCWProxy {
  IzlyCredential username(String username);

  IzlyCredential password(String password);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `IzlyCredential(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// IzlyCredential(...).copyWith(id: 12, name: "My name")
  /// ```
  IzlyCredential call({
    String username,
    String password,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfIzlyCredential.copyWith(...)` or call `instanceOfIzlyCredential.copyWith.fieldName(value)` for a single field.
class _$IzlyCredentialCWProxyImpl implements _$IzlyCredentialCWProxy {
  const _$IzlyCredentialCWProxyImpl(this._value);

  final IzlyCredential _value;

  @override
  IzlyCredential username(String username) => call(username: username);

  @override
  IzlyCredential password(String password) => call(password: password);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `IzlyCredential(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// IzlyCredential(...).copyWith(id: 12, name: "My name")
  /// ```
  IzlyCredential call({
    Object? username = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
  }) {
    return IzlyCredential(
      username: username == const $CopyWithPlaceholder() || username == null
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
    );
  }
}

extension $IzlyCredentialCopyWith on IzlyCredential {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfIzlyCredential.copyWith(...)` or `instanceOfIzlyCredential.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$IzlyCredentialCWProxy get copyWith => _$IzlyCredentialCWProxyImpl(this);
}
