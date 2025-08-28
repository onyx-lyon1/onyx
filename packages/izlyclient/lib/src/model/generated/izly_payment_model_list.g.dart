// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../izly_payment_model_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$IzlyPaymentModelListCWProxy {
  IzlyPaymentModelList payments(List<IzlyPaymentModel> payments);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `IzlyPaymentModelList(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// IzlyPaymentModelList(...).copyWith(id: 12, name: "My name")
  /// ```
  IzlyPaymentModelList call({
    List<IzlyPaymentModel> payments,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfIzlyPaymentModelList.copyWith(...)` or call `instanceOfIzlyPaymentModelList.copyWith.fieldName(value)` for a single field.
class _$IzlyPaymentModelListCWProxyImpl
    implements _$IzlyPaymentModelListCWProxy {
  const _$IzlyPaymentModelListCWProxyImpl(this._value);

  final IzlyPaymentModelList _value;

  @override
  IzlyPaymentModelList payments(List<IzlyPaymentModel> payments) =>
      call(payments: payments);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `IzlyPaymentModelList(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// IzlyPaymentModelList(...).copyWith(id: 12, name: "My name")
  /// ```
  IzlyPaymentModelList call({
    Object? payments = const $CopyWithPlaceholder(),
  }) {
    return IzlyPaymentModelList(
      payments: payments == const $CopyWithPlaceholder() || payments == null
          ? _value.payments
          // ignore: cast_nullable_to_non_nullable
          : payments as List<IzlyPaymentModel>,
    );
  }
}

extension $IzlyPaymentModelListCopyWith on IzlyPaymentModelList {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfIzlyPaymentModelList.copyWith(...)` or `instanceOfIzlyPaymentModelList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$IzlyPaymentModelListCWProxy get copyWith =>
      _$IzlyPaymentModelListCWProxyImpl(this);
}
