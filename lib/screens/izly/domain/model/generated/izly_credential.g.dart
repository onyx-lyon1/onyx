// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../izly_credential.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IzlyCredentialAdapter extends TypeAdapter<IzlyCredential> {
  @override
  final int typeId = 15;

  @override
  IzlyCredential read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IzlyCredential(
      username: fields[0] as String,
      password: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, IzlyCredential obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IzlyCredentialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
