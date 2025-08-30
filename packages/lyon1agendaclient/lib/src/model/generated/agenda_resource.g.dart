// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../agenda_resource.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AgendaResourceCWProxy {
  AgendaResource id(int? id);

  AgendaResource name(String name);

  AgendaResource children(List<AgendaResource>? children);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AgendaResource(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AgendaResource(...).copyWith(id: 12, name: "My name")
  /// ```
  AgendaResource call({int? id, String name, List<AgendaResource>? children});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAgendaResource.copyWith(...)` or call `instanceOfAgendaResource.copyWith.fieldName(value)` for a single field.
class _$AgendaResourceCWProxyImpl implements _$AgendaResourceCWProxy {
  const _$AgendaResourceCWProxyImpl(this._value);

  final AgendaResource _value;

  @override
  AgendaResource id(int? id) => call(id: id);

  @override
  AgendaResource name(String name) => call(name: name);

  @override
  AgendaResource children(List<AgendaResource>? children) =>
      call(children: children);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AgendaResource(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AgendaResource(...).copyWith(id: 12, name: "My name")
  /// ```
  AgendaResource call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? children = const $CopyWithPlaceholder(),
  }) {
    return AgendaResource(
      id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      children == const $CopyWithPlaceholder()
          ? _value.children
          // ignore: cast_nullable_to_non_nullable
          : children as List<AgendaResource>?,
    );
  }
}

extension $AgendaResourceCopyWith on AgendaResource {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAgendaResource.copyWith(...)` or `instanceOfAgendaResource.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AgendaResourceCWProxy get copyWith => _$AgendaResourceCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgendaResource _$AgendaResourceFromJson(Map<String, dynamic> json) =>
    AgendaResource(
      (json['id'] as num?)?.toInt(),
      json['name'] as String,
      (json['children'] as List<dynamic>?)
          ?.map((e) => AgendaResource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AgendaResourceToJson(AgendaResource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'children': instance.children,
    };
