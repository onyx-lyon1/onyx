// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class MailAdapter extends TypeAdapter<Mail> {
  @override
  final typeId = 5;

  @override
  Mail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mail(
      subject: fields[0] as String,
      sender: fields[1] as String,
      excerpt: fields[2] as String,
      isRead: fields[5] as bool,
      date: fields[7] as DateTime,
      body: fields[3] as String,
      id: (fields[4] as num?)?.toInt(),
      receiver: fields[8] as String,
      attachments: (fields[9] as List).cast<String>(),
      isFlagged: fields[6] as bool,
      attachmentsFiles:
          fields[10] == null ? const [] : (fields[10] as List).cast<File>(),
      rawMail: fields[11] as MimeMessage?,
    );
  }

  @override
  void write(BinaryWriter writer, Mail obj) {
    writer
      ..writeByte(12)
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
      ..write(obj.isFlagged)
      ..writeByte(7)
      ..write(obj.date)
      ..writeByte(8)
      ..write(obj.receiver)
      ..writeByte(9)
      ..write(obj.attachments)
      ..writeByte(10)
      ..write(obj.attachmentsFiles)
      ..writeByte(11)
      ..write(obj.rawMail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MailBoxAdapter extends TypeAdapter<MailBox> {
  @override
  final typeId = 19;

  @override
  MailBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MailBox(
      name: fields[0] as String,
      emails: (fields[2] as List).cast<Mail>(),
      specialMailBox: fields[1] as SpecialMailBox?,
    );
  }

  @override
  void write(BinaryWriter writer, MailBox obj) {
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
      other is MailBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpecialMailBoxAdapter extends TypeAdapter<SpecialMailBox> {
  @override
  final typeId = 20;

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
      case SpecialMailBox.sent:
        writer.writeByte(1);
      case SpecialMailBox.trash:
        writer.writeByte(2);
      case SpecialMailBox.flagged:
        writer.writeByte(3);
      case SpecialMailBox.archive:
        writer.writeByte(4);
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

class MailBoxListAdapter extends TypeAdapter<MailBoxList> {
  @override
  final typeId = 21;

  @override
  MailBoxList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MailBoxList(
      mailBoxes: (fields[0] as List).cast<MailBox>(),
    );
  }

  @override
  void write(BinaryWriter writer, MailBoxList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.mailBoxes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MailBoxListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ActionTypeAdapter extends TypeAdapter<ActionType> {
  @override
  final typeId = 22;

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
      case ActionType.markAsRead:
        writer.writeByte(1);
      case ActionType.markAsUnread:
        writer.writeByte(2);
      case ActionType.move:
        writer.writeByte(3);
      case ActionType.send:
        writer.writeByte(4);
      case ActionType.reply:
        writer.writeByte(5);
      case ActionType.forward:
        writer.writeByte(7);
      case ActionType.delete:
        writer.writeByte(8);
      case ActionType.flag:
        writer.writeByte(9);
      case ActionType.unflag:
        writer.writeByte(10);
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

class ActionAdapter extends TypeAdapter<Action> {
  @override
  final typeId = 23;

  @override
  Action read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Action(
      type: fields[0] as ActionType,
      mail: fields[4] as Mail,
      fromMailBox: fields[1] as MailBox?,
      originalMessageId: (fields[5] as num?)?.toInt(),
      replyAll: fields[6] as bool?,
      destinationMailBox: fields[8] as MailBox?,
    );
  }

  @override
  void write(BinaryWriter writer, Action obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.fromMailBox)
      ..writeByte(4)
      ..write(obj.mail)
      ..writeByte(5)
      ..write(obj.originalMessageId)
      ..writeByte(6)
      ..write(obj.replyAll)
      ..writeByte(8)
      ..write(obj.destinationMailBox);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ActionListAdapter extends TypeAdapter<ActionList> {
  @override
  final typeId = 24;

  @override
  ActionList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActionList(
      action: (fields[0] as List).cast<Action>(),
    );
  }

  @override
  void write(BinaryWriter writer, ActionList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.action);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActionListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
