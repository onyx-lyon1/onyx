// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../izly_qrcode.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$IzlyQrCodeCWProxy {
  IzlyQrCode qrCode(Uint8List qrCode);

  IzlyQrCode expirationDate(DateTime expirationDate);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `IzlyQrCode(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// IzlyQrCode(...).copyWith(id: 12, name: "My name")
  /// ```
  IzlyQrCode call({
    Uint8List qrCode,
    DateTime expirationDate,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfIzlyQrCode.copyWith(...)` or call `instanceOfIzlyQrCode.copyWith.fieldName(value)` for a single field.
class _$IzlyQrCodeCWProxyImpl implements _$IzlyQrCodeCWProxy {
  const _$IzlyQrCodeCWProxyImpl(this._value);

  final IzlyQrCode _value;

  @override
  IzlyQrCode qrCode(Uint8List qrCode) => call(qrCode: qrCode);

  @override
  IzlyQrCode expirationDate(DateTime expirationDate) =>
      call(expirationDate: expirationDate);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `IzlyQrCode(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// IzlyQrCode(...).copyWith(id: 12, name: "My name")
  /// ```
  IzlyQrCode call({
    Object? qrCode = const $CopyWithPlaceholder(),
    Object? expirationDate = const $CopyWithPlaceholder(),
  }) {
    return IzlyQrCode(
      qrCode: qrCode == const $CopyWithPlaceholder() || qrCode == null
          ? _value.qrCode
          // ignore: cast_nullable_to_non_nullable
          : qrCode as Uint8List,
      expirationDate: expirationDate == const $CopyWithPlaceholder() ||
              expirationDate == null
          ? _value.expirationDate
          // ignore: cast_nullable_to_non_nullable
          : expirationDate as DateTime,
    );
  }
}

extension $IzlyQrCodeCopyWith on IzlyQrCode {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfIzlyQrCode.copyWith(...)` or `instanceOfIzlyQrCode.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$IzlyQrCodeCWProxy get copyWith => _$IzlyQrCodeCWProxyImpl(this);
}
