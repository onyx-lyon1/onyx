// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../mail.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MailCWProxy {
  Mail subject(String subject);

  Mail sender(String sender);

  Mail excerpt(String excerpt);

  Mail isRead(bool isRead);

  Mail date(DateTime date);

  Mail body(String body);

  Mail blackBody(String blackBody);

  Mail id(int? id);

  Mail receiver(String receiver);

  Mail attachments(List<String> attachments);

  Mail isFlagged(bool isFlagged);

  Mail attachmentsFiles(List<File> attachmentsFiles);

  Mail rawMail(MimeMessage? rawMail);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Mail(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Mail(...).copyWith(id: 12, name: "My name")
  /// ````
  Mail call({
    String? subject,
    String? sender,
    String? excerpt,
    bool? isRead,
    DateTime? date,
    String? body,
    String? blackBody,
    int? id,
    String? receiver,
    List<String>? attachments,
    bool? isFlagged,
    List<File>? attachmentsFiles,
    MimeMessage? rawMail,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMail.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMail.copyWith.fieldName(...)`
class _$MailCWProxyImpl implements _$MailCWProxy {
  const _$MailCWProxyImpl(this._value);

  final Mail _value;

  @override
  Mail subject(String subject) => this(subject: subject);

  @override
  Mail sender(String sender) => this(sender: sender);

  @override
  Mail excerpt(String excerpt) => this(excerpt: excerpt);

  @override
  Mail isRead(bool isRead) => this(isRead: isRead);

  @override
  Mail date(DateTime date) => this(date: date);

  @override
  Mail body(String body) => this(body: body);

  @override
  Mail blackBody(String blackBody) => this(blackBody: blackBody);

  @override
  Mail id(int? id) => this(id: id);

  @override
  Mail receiver(String receiver) => this(receiver: receiver);

  @override
  Mail attachments(List<String> attachments) => this(attachments: attachments);

  @override
  Mail isFlagged(bool isFlagged) => this(isFlagged: isFlagged);

  @override
  Mail attachmentsFiles(List<File> attachmentsFiles) =>
      this(attachmentsFiles: attachmentsFiles);

  @override
  Mail rawMail(MimeMessage? rawMail) => this(rawMail: rawMail);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Mail(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Mail(...).copyWith(id: 12, name: "My name")
  /// ````
  Mail call({
    Object? subject = const $CopyWithPlaceholder(),
    Object? sender = const $CopyWithPlaceholder(),
    Object? excerpt = const $CopyWithPlaceholder(),
    Object? isRead = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? body = const $CopyWithPlaceholder(),
    Object? blackBody = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? receiver = const $CopyWithPlaceholder(),
    Object? attachments = const $CopyWithPlaceholder(),
    Object? isFlagged = const $CopyWithPlaceholder(),
    Object? attachmentsFiles = const $CopyWithPlaceholder(),
    Object? rawMail = const $CopyWithPlaceholder(),
  }) {
    return Mail(
      subject: subject == const $CopyWithPlaceholder() || subject == null
          ? _value.subject
          // ignore: cast_nullable_to_non_nullable
          : subject as String,
      sender: sender == const $CopyWithPlaceholder() || sender == null
          ? _value.sender
          // ignore: cast_nullable_to_non_nullable
          : sender as String,
      excerpt: excerpt == const $CopyWithPlaceholder() || excerpt == null
          ? _value.excerpt
          // ignore: cast_nullable_to_non_nullable
          : excerpt as String,
      isRead: isRead == const $CopyWithPlaceholder() || isRead == null
          ? _value.isRead
          // ignore: cast_nullable_to_non_nullable
          : isRead as bool,
      date: date == const $CopyWithPlaceholder() || date == null
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime,
      body: body == const $CopyWithPlaceholder() || body == null
          ? _value.body
          // ignore: cast_nullable_to_non_nullable
          : body as String,
      blackBody: blackBody == const $CopyWithPlaceholder() || blackBody == null
          ? _value.blackBody
          // ignore: cast_nullable_to_non_nullable
          : blackBody as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      receiver: receiver == const $CopyWithPlaceholder() || receiver == null
          ? _value.receiver
          // ignore: cast_nullable_to_non_nullable
          : receiver as String,
      attachments:
          attachments == const $CopyWithPlaceholder() || attachments == null
              ? _value.attachments
              // ignore: cast_nullable_to_non_nullable
              : attachments as List<String>,
      isFlagged: isFlagged == const $CopyWithPlaceholder() || isFlagged == null
          ? _value.isFlagged
          // ignore: cast_nullable_to_non_nullable
          : isFlagged as bool,
      attachmentsFiles: attachmentsFiles == const $CopyWithPlaceholder() ||
              attachmentsFiles == null
          ? _value.attachmentsFiles
          // ignore: cast_nullable_to_non_nullable
          : attachmentsFiles as List<File>,
      rawMail: rawMail == const $CopyWithPlaceholder()
          ? _value.rawMail
          // ignore: cast_nullable_to_non_nullable
          : rawMail as MimeMessage?,
    );
  }
}

extension $MailCopyWith on Mail {
  /// Returns a callable class that can be used as follows: `instanceOfMail.copyWith(...)` or like so:`instanceOfMail.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MailCWProxy get copyWith => _$MailCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MailAdapter extends TypeAdapter<Mail> {
  @override
  final int typeId = 5;

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
      blackBody: fields[10] == null ? '' : fields[10] as String,
      id: fields[4] as int?,
      receiver: fields[8] as String,
      attachments: (fields[9] as List).cast<String>(),
      isFlagged: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Mail obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.subject)
      ..writeByte(1)
      ..write(obj.sender)
      ..writeByte(2)
      ..write(obj.excerpt)
      ..writeByte(3)
      ..write(obj.body)
      ..writeByte(10)
      ..write(obj.blackBody)
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
      ..write(obj.attachments);
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
