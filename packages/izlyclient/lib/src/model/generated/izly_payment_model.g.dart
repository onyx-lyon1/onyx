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
      paymentTime: fields[3] as DateTime,
      amountSpent: fields[4] as double,
      isSucess: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, IzlyPaymentModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(3)
      ..write(obj.paymentTime)
      ..writeByte(4)
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
