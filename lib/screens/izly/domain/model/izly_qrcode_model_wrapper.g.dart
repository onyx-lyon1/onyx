// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'izly_qrcode_model_wrapper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IzlyQrCodeModelWrapperAdapter
    extends TypeAdapter<IzlyQrCodeModelWrapper> {
  @override
  final int typeId = 16;

  @override
  IzlyQrCodeModelWrapper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IzlyQrCodeModelWrapper(
      qrCodes: (fields[0] as List).cast<IzlyQrCodeModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, IzlyQrCodeModelWrapper obj) {
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
      other is IzlyQrCodeModelWrapperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
