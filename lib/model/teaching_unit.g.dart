// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teaching_unit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeachingUnitModelAdapter extends TypeAdapter<TeachingUnitModel> {
  @override
  final int typeId = 8;

  @override
  TeachingUnitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeachingUnitModel(
      isSeen: fields[4] as bool,
      isHidden: fields[5] as bool,
      name: fields[0] as String,
      masters: (fields[1] as List).cast<TeacherModel>(),
      grades: (fields[2] as List).cast<GradeModel>(),
      textValues: (fields[3] as List).cast<TextModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TeachingUnitModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.masters)
      ..writeByte(2)
      ..write(obj.grades)
      ..writeByte(3)
      ..write(obj.textValues)
      ..writeByte(4)
      ..write(obj.isSeen)
      ..writeByte(5)
      ..write(obj.isHidden);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeachingUnitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
