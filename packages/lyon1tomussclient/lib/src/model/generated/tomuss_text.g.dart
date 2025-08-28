// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tomuss_text.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TomussTextCWProxy {
  TomussText title(String title);

  TomussText author(String author);

  TomussText date(DateTime? date);

  TomussText position(double position);

  TomussText value(String value);

  TomussText comment(String comment);

  TomussText isValidText(bool isValidText);

  TomussText isHidden(bool isHidden);

  TomussText theId(String theId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TomussText(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TomussText(...).copyWith(id: 12, name: "My name")
  /// ```
  TomussText call({
    String title,
    String author,
    DateTime? date,
    double position,
    String value,
    String comment,
    bool isValidText,
    bool isHidden,
    String theId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTomussText.copyWith(...)` or call `instanceOfTomussText.copyWith.fieldName(value)` for a single field.
class _$TomussTextCWProxyImpl implements _$TomussTextCWProxy {
  const _$TomussTextCWProxyImpl(this._value);

  final TomussText _value;

  @override
  TomussText title(String title) => call(title: title);

  @override
  TomussText author(String author) => call(author: author);

  @override
  TomussText date(DateTime? date) => call(date: date);

  @override
  TomussText position(double position) => call(position: position);

  @override
  TomussText value(String value) => call(value: value);

  @override
  TomussText comment(String comment) => call(comment: comment);

  @override
  TomussText isValidText(bool isValidText) => call(isValidText: isValidText);

  @override
  TomussText isHidden(bool isHidden) => call(isHidden: isHidden);

  @override
  TomussText theId(String theId) => call(theId: theId);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TomussText(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TomussText(...).copyWith(id: 12, name: "My name")
  /// ```
  TomussText call({
    Object? title = const $CopyWithPlaceholder(),
    Object? author = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? isValidText = const $CopyWithPlaceholder(),
    Object? isHidden = const $CopyWithPlaceholder(),
    Object? theId = const $CopyWithPlaceholder(),
  }) {
    return TomussText(
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      author: author == const $CopyWithPlaceholder() || author == null
          ? _value.author
          // ignore: cast_nullable_to_non_nullable
          : author as String,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime?,
      position: position == const $CopyWithPlaceholder() || position == null
          ? _value.position
          // ignore: cast_nullable_to_non_nullable
          : position as double,
      value: value == const $CopyWithPlaceholder() || value == null
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String,
      comment: comment == const $CopyWithPlaceholder() || comment == null
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String,
      isValidText:
          isValidText == const $CopyWithPlaceholder() || isValidText == null
              ? _value.isValidText
              // ignore: cast_nullable_to_non_nullable
              : isValidText as bool,
      isHidden: isHidden == const $CopyWithPlaceholder() || isHidden == null
          ? _value.isHidden
          // ignore: cast_nullable_to_non_nullable
          : isHidden as bool,
      theId: theId == const $CopyWithPlaceholder() || theId == null
          ? _value.theId
          // ignore: cast_nullable_to_non_nullable
          : theId as String,
    );
  }
}

extension $TomussTextCopyWith on TomussText {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTomussText.copyWith(...)` or `instanceOfTomussText.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TomussTextCWProxy get copyWith => _$TomussTextCWProxyImpl(this);
}
