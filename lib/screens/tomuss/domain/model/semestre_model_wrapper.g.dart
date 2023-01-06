// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semestre_model_wrapper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SemestreModelWrapperAdapter extends TypeAdapter<SemestreModelWrapper> {
  @override
  final int typeId = 14;

  @override
  SemestreModelWrapper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SemestreModelWrapper(
      (fields[0] as List).cast<SemestreModel>(),
      currentSemestreIndex: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SemestreModelWrapper obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.semestres)
      ..writeByte(1)
      ..write(obj.currentSemestreIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemestreModelWrapperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
