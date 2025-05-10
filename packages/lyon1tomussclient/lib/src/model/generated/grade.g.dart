// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../grade.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GradeCWProxy {
  Grade title(String title);

  Grade author(String author);

  Grade date(DateTime? date);

  Grade position(double position);

  Grade numerator(double numerator);

  Grade denominator(double denominator);

  Grade rank(int rank);

  Grade average(double average);

  Grade mediane(double mediane);

  Grade isValid(bool isValid);

  Grade groupeSize(int groupeSize);

  Grade children(List<Grade> children);

  Grade coef(double coef);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Grade(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Grade(...).copyWith(id: 12, name: "My name")
  /// ```
  Grade call({
    String title,
    String author,
    DateTime? date,
    double position,
    double numerator,
    double denominator,
    int rank,
    double average,
    double mediane,
    bool isValid,
    int groupeSize,
    List<Grade> children,
    double coef,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGrade.copyWith(...)` or call `instanceOfGrade.copyWith.fieldName(value)` for a single field.
class _$GradeCWProxyImpl implements _$GradeCWProxy {
  const _$GradeCWProxyImpl(this._value);

  final Grade _value;

  @override
  Grade title(String title) => call(title: title);

  @override
  Grade author(String author) => call(author: author);

  @override
  Grade date(DateTime? date) => call(date: date);

  @override
  Grade position(double position) => call(position: position);

  @override
  Grade numerator(double numerator) => call(numerator: numerator);

  @override
  Grade denominator(double denominator) => call(denominator: denominator);

  @override
  Grade rank(int rank) => call(rank: rank);

  @override
  Grade average(double average) => call(average: average);

  @override
  Grade mediane(double mediane) => call(mediane: mediane);

  @override
  Grade isValid(bool isValid) => call(isValid: isValid);

  @override
  Grade groupeSize(int groupeSize) => call(groupeSize: groupeSize);

  @override
  Grade children(List<Grade> children) => call(children: children);

  @override
  Grade coef(double coef) => call(coef: coef);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Grade(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Grade(...).copyWith(id: 12, name: "My name")
  /// ```
  Grade call({
    Object? title = const $CopyWithPlaceholder(),
    Object? author = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? numerator = const $CopyWithPlaceholder(),
    Object? denominator = const $CopyWithPlaceholder(),
    Object? rank = const $CopyWithPlaceholder(),
    Object? average = const $CopyWithPlaceholder(),
    Object? mediane = const $CopyWithPlaceholder(),
    Object? isValid = const $CopyWithPlaceholder(),
    Object? groupeSize = const $CopyWithPlaceholder(),
    Object? children = const $CopyWithPlaceholder(),
    Object? coef = const $CopyWithPlaceholder(),
  }) {
    return Grade(
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
      numerator: numerator == const $CopyWithPlaceholder()
          ? _value.numerator
          // ignore: cast_nullable_to_non_nullable
          : numerator as double,
      denominator: denominator == const $CopyWithPlaceholder()
          ? _value.denominator
          // ignore: cast_nullable_to_non_nullable
          : denominator as double,
      rank: rank == const $CopyWithPlaceholder()
          ? _value.rank
          // ignore: cast_nullable_to_non_nullable
          : rank as int,
      average: average == const $CopyWithPlaceholder()
          ? _value.average
          // ignore: cast_nullable_to_non_nullable
          : average as double,
      mediane: mediane == const $CopyWithPlaceholder()
          ? _value.mediane
          // ignore: cast_nullable_to_non_nullable
          : mediane as double,
      isValid: isValid == const $CopyWithPlaceholder()
          ? _value.isValid
          // ignore: cast_nullable_to_non_nullable
          : isValid as bool,
      groupeSize: groupeSize == const $CopyWithPlaceholder()
          ? _value.groupeSize
          // ignore: cast_nullable_to_non_nullable
          : groupeSize as int,
      children: children == const $CopyWithPlaceholder()
          ? _value.children
          // ignore: cast_nullable_to_non_nullable
          : children as List<Grade>,
      coef: coef == const $CopyWithPlaceholder()
          ? _value.coef
          // ignore: cast_nullable_to_non_nullable
          : coef as double,
    );
  }
}

extension $GradeCopyWith on Grade {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGrade.copyWith(...)` or `instanceOfGrade.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GradeCWProxy get copyWith => _$GradeCWProxyImpl(this);
}
