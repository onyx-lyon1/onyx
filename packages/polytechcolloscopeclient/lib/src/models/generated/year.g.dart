// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../year.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YearAdapter extends TypeAdapter<Year> {
  @override
  final int typeId = 47;

  @override
  Year read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Year.first;
      case 1:
        return Year.second;
      default:
        return Year.first;
    }
  }

  @override
  void write(BinaryWriter writer, Year obj) {
    switch (obj) {
      case Year.first:
        writer.writeByte(0);
        break;
      case Year.second:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YearAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
