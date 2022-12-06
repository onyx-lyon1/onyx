// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_subject_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SchoolSubjectModelAdapter extends TypeAdapter<SchoolSubjectModel> {
  @override
  final int typeId = 10;

  @override
  SchoolSubjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SchoolSubjectModel(
      isSeen: fields[4] as bool,
      isHidden: fields[5] as bool,
      name: fields[0] as String,
      masters: (fields[1] as List).cast<TeacherModel>(),
      grades: (fields[2] as List).cast<GradeModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SchoolSubjectModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.masters)
      ..writeByte(2)
      ..write(obj.grades)
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
      other is SchoolSubjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
