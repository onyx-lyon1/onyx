// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../action_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActionModelAdapter extends TypeAdapter<ActionModel> {
  @override
  final int typeId = 23;

  @override
  ActionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActionModel(
      type: fields[0] as ActionType,
      fromMailBox: fields[1] as MailBoxModel,
      email: fields[4] as EmailModel?,
      originalMessageId: fields[5] as int?,
      replyAll: fields[6] as bool?,
      emailNumber: fields[7] as int?,
      destinationMailBox: fields[8] as MailBoxModel?,
    );
  }

  @override
  void write(BinaryWriter writer, ActionModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.fromMailBox)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.originalMessageId)
      ..writeByte(6)
      ..write(obj.replyAll)
      ..writeByte(7)
      ..write(obj.emailNumber)
      ..writeByte(8)
      ..write(obj.destinationMailBox);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
