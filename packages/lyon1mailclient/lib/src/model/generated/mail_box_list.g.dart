// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../mail_box_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MailBoxListCWProxy {
  MailBoxList mailBoxes(List<MailBox> mailBoxes);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MailBoxList(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MailBoxList(...).copyWith(id: 12, name: "My name")
  /// ```
  MailBoxList call({
    List<MailBox> mailBoxes,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMailBoxList.copyWith(...)` or call `instanceOfMailBoxList.copyWith.fieldName(value)` for a single field.
class _$MailBoxListCWProxyImpl implements _$MailBoxListCWProxy {
  const _$MailBoxListCWProxyImpl(this._value);

  final MailBoxList _value;

  @override
  MailBoxList mailBoxes(List<MailBox> mailBoxes) => call(mailBoxes: mailBoxes);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MailBoxList(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MailBoxList(...).copyWith(id: 12, name: "My name")
  /// ```
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMailBoxList.copyWith(...)` or `instanceOfMailBoxList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MailBoxListCWProxy get copyWith => _$MailBoxListCWProxyImpl(this);
}
