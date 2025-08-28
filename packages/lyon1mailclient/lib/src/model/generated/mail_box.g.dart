// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../mail_box.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MailBoxCWProxy {
  MailBox name(String name);

  MailBox emails(List<Mail> emails);

  MailBox specialMailBox(SpecialMailBox? specialMailBox);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MailBox(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MailBox(...).copyWith(id: 12, name: "My name")
  /// ```
  MailBox call({
    String name,
    List<Mail> emails,
    SpecialMailBox? specialMailBox,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMailBox.copyWith(...)` or call `instanceOfMailBox.copyWith.fieldName(value)` for a single field.
class _$MailBoxCWProxyImpl implements _$MailBoxCWProxy {
  const _$MailBoxCWProxyImpl(this._value);

  final MailBox _value;

  @override
  MailBox name(String name) => call(name: name);

  @override
  MailBox emails(List<Mail> emails) => call(emails: emails);

  @override
  MailBox specialMailBox(SpecialMailBox? specialMailBox) =>
      call(specialMailBox: specialMailBox);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MailBox(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MailBox(...).copyWith(id: 12, name: "My name")
  /// ```
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMailBox.copyWith(...)` or `instanceOfMailBox.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MailBoxCWProxy get copyWith => _$MailBoxCWProxyImpl(this);
}
