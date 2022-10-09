// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_model_wrapper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayModelWrapperAdapter extends TypeAdapter<DayModelWrapper> {
  @override
  final int typeId = 10;

  @override
  DayModelWrapper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayModelWrapper(
      (fields[0] as List).cast<DayModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DayModelWrapper obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.dayModels);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayModelWrapperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
