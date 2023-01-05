// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester_model_wrapper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SemesterModelWrapperAdapter extends TypeAdapter<SemesterModelWrapper> {
  @override
  final int typeId = 14;

  @override
  SemesterModelWrapper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SemesterModelWrapper(
      (fields[0] as List).cast<SemesterModel>(),
      currentSemesterIndex: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SemesterModelWrapper obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.semesters)
      ..writeByte(1)
      ..write(obj.currentSemesterIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemesterModelWrapperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
