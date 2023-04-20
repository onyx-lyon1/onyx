// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../action_model_wrapper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActionModelWrapperAdapter extends TypeAdapter<ActionModelWrapper> {
  @override
  final int typeId = 24;

  @override
  ActionModelWrapper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActionModelWrapper(
      action: (fields[0] as List).cast<ActionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ActionModelWrapper obj) {
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
      other is ActionModelWrapperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
