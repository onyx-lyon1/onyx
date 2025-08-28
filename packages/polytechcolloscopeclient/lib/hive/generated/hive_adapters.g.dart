// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final typeId = 44;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      fields[0] as Year,
      fields[1] as String,
      (fields[2] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class KholleAdapter extends TypeAdapter<Kholle> {
  @override
  final typeId = 45;

  @override
  Kholle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kholle(
      fields[0] as DateTime,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String?,
      fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Kholle obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.kholleur)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.room);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KholleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StudentColloscopeAdapter extends TypeAdapter<StudentColloscope> {
  @override
  final typeId = 46;

  @override
  StudentColloscope read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentColloscope(
      fields[0] as Student,
      (fields[1] as num).toInt(),
      (fields[2] as List).cast<Kholle>(),
    );
  }

  @override
  void write(BinaryWriter writer, StudentColloscope obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.student)
      ..writeByte(1)
      ..write(obj.trinomeId)
      ..writeByte(2)
      ..write(obj.kholles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentColloscopeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class YearAdapter extends TypeAdapter<Year> {
  @override
  final typeId = 47;

  @override
  Year read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Year.first;
      case 1:
        return Year.second;
      default:
        return Year.first;
    }
  }

  @override
  void write(BinaryWriter writer, Year obj) {
    switch (obj) {
      case Year.first:
        writer.writeByte(0);
      case Year.second:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YearAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
