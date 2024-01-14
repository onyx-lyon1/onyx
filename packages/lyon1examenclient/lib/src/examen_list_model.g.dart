// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'examen_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExamenListModelAdapter extends TypeAdapter<ExamenListModel> {
  @override
  final int typeId = 49;

  @override
  ExamenListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExamenListModel(
      (fields[0] as List).cast<ExamenModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExamenListModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.examens);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamenListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
