// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../action.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ActionCWProxy {
  Action type(ActionType type);

  Action mail(Mail mail);

  Action fromMailBox(MailBox? fromMailBox);

  Action originalMessageId(int? originalMessageId);

  Action replyAll(bool? replyAll);

  Action destinationMailBox(MailBox? destinationMailBox);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Action(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Action(...).copyWith(id: 12, name: "My name")
  /// ````
  Action call({
    ActionType? type,
    Mail? mail,
    MailBox? fromMailBox,
    int? originalMessageId,
    bool? replyAll,
    MailBox? destinationMailBox,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAction.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAction.copyWith.fieldName(...)`
class _$ActionCWProxyImpl implements _$ActionCWProxy {
  const _$ActionCWProxyImpl(this._value);

  final Action _value;

  @override
  Action type(ActionType type) => this(type: type);

  @override
  Action mail(Mail mail) => this(mail: mail);

  @override
  Action fromMailBox(MailBox? fromMailBox) => this(fromMailBox: fromMailBox);

  @override
  Action originalMessageId(int? originalMessageId) =>
      this(originalMessageId: originalMessageId);

  @override
  Action replyAll(bool? replyAll) => this(replyAll: replyAll);

  @override
  Action destinationMailBox(MailBox? destinationMailBox) =>
      this(destinationMailBox: destinationMailBox);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Action(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Action(...).copyWith(id: 12, name: "My name")
  /// ````
  Action call({
    Object? type = const $CopyWithPlaceholder(),
    Object? mail = const $CopyWithPlaceholder(),
    Object? fromMailBox = const $CopyWithPlaceholder(),
    Object? originalMessageId = const $CopyWithPlaceholder(),
    Object? replyAll = const $CopyWithPlaceholder(),
    Object? destinationMailBox = const $CopyWithPlaceholder(),
  }) {
    return Action(
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as ActionType,
      mail: mail == const $CopyWithPlaceholder() || mail == null
          ? _value.mail
          // ignore: cast_nullable_to_non_nullable
          : mail as Mail,
      fromMailBox: fromMailBox == const $CopyWithPlaceholder()
          ? _value.fromMailBox
          // ignore: cast_nullable_to_non_nullable
          : fromMailBox as MailBox?,
      originalMessageId: originalMessageId == const $CopyWithPlaceholder()
          ? _value.originalMessageId
          // ignore: cast_nullable_to_non_nullable
          : originalMessageId as int?,
      replyAll: replyAll == const $CopyWithPlaceholder()
          ? _value.replyAll
          // ignore: cast_nullable_to_non_nullable
          : replyAll as bool?,
      destinationMailBox: destinationMailBox == const $CopyWithPlaceholder()
          ? _value.destinationMailBox
          // ignore: cast_nullable_to_non_nullable
          : destinationMailBox as MailBox?,
    );
  }
}

extension $ActionCopyWith on Action {
  /// Returns a callable class that can be used as follows: `instanceOfAction.copyWith(...)` or like so:`instanceOfAction.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ActionCWProxy get copyWith => _$ActionCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActionAdapter extends TypeAdapter<Action> {
  @override
  final int typeId = 23;

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
      originalMessageId: fields[5] as int?,
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
