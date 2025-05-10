// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../credential.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CredentialCWProxy {
  Credential username(String username);

  Credential password(String password);

  Credential tgcToken(String tgcToken);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Credential(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Credential(...).copyWith(id: 12, name: "My name")
  /// ```
  Credential call({
    String username,
    String password,
    String tgcToken,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCredential.copyWith(...)` or call `instanceOfCredential.copyWith.fieldName(value)` for a single field.
class _$CredentialCWProxyImpl implements _$CredentialCWProxy {
  const _$CredentialCWProxyImpl(this._value);

  final Credential _value;

  @override
  Credential username(String username) => call(username: username);

  @override
  Credential password(String password) => call(password: password);

  @override
  Credential tgcToken(String tgcToken) => call(tgcToken: tgcToken);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Credential(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Credential(...).copyWith(id: 12, name: "My name")
  /// ```
  Credential call({
    Object? username = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? tgcToken = const $CopyWithPlaceholder(),
  }) {
    return Credential(
      username == const $CopyWithPlaceholder()
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
      password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      tgcToken: tgcToken == const $CopyWithPlaceholder()
          ? _value.tgcToken
          // ignore: cast_nullable_to_non_nullable
          : tgcToken as String,
    );
  }
}

extension $CredentialCopyWith on Credential {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCredential.copyWith(...)` or `instanceOfCredential.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CredentialCWProxy get copyWith => _$CredentialCWProxyImpl(this);
}
