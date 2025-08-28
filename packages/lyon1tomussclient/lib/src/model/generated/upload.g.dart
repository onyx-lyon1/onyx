// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../upload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UploadCWProxy {
  Upload title(String title);

  Upload author(String author);

  Upload date(DateTime? date);

  Upload position(double position);

  Upload comment(String comment);

  Upload uploadMax(int uploadMax);

  Upload fileUrl(String fileUrl);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Upload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Upload(...).copyWith(id: 12, name: "My name")
  /// ```
  Upload call({
    String title,
    String author,
    DateTime? date,
    double position,
    String comment,
    int uploadMax,
    String fileUrl,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpload.copyWith(...)` or call `instanceOfUpload.copyWith.fieldName(value)` for a single field.
class _$UploadCWProxyImpl implements _$UploadCWProxy {
  const _$UploadCWProxyImpl(this._value);

  final Upload _value;

  @override
  Upload title(String title) => call(title: title);

  @override
  Upload author(String author) => call(author: author);

  @override
  Upload date(DateTime? date) => call(date: date);

  @override
  Upload position(double position) => call(position: position);

  @override
  Upload comment(String comment) => call(comment: comment);

  @override
  Upload uploadMax(int uploadMax) => call(uploadMax: uploadMax);

  @override
  Upload fileUrl(String fileUrl) => call(fileUrl: fileUrl);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Upload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Upload(...).copyWith(id: 12, name: "My name")
  /// ```
  Upload call({
    Object? title = const $CopyWithPlaceholder(),
    Object? author = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? uploadMax = const $CopyWithPlaceholder(),
    Object? fileUrl = const $CopyWithPlaceholder(),
  }) {
    return Upload(
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      author: author == const $CopyWithPlaceholder()
          ? _value.author
          // ignore: cast_nullable_to_non_nullable
          : author as String,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime?,
      position: position == const $CopyWithPlaceholder()
          ? _value.position
          // ignore: cast_nullable_to_non_nullable
          : position as double,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String,
      uploadMax: uploadMax == const $CopyWithPlaceholder()
          ? _value.uploadMax
          // ignore: cast_nullable_to_non_nullable
          : uploadMax as int,
      fileUrl: fileUrl == const $CopyWithPlaceholder()
          ? _value.fileUrl
          // ignore: cast_nullable_to_non_nullable
          : fileUrl as String,
    );
  }
}

extension $UploadCopyWith on Upload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpload.copyWith(...)` or `instanceOfUpload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UploadCWProxy get copyWith => _$UploadCWProxyImpl(this);
}
