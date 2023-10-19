// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../action_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ActionListCWProxy {
  ActionList action(List<Action> action);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ActionList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ActionList(...).copyWith(id: 12, name: "My name")
  /// ````
  ActionList call({
    List<Action>? action,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfActionList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfActionList.copyWith.fieldName(...)`
class _$ActionListCWProxyImpl implements _$ActionListCWProxy {
  const _$ActionListCWProxyImpl(this._value);

  final ActionList _value;

  @override
  ActionList action(List<Action> action) => this(action: action);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ActionList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ActionList(...).copyWith(id: 12, name: "My name")
  /// ````
  ActionList call({
    Object? action = const $CopyWithPlaceholder(),
  }) {
    return ActionList(
      action: action == const $CopyWithPlaceholder() || action == null
          ? _value.action
          // ignore: cast_nullable_to_non_nullable
          : action as List<Action>,
    );
  }
}

extension $ActionListCopyWith on ActionList {
  /// Returns a callable class that can be used as follows: `instanceOfActionList.copyWith(...)` or like so:`instanceOfActionList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ActionListCWProxy get copyWith => _$ActionListCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActionListAdapter extends TypeAdapter<ActionList> {
  @override
  final int typeId = 24;

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
