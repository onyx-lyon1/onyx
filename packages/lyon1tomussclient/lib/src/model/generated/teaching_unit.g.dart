// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../teaching_unit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TeachingUnitCWProxy {
  TeachingUnit title(String title);

  TeachingUnit masters(List<Teacher> masters);

  TeachingUnit grades(List<Grade> grades);

  TeachingUnit textValues(List<TomussText> textValues);

  TeachingUnit enumerations(List<Enumeration> enumerations);

  TeachingUnit presences(List<Presence> presences);

  TeachingUnit stageCodes(List<StageCode> stageCodes);

  TeachingUnit uploads(List<Upload> uploads);

  TeachingUnit urls(List<URL> urls);

  TeachingUnit ticket(String ticket);

  TeachingUnit ue(String ue);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TeachingUnit(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TeachingUnit(...).copyWith(id: 12, name: "My name")
  /// ```
  TeachingUnit call({
    String title,
    List<Teacher> masters,
    List<Grade> grades,
    List<TomussText> textValues,
    List<Enumeration> enumerations,
    List<Presence> presences,
    List<StageCode> stageCodes,
    List<Upload> uploads,
    List<URL> urls,
    String ticket,
    String ue,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTeachingUnit.copyWith(...)` or call `instanceOfTeachingUnit.copyWith.fieldName(value)` for a single field.
class _$TeachingUnitCWProxyImpl implements _$TeachingUnitCWProxy {
  const _$TeachingUnitCWProxyImpl(this._value);

  final TeachingUnit _value;

  @override
  TeachingUnit title(String title) => call(title: title);

  @override
  TeachingUnit masters(List<Teacher> masters) => call(masters: masters);

  @override
  TeachingUnit grades(List<Grade> grades) => call(grades: grades);

  @override
  TeachingUnit textValues(List<TomussText> textValues) =>
      call(textValues: textValues);

  @override
  TeachingUnit enumerations(List<Enumeration> enumerations) =>
      call(enumerations: enumerations);

  @override
  TeachingUnit presences(List<Presence> presences) =>
      call(presences: presences);

  @override
  TeachingUnit stageCodes(List<StageCode> stageCodes) =>
      call(stageCodes: stageCodes);

  @override
  TeachingUnit uploads(List<Upload> uploads) => call(uploads: uploads);

  @override
  TeachingUnit urls(List<URL> urls) => call(urls: urls);

  @override
  TeachingUnit ticket(String ticket) => call(ticket: ticket);

  @override
  TeachingUnit ue(String ue) => call(ue: ue);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TeachingUnit(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TeachingUnit(...).copyWith(id: 12, name: "My name")
  /// ```
  TeachingUnit call({
    Object? title = const $CopyWithPlaceholder(),
    Object? masters = const $CopyWithPlaceholder(),
    Object? grades = const $CopyWithPlaceholder(),
    Object? textValues = const $CopyWithPlaceholder(),
    Object? enumerations = const $CopyWithPlaceholder(),
    Object? presences = const $CopyWithPlaceholder(),
    Object? stageCodes = const $CopyWithPlaceholder(),
    Object? uploads = const $CopyWithPlaceholder(),
    Object? urls = const $CopyWithPlaceholder(),
    Object? ticket = const $CopyWithPlaceholder(),
    Object? ue = const $CopyWithPlaceholder(),
  }) {
    return TeachingUnit(
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      masters: masters == const $CopyWithPlaceholder() || masters == null
          ? _value.masters
          // ignore: cast_nullable_to_non_nullable
          : masters as List<Teacher>,
      grades: grades == const $CopyWithPlaceholder() || grades == null
          ? _value.grades
          // ignore: cast_nullable_to_non_nullable
          : grades as List<Grade>,
      textValues:
          textValues == const $CopyWithPlaceholder() || textValues == null
              ? _value.textValues
              // ignore: cast_nullable_to_non_nullable
              : textValues as List<TomussText>,
      enumerations:
          enumerations == const $CopyWithPlaceholder() || enumerations == null
              ? _value.enumerations
              // ignore: cast_nullable_to_non_nullable
              : enumerations as List<Enumeration>,
      presences: presences == const $CopyWithPlaceholder() || presences == null
          ? _value.presences
          // ignore: cast_nullable_to_non_nullable
          : presences as List<Presence>,
      stageCodes:
          stageCodes == const $CopyWithPlaceholder() || stageCodes == null
              ? _value.stageCodes
              // ignore: cast_nullable_to_non_nullable
              : stageCodes as List<StageCode>,
      uploads: uploads == const $CopyWithPlaceholder() || uploads == null
          ? _value.uploads
          // ignore: cast_nullable_to_non_nullable
          : uploads as List<Upload>,
      urls: urls == const $CopyWithPlaceholder() || urls == null
          ? _value.urls
          // ignore: cast_nullable_to_non_nullable
          : urls as List<URL>,
      ticket: ticket == const $CopyWithPlaceholder() || ticket == null
          ? _value.ticket
          // ignore: cast_nullable_to_non_nullable
          : ticket as String,
      ue: ue == const $CopyWithPlaceholder() || ue == null
          ? _value.ue
          // ignore: cast_nullable_to_non_nullable
          : ue as String,
    );
  }
}

extension $TeachingUnitCopyWith on TeachingUnit {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTeachingUnit.copyWith(...)` or `instanceOfTeachingUnit.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TeachingUnitCWProxy get copyWith => _$TeachingUnitCWProxyImpl(this);
}
