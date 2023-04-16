// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_box_wrapper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MailBoxWrapperAdapter extends TypeAdapter<MailBoxWrapper> {
  @override
  final int typeId = 21;

  @override
  MailBoxWrapper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MailBoxWrapper(
      mailBoxes: (fields[0] as List).cast<MailBoxModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, MailBoxWrapper obj) {
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
      other is MailBoxWrapperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
