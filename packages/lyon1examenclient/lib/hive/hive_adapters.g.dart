// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class ExamenModelAdapter extends TypeAdapter<ExamenModel> {
  @override
  final typeId = 48;

  @override
  ExamenModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExamenModel(
      title: fields[0] == null ? '' : fields[0] as String?,
      codeName: fields[1] == null ? '' : fields[1] as String,
      date: fields[2] as DateTime?,
      duration:
          fields[3] == null ? const Duration(hours: 2) : fields[3] as Duration?,
      location: fields[4] == null ? '' : fields[4] as String?,
      place: fields[5] == null ? 0 : (fields[5] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, ExamenModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.codeName)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.place);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExamenListModelAdapter extends TypeAdapter<ExamenListModel> {
  @override
  final typeId = 49;

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
