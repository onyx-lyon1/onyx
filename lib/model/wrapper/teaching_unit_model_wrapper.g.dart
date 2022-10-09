// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teaching_unit_model_wrapper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeachingUnitModelWrapperAdapter
    extends TypeAdapter<TeachingUnitModelWrapper> {
  @override
  final int typeId = 12;

  @override
  TeachingUnitModelWrapper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeachingUnitModelWrapper(
      (fields[0] as List).cast<TeachingUnitModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TeachingUnitModelWrapper obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.teachingUnitModels);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeachingUnitModelWrapperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
