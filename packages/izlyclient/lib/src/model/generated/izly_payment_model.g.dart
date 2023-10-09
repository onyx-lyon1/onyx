// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../izly_payment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IzlyPaymentModelAdapter extends TypeAdapter<IzlyPaymentModel> {
  @override
  final int typeId = 40;

  @override
  IzlyPaymentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IzlyPaymentModel(
      paymentTime: fields[0] as String,
      amountSpent: fields[1] as String,
      isSucess: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, IzlyPaymentModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.paymentTime)
      ..writeByte(1)
      ..write(obj.amountSpent)
      ..writeByte(2)
      ..write(obj.isSucess);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IzlyPaymentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
