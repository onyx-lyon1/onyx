// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../mail_box_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MailBoxListCWProxy {
  MailBoxList mailBoxes(List<MailBox> mailBoxes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MailBoxList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MailBoxList(...).copyWith(id: 12, name: "My name")
  /// ````
  MailBoxList call({
    List<MailBox>? mailBoxes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMailBoxList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMailBoxList.copyWith.fieldName(...)`
class _$MailBoxListCWProxyImpl implements _$MailBoxListCWProxy {
  const _$MailBoxListCWProxyImpl(this._value);

  final MailBoxList _value;

  @override
  MailBoxList mailBoxes(List<MailBox> mailBoxes) => this(mailBoxes: mailBoxes);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MailBoxList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MailBoxList(...).copyWith(id: 12, name: "My name")
  /// ````
  MailBoxList call({
    Object? mailBoxes = const $CopyWithPlaceholder(),
  }) {
    return MailBoxList(
      mailBoxes: mailBoxes == const $CopyWithPlaceholder() || mailBoxes == null
          ? _value.mailBoxes
          // ignore: cast_nullable_to_non_nullable
          : mailBoxes as List<MailBox>,
    );
  }
}

extension $MailBoxListCopyWith on MailBoxList {
  /// Returns a callable class that can be used as follows: `instanceOfMailBoxList.copyWith(...)` or like so:`instanceOfMailBoxList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MailBoxListCWProxy get copyWith => _$MailBoxListCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MailBoxListAdapter extends TypeAdapter<MailBoxList> {
  @override
  final int typeId = 21;

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
