// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TextModelAdapter extends TypeAdapter<TextModel> {
  @override
  final int typeId = 9;

  @override
  TextModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TextModel(
      name: fields[0] as String,
      value: fields[1] as String,
      author: fields[2] as String,
      comment: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TextModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.comment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
