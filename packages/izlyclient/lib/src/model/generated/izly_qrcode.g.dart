// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../izly_qrcode.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$IzlyQrCodeCWProxy {
  IzlyQrCode qrCode(Uint8List qrCode);

  IzlyQrCode expirationDate(DateTime expirationDate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `IzlyQrCode(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// IzlyQrCode(...).copyWith(id: 12, name: "My name")
  /// ````
  IzlyQrCode call({
    Uint8List? qrCode,
    DateTime? expirationDate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfIzlyQrCode.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfIzlyQrCode.copyWith.fieldName(...)`
class _$IzlyQrCodeCWProxyImpl implements _$IzlyQrCodeCWProxy {
  const _$IzlyQrCodeCWProxyImpl(this._value);

  final IzlyQrCode _value;

  @override
  IzlyQrCode qrCode(Uint8List qrCode) => this(qrCode: qrCode);

  @override
  IzlyQrCode expirationDate(DateTime expirationDate) =>
      this(expirationDate: expirationDate);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `IzlyQrCode(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// IzlyQrCode(...).copyWith(id: 12, name: "My name")
  /// ````
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
  /// Returns a callable class that can be used as follows: `instanceOfIzlyQrCode.copyWith(...)` or like so:`instanceOfIzlyQrCode.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$IzlyQrCodeCWProxy get copyWith => _$IzlyQrCodeCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IzlyQrCodeAdapter extends TypeAdapter<IzlyQrCode> {
  @override
  final int typeId = 16;

  @override
  IzlyQrCode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IzlyQrCode(
      qrCode: fields[0] as Uint8List,
      expirationDate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, IzlyQrCode obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.qrCode)
      ..writeByte(1)
      ..write(obj.expirationDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IzlyQrCodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
