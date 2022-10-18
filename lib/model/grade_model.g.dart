// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GradeModelAdapter extends TypeAdapter<GradeModel> {
  @override
  final int typeId = 4;

  @override
  GradeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GradeModel(
      name: fields[0] as String,
      author: fields[1] as String,
      groupSize: fields[7] as int,
      gradeNumerator: fields[2] as double,
      gradeDenominator: fields[3] as double,
      rank: fields[4] as int,
      average: fields[5] as double,
      mediane: fields[6] as double,
      isValidGrade: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GradeModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.gradeNumerator)
      ..writeByte(3)
      ..write(obj.gradeDenominator)
      ..writeByte(4)
      ..write(obj.rank)
      ..writeByte(5)
      ..write(obj.average)
      ..writeByte(6)
      ..write(obj.mediane)
      ..writeByte(7)
      ..write(obj.groupSize)
      ..writeByte(8)
      ..write(obj.isValidGrade);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
