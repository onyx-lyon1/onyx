// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_box_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MailBoxModelAdapter extends TypeAdapter<MailBoxModel> {
  @override
  final int typeId = 19;

  @override
  MailBoxModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MailBoxModel(
      name: fields[0] as String,
      emails: (fields[2] as List).cast<EmailModel>(),
      specialMailBox: fields[1] as SpecialMailBox?,
    );
  }

  @override
  void write(BinaryWriter writer, MailBoxModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.specialMailBox)
      ..writeByte(2)
      ..write(obj.emails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MailBoxModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpecialMailBoxAdapter extends TypeAdapter<SpecialMailBox> {
  @override
  final int typeId = 20;

  @override
  SpecialMailBox read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SpecialMailBox.inbox;
      case 1:
        return SpecialMailBox.sent;
      case 2:
        return SpecialMailBox.trash;
      case 3:
        return SpecialMailBox.flagged;
      case 4:
        return SpecialMailBox.archive;
      default:
        return SpecialMailBox.inbox;
    }
  }

  @override
  void write(BinaryWriter writer, SpecialMailBox obj) {
    switch (obj) {
      case SpecialMailBox.inbox:
        writer.writeByte(0);
        break;
      case SpecialMailBox.sent:
        writer.writeByte(1);
        break;
      case SpecialMailBox.trash:
        writer.writeByte(2);
        break;
      case SpecialMailBox.flagged:
        writer.writeByte(3);
        break;
      case SpecialMailBox.archive:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecialMailBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
