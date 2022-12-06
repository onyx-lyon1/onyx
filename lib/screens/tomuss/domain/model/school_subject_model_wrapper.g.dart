// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_subject_model_wrapper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SchoolSubjectModelWrapperAdapter
    extends TypeAdapter<SchoolSubjectModelWrapper> {
  @override
  final int typeId = 11;

  @override
  SchoolSubjectModelWrapper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SchoolSubjectModelWrapper(
      (fields[0] as List).cast<SchoolSubjectModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SchoolSubjectModelWrapper obj) {
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
      other is SchoolSubjectModelWrapperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
