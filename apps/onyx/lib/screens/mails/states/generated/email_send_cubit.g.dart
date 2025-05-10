// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../email_send_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmailSendStateCWProxy {
  EmailSendState status(EmailSendStatus status);

  EmailSendState controller(QuillController? controller);

  EmailSendState subjectEditor(TextEditingController? subjectEditor);

  EmailSendState destinationEditor(TextEditingController? destinationEditor);

  EmailSendState originalMessage(int? originalMessage);

  EmailSendState replyAll(bool? replyAll);

  EmailSendState reply(bool? reply);

  EmailSendState forward(bool? forward);

  EmailSendState attachments(List<File> attachments);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmailSendState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmailSendState(...).copyWith(id: 12, name: "My name")
  /// ```
  EmailSendState call({
    EmailSendStatus status,
    QuillController? controller,
    TextEditingController? subjectEditor,
    TextEditingController? destinationEditor,
    int? originalMessage,
    bool? replyAll,
    bool? reply,
    bool? forward,
    List<File> attachments,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmailSendState.copyWith(...)` or call `instanceOfEmailSendState.copyWith.fieldName(value)` for a single field.
class _$EmailSendStateCWProxyImpl implements _$EmailSendStateCWProxy {
  const _$EmailSendStateCWProxyImpl(this._value);

  final EmailSendState _value;

  @override
  EmailSendState status(EmailSendStatus status) => call(status: status);

  @override
  EmailSendState controller(QuillController? controller) =>
      call(controller: controller);

  @override
  EmailSendState subjectEditor(TextEditingController? subjectEditor) =>
      call(subjectEditor: subjectEditor);

  @override
  EmailSendState destinationEditor(TextEditingController? destinationEditor) =>
      call(destinationEditor: destinationEditor);

  @override
  EmailSendState originalMessage(int? originalMessage) =>
      call(originalMessage: originalMessage);

  @override
  EmailSendState replyAll(bool? replyAll) => call(replyAll: replyAll);

  @override
  EmailSendState reply(bool? reply) => call(reply: reply);

  @override
  EmailSendState forward(bool? forward) => call(forward: forward);

  @override
  EmailSendState attachments(List<File> attachments) =>
      call(attachments: attachments);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmailSendState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmailSendState(...).copyWith(id: 12, name: "My name")
  /// ```
  EmailSendState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? controller = const $CopyWithPlaceholder(),
    Object? subjectEditor = const $CopyWithPlaceholder(),
    Object? destinationEditor = const $CopyWithPlaceholder(),
    Object? originalMessage = const $CopyWithPlaceholder(),
    Object? replyAll = const $CopyWithPlaceholder(),
    Object? reply = const $CopyWithPlaceholder(),
    Object? forward = const $CopyWithPlaceholder(),
    Object? attachments = const $CopyWithPlaceholder(),
  }) {
    return EmailSendState(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as EmailSendStatus,
      controller: controller == const $CopyWithPlaceholder()
          ? _value.controller
          // ignore: cast_nullable_to_non_nullable
          : controller as QuillController?,
      subjectEditor: subjectEditor == const $CopyWithPlaceholder()
          ? _value.subjectEditor
          // ignore: cast_nullable_to_non_nullable
          : subjectEditor as TextEditingController?,
      destinationEditor: destinationEditor == const $CopyWithPlaceholder()
          ? _value.destinationEditor
          // ignore: cast_nullable_to_non_nullable
          : destinationEditor as TextEditingController?,
      originalMessage: originalMessage == const $CopyWithPlaceholder()
          ? _value.originalMessage
          // ignore: cast_nullable_to_non_nullable
          : originalMessage as int?,
      replyAll: replyAll == const $CopyWithPlaceholder()
          ? _value.replyAll
          // ignore: cast_nullable_to_non_nullable
          : replyAll as bool?,
      reply: reply == const $CopyWithPlaceholder()
          ? _value.reply
          // ignore: cast_nullable_to_non_nullable
          : reply as bool?,
      forward: forward == const $CopyWithPlaceholder()
          ? _value.forward
          // ignore: cast_nullable_to_non_nullable
          : forward as bool?,
      attachments: attachments == const $CopyWithPlaceholder()
          ? _value.attachments
          // ignore: cast_nullable_to_non_nullable
          : attachments as List<File>,
    );
  }
}

extension $EmailSendStateCopyWith on EmailSendState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmailSendState.copyWith(...)` or `instanceOfEmailSendState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmailSendStateCWProxy get copyWith => _$EmailSendStateCWProxyImpl(this);
}
