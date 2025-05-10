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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Action(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Action(...).copyWith(id: 12, name: "My name")
  /// ```
  Action call({
    ActionType type,
    Mail mail,
    MailBox? fromMailBox,
    int? originalMessageId,
    bool? replyAll,
    MailBox? destinationMailBox,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAction.copyWith(...)` or call `instanceOfAction.copyWith.fieldName(value)` for a single field.
class _$ActionCWProxyImpl implements _$ActionCWProxy {
  const _$ActionCWProxyImpl(this._value);

  final Action _value;

  @override
  Action type(ActionType type) => call(type: type);

  @override
  Action mail(Mail mail) => call(mail: mail);

  @override
  Action fromMailBox(MailBox? fromMailBox) => call(fromMailBox: fromMailBox);

  @override
  Action originalMessageId(int? originalMessageId) =>
      call(originalMessageId: originalMessageId);

  @override
  Action replyAll(bool? replyAll) => call(replyAll: replyAll);

  @override
  Action destinationMailBox(MailBox? destinationMailBox) =>
      call(destinationMailBox: destinationMailBox);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Action(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Action(...).copyWith(id: 12, name: "My name")
  /// ```
  Action call({
    Object? type = const $CopyWithPlaceholder(),
    Object? mail = const $CopyWithPlaceholder(),
    Object? fromMailBox = const $CopyWithPlaceholder(),
    Object? originalMessageId = const $CopyWithPlaceholder(),
    Object? replyAll = const $CopyWithPlaceholder(),
    Object? destinationMailBox = const $CopyWithPlaceholder(),
  }) {
    return Action(
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as ActionType,
      mail: mail == const $CopyWithPlaceholder()
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAction.copyWith(...)` or `instanceOfAction.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ActionCWProxy get copyWith => _$ActionCWProxyImpl(this);
}
