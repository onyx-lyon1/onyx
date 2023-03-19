// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_model.dart';

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
      date: fields[7] as DateTime,
      body: fields[3] as String,
      blackBody: fields[10] == null ? '' : fields[10] as String,
      id: fields[4] as int?,
      receiver: fields[8] as String,
      attachments: (fields[9] as List).cast<String>(),
      isFlagged: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, EmailModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.subject)
      ..writeByte(1)
      ..write(obj.sender)
      ..writeByte(2)
      ..write(obj.excerpt)
      ..writeByte(3)
      ..write(obj.body)
      ..writeByte(10)
      ..write(obj.blackBody)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.isRead)
      ..writeByte(6)
      ..write(obj.isFlagged)
      ..writeByte(7)
      ..write(obj.date)
      ..writeByte(8)
      ..write(obj.receiver)
      ..writeByte(9)
      ..write(obj.attachments);
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
