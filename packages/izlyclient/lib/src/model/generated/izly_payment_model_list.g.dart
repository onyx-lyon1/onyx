// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../izly_payment_model_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$IzlyPaymentModelListCWProxy {
  IzlyPaymentModelList payments(List<IzlyPaymentModel> payments);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `IzlyPaymentModelList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// IzlyPaymentModelList(...).copyWith(id: 12, name: "My name")
  /// ````
  IzlyPaymentModelList call({
    List<IzlyPaymentModel>? payments,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfIzlyPaymentModelList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfIzlyPaymentModelList.copyWith.fieldName(...)`
class _$IzlyPaymentModelListCWProxyImpl
    implements _$IzlyPaymentModelListCWProxy {
  const _$IzlyPaymentModelListCWProxyImpl(this._value);

  final IzlyPaymentModelList _value;

  @override
  IzlyPaymentModelList payments(List<IzlyPaymentModel> payments) =>
      this(payments: payments);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `IzlyPaymentModelList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// IzlyPaymentModelList(...).copyWith(id: 12, name: "My name")
  /// ````
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
  /// Returns a callable class that can be used as follows: `instanceOfIzlyPaymentModelList.copyWith(...)` or like so:`instanceOfIzlyPaymentModelList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$IzlyPaymentModelListCWProxy get copyWith =>
      _$IzlyPaymentModelListCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IzlyPaymentModelListAdapter extends TypeAdapter<IzlyPaymentModelList> {
  @override
  final int typeId = 41;

  @override
  IzlyPaymentModelList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IzlyPaymentModelList(
      payments: (fields[0] as List).cast<IzlyPaymentModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, IzlyPaymentModelList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.payments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IzlyPaymentModelListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
