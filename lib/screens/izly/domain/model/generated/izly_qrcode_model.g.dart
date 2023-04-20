// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../izly_qrcode_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IzlyQrCodeModelAdapter extends TypeAdapter<IzlyQrCodeModel> {
  @override
  final int typeId = 16;

  @override
  IzlyQrCodeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IzlyQrCodeModel(
      qrCode: fields[0] as Uint8List,
      expirationDate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, IzlyQrCodeModel obj) {
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
      other is IzlyQrCodeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
