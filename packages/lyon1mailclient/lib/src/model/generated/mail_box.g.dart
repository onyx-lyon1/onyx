// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../mail_box.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MailBoxCWProxy {
  MailBox name(String name);

  MailBox emails(List<Mail> emails);

  MailBox specialMailBox(SpecialMailBox? specialMailBox);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MailBox(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MailBox(...).copyWith(id: 12, name: "My name")
  /// ````
  MailBox call({
    String? name,
    List<Mail>? emails,
    SpecialMailBox? specialMailBox,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMailBox.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMailBox.copyWith.fieldName(...)`
class _$MailBoxCWProxyImpl implements _$MailBoxCWProxy {
  const _$MailBoxCWProxyImpl(this._value);

  final MailBox _value;

  @override
  MailBox name(String name) => this(name: name);

  @override
  MailBox emails(List<Mail> emails) => this(emails: emails);

  @override
  MailBox specialMailBox(SpecialMailBox? specialMailBox) =>
      this(specialMailBox: specialMailBox);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MailBox(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MailBox(...).copyWith(id: 12, name: "My name")
  /// ````
  MailBox call({
    Object? name = const $CopyWithPlaceholder(),
    Object? emails = const $CopyWithPlaceholder(),
    Object? specialMailBox = const $CopyWithPlaceholder(),
  }) {
    return MailBox(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      emails: emails == const $CopyWithPlaceholder() || emails == null
          ? _value.emails
          // ignore: cast_nullable_to_non_nullable
          : emails as List<Mail>,
      specialMailBox: specialMailBox == const $CopyWithPlaceholder()
          ? _value.specialMailBox
          // ignore: cast_nullable_to_non_nullable
          : specialMailBox as SpecialMailBox?,
    );
  }
}

extension $MailBoxCopyWith on MailBox {
  /// Returns a callable class that can be used as follows: `instanceOfMailBox.copyWith(...)` or like so:`instanceOfMailBox.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MailBoxCWProxy get copyWith => _$MailBoxCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MailBoxAdapter extends TypeAdapter<MailBox> {
  @override
  final int typeId = 19;

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
