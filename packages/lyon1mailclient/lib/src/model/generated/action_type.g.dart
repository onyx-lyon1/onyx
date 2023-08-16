// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../action_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActionTypeAdapter extends TypeAdapter<ActionType> {
  @override
  final int typeId = 22;

  @override
  ActionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ActionType.archive;
      case 1:
        return ActionType.markAsRead;
      case 2:
        return ActionType.markAsUnread;
      case 3:
        return ActionType.move;
      case 4:
        return ActionType.send;
      case 5:
        return ActionType.reply;
      case 7:
        return ActionType.forward;
      case 8:
        return ActionType.delete;
      case 9:
        return ActionType.flag;
      case 10:
        return ActionType.unflag;
      default:
        return ActionType.archive;
    }
  }

  @override
  void write(BinaryWriter writer, ActionType obj) {
    switch (obj) {
      case ActionType.archive:
        writer.writeByte(0);
        break;
      case ActionType.markAsRead:
        writer.writeByte(1);
        break;
      case ActionType.markAsUnread:
        writer.writeByte(2);
        break;
      case ActionType.move:
        writer.writeByte(3);
        break;
      case ActionType.send:
        writer.writeByte(4);
        break;
      case ActionType.reply:
        writer.writeByte(5);
        break;
      case ActionType.forward:
        writer.writeByte(7);
        break;
      case ActionType.delete:
        writer.writeByte(8);
        break;
      case ActionType.flag:
        writer.writeByte(9);
        break;
      case ActionType.unflag:
        writer.writeByte(10);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
