// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../enumeration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EnumerationCWProxy {
  Enumeration title(String title);

  Enumeration author(String author);

  Enumeration date(DateTime? date);

  Enumeration position(double position);

  Enumeration value(String? value);

  Enumeration values(List<String> values);

  Enumeration comment(String comment);

  Enumeration theId(String theId);

  Enumeration lineId(String lineId);

  Enumeration ue(String ue);

  Enumeration semester(String semester);

  Enumeration year(String year);

  Enumeration modifiable(bool modifiable);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Enumeration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Enumeration(...).copyWith(id: 12, name: "My name")
  /// ```
  Enumeration call({
    String title,
    String author,
    DateTime? date,
    double position,
    String? value,
    List<String> values,
    String comment,
    String theId,
    String lineId,
    String ue,
    String semester,
    String year,
    bool modifiable,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEnumeration.copyWith(...)` or call `instanceOfEnumeration.copyWith.fieldName(value)` for a single field.
class _$EnumerationCWProxyImpl implements _$EnumerationCWProxy {
  const _$EnumerationCWProxyImpl(this._value);

  final Enumeration _value;

  @override
  Enumeration title(String title) => call(title: title);

  @override
  Enumeration author(String author) => call(author: author);

  @override
  Enumeration date(DateTime? date) => call(date: date);

  @override
  Enumeration position(double position) => call(position: position);

  @override
  Enumeration value(String? value) => call(value: value);

  @override
  Enumeration values(List<String> values) => call(values: values);

  @override
  Enumeration comment(String comment) => call(comment: comment);

  @override
  Enumeration theId(String theId) => call(theId: theId);

  @override
  Enumeration lineId(String lineId) => call(lineId: lineId);

  @override
  Enumeration ue(String ue) => call(ue: ue);

  @override
  Enumeration semester(String semester) => call(semester: semester);

  @override
  Enumeration year(String year) => call(year: year);

  @override
  Enumeration modifiable(bool modifiable) => call(modifiable: modifiable);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Enumeration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Enumeration(...).copyWith(id: 12, name: "My name")
  /// ```
  Enumeration call({
    Object? title = const $CopyWithPlaceholder(),
    Object? author = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? values = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? theId = const $CopyWithPlaceholder(),
    Object? lineId = const $CopyWithPlaceholder(),
    Object? ue = const $CopyWithPlaceholder(),
    Object? semester = const $CopyWithPlaceholder(),
    Object? year = const $CopyWithPlaceholder(),
    Object? modifiable = const $CopyWithPlaceholder(),
  }) {
    return Enumeration(
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
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String?,
      values: values == const $CopyWithPlaceholder() || values == null
          ? _value.values
          // ignore: cast_nullable_to_non_nullable
          : values as List<String>,
      comment: comment == const $CopyWithPlaceholder() || comment == null
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String,
      theId: theId == const $CopyWithPlaceholder() || theId == null
          ? _value.theId
          // ignore: cast_nullable_to_non_nullable
          : theId as String,
      lineId: lineId == const $CopyWithPlaceholder() || lineId == null
          ? _value.lineId
          // ignore: cast_nullable_to_non_nullable
          : lineId as String,
      ue: ue == const $CopyWithPlaceholder() || ue == null
          ? _value.ue
          // ignore: cast_nullable_to_non_nullable
          : ue as String,
      semester: semester == const $CopyWithPlaceholder() || semester == null
          ? _value.semester
          // ignore: cast_nullable_to_non_nullable
          : semester as String,
      year: year == const $CopyWithPlaceholder() || year == null
          ? _value.year
          // ignore: cast_nullable_to_non_nullable
          : year as String,
      modifiable:
          modifiable == const $CopyWithPlaceholder() || modifiable == null
              ? _value.modifiable
              // ignore: cast_nullable_to_non_nullable
              : modifiable as bool,
    );
  }
}

extension $EnumerationCopyWith on Enumeration {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEnumeration.copyWith(...)` or `instanceOfEnumeration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EnumerationCWProxy get copyWith => _$EnumerationCWProxyImpl(this);
}
