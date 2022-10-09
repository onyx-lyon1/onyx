// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmailModelAdapter extends TypeAdapter<EmailModel> {
  @override
  final int typeId = 5;

  @override
  EmailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmailModel(
      subject: fields[0] as String,
      sender: fields[1] as String,
      excerpt: fields[2] as String,
      isRead: fields[5] as bool,
      date: fields[6] as DateTime,
      body: fields[3] as String,
      id: fields[4] as int?,
      receiver: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EmailModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.subject)
      ..writeByte(1)
      ..write(obj.sender)
      ..writeByte(2)
      ..write(obj.excerpt)
      ..writeByte(3)
      ..write(obj.body)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.isRead)
      ..writeByte(6)
      ..write(obj.date)
      ..writeByte(7)
      ..write(obj.receiver);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
