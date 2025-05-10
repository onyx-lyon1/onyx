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

  Mail id(int? id);

  Mail receiver(String receiver);

  Mail attachments(List<String> attachments);

  Mail isFlagged(bool isFlagged);

  Mail attachmentsFiles(List<File> attachmentsFiles);

  Mail rawMail(MimeMessage? rawMail);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Mail(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Mail(...).copyWith(id: 12, name: "My name")
  /// ```
  Mail call({
    String subject,
    String sender,
    String excerpt,
    bool isRead,
    DateTime date,
    String body,
    int? id,
    String receiver,
    List<String> attachments,
    bool isFlagged,
    List<File> attachmentsFiles,
    MimeMessage? rawMail,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMail.copyWith(...)` or call `instanceOfMail.copyWith.fieldName(value)` for a single field.
class _$MailCWProxyImpl implements _$MailCWProxy {
  const _$MailCWProxyImpl(this._value);

  final Mail _value;

  @override
  Mail subject(String subject) => call(subject: subject);

  @override
  Mail sender(String sender) => call(sender: sender);

  @override
  Mail excerpt(String excerpt) => call(excerpt: excerpt);

  @override
  Mail isRead(bool isRead) => call(isRead: isRead);

  @override
  Mail date(DateTime date) => call(date: date);

  @override
  Mail body(String body) => call(body: body);

  @override
  Mail id(int? id) => call(id: id);

  @override
  Mail receiver(String receiver) => call(receiver: receiver);

  @override
  Mail attachments(List<String> attachments) => call(attachments: attachments);

  @override
  Mail isFlagged(bool isFlagged) => call(isFlagged: isFlagged);

  @override
  Mail attachmentsFiles(List<File> attachmentsFiles) =>
      call(attachmentsFiles: attachmentsFiles);

  @override
  Mail rawMail(MimeMessage? rawMail) => call(rawMail: rawMail);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Mail(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Mail(...).copyWith(id: 12, name: "My name")
  /// ```
  Mail call({
    Object? subject = const $CopyWithPlaceholder(),
    Object? sender = const $CopyWithPlaceholder(),
    Object? excerpt = const $CopyWithPlaceholder(),
    Object? isRead = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? body = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? receiver = const $CopyWithPlaceholder(),
    Object? attachments = const $CopyWithPlaceholder(),
    Object? isFlagged = const $CopyWithPlaceholder(),
    Object? attachmentsFiles = const $CopyWithPlaceholder(),
    Object? rawMail = const $CopyWithPlaceholder(),
  }) {
    return Mail(
      subject: subject == const $CopyWithPlaceholder()
          ? _value.subject
          // ignore: cast_nullable_to_non_nullable
          : subject as String,
      sender: sender == const $CopyWithPlaceholder()
          ? _value.sender
          // ignore: cast_nullable_to_non_nullable
          : sender as String,
      excerpt: excerpt == const $CopyWithPlaceholder()
          ? _value.excerpt
          // ignore: cast_nullable_to_non_nullable
          : excerpt as String,
      isRead: isRead == const $CopyWithPlaceholder()
          ? _value.isRead
          // ignore: cast_nullable_to_non_nullable
          : isRead as bool,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime,
      body: body == const $CopyWithPlaceholder()
          ? _value.body
          // ignore: cast_nullable_to_non_nullable
          : body as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      receiver: receiver == const $CopyWithPlaceholder()
          ? _value.receiver
          // ignore: cast_nullable_to_non_nullable
          : receiver as String,
      attachments: attachments == const $CopyWithPlaceholder()
          ? _value.attachments
          // ignore: cast_nullable_to_non_nullable
          : attachments as List<String>,
      isFlagged: isFlagged == const $CopyWithPlaceholder()
          ? _value.isFlagged
          // ignore: cast_nullable_to_non_nullable
          : isFlagged as bool,
      attachmentsFiles: attachmentsFiles == const $CopyWithPlaceholder()
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMail.copyWith(...)` or `instanceOfMail.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MailCWProxy get copyWith => _$MailCWProxyImpl(this);
}
