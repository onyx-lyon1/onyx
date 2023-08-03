// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../izly_qrcode_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$IzlyQrCodeListCWProxy {
  IzlyQrCodeList qrCodes(List<IzlyQrCode> qrCodes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `IzlyQrCodeList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// IzlyQrCodeList(...).copyWith(id: 12, name: "My name")
  /// ````
  IzlyQrCodeList call({
    List<IzlyQrCode>? qrCodes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfIzlyQrCodeList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfIzlyQrCodeList.copyWith.fieldName(...)`
class _$IzlyQrCodeListCWProxyImpl implements _$IzlyQrCodeListCWProxy {
  const _$IzlyQrCodeListCWProxyImpl(this._value);

  final IzlyQrCodeList _value;

  @override
  IzlyQrCodeList qrCodes(List<IzlyQrCode> qrCodes) => this(qrCodes: qrCodes);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `IzlyQrCodeList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// IzlyQrCodeList(...).copyWith(id: 12, name: "My name")
  /// ````
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
  /// Returns a callable class that can be used as follows: `instanceOfIzlyQrCodeList.copyWith(...)` or like so:`instanceOfIzlyQrCodeList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$IzlyQrCodeListCWProxy get copyWith => _$IzlyQrCodeListCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IzlyQrCodeListAdapter extends TypeAdapter<IzlyQrCodeList> {
  @override
  final int typeId = 17;

  @override
  IzlyQrCodeList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IzlyQrCodeList(
      qrCodes: (fields[0] as List).cast<IzlyQrCode>(),
    );
  }

  @override
  void write(BinaryWriter writer, IzlyQrCodeList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.qrCodes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IzlyQrCodeListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
