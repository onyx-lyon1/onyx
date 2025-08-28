// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../izly_qrcode_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$IzlyQrCodeListCWProxy {
  IzlyQrCodeList qrCodes(List<IzlyQrCode> qrCodes);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `IzlyQrCodeList(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// IzlyQrCodeList(...).copyWith(id: 12, name: "My name")
  /// ```
  IzlyQrCodeList call({
    List<IzlyQrCode> qrCodes,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfIzlyQrCodeList.copyWith(...)` or call `instanceOfIzlyQrCodeList.copyWith.fieldName(value)` for a single field.
class _$IzlyQrCodeListCWProxyImpl implements _$IzlyQrCodeListCWProxy {
  const _$IzlyQrCodeListCWProxyImpl(this._value);

  final IzlyQrCodeList _value;

  @override
  IzlyQrCodeList qrCodes(List<IzlyQrCode> qrCodes) => call(qrCodes: qrCodes);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `IzlyQrCodeList(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// IzlyQrCodeList(...).copyWith(id: 12, name: "My name")
  /// ```
  IzlyQrCodeList call({
    Object? qrCodes = const $CopyWithPlaceholder(),
  }) {
    return IzlyQrCodeList(
      qrCodes: qrCodes == const $CopyWithPlaceholder() || qrCodes == null
          ? _value.qrCodes
          // ignore: cast_nullable_to_non_nullable
          : qrCodes as List<IzlyQrCode>,
    );
  }
}

extension $IzlyQrCodeListCopyWith on IzlyQrCodeList {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfIzlyQrCodeList.copyWith(...)` or `instanceOfIzlyQrCodeList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$IzlyQrCodeListCWProxy get copyWith => _$IzlyQrCodeListCWProxyImpl(this);
}
