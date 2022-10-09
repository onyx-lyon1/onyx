// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_model_wrapper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmailModelWrapperAdapter extends TypeAdapter<EmailModelWrapper> {
  @override
  final int typeId = 11;

  @override
  EmailModelWrapper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmailModelWrapper(
      (fields[0] as List).cast<EmailModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, EmailModelWrapper obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.emailModels);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailModelWrapperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
