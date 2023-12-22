// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../res.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FunctionalitiesAdapter extends TypeAdapter<Functionalities> {
  @override
  final int typeId = 18;

  @override
  Functionalities read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Functionalities.tomuss;
      case 1:
        return Functionalities.agenda;
      case 2:
        return Functionalities.mail;
      case 3:
        return Functionalities.map;
      case 4:
        return Functionalities.izly;
      case 5:
        return Functionalities.settings;
      case 6:
        return Functionalities.colloscope;
      default:
        return Functionalities.tomuss;
    }
  }

  @override
  void write(BinaryWriter writer, Functionalities obj) {
    switch (obj) {
      case Functionalities.tomuss:
        writer.writeByte(0);
        break;
      case Functionalities.agenda:
        writer.writeByte(1);
        break;
      case Functionalities.mail:
        writer.writeByte(2);
        break;
      case Functionalities.map:
        writer.writeByte(3);
        break;
      case Functionalities.izly:
        writer.writeByte(4);
        break;
      case Functionalities.settings:
        writer.writeByte(5);
        break;
      case Functionalities.colloscope:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FunctionalitiesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
