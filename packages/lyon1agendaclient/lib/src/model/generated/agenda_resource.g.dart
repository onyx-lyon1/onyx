// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../agenda_resource.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AgendaResourceCWProxy {
  AgendaResource id(int? id);

  AgendaResource name(String name);

  AgendaResource children(List<AgendaResource>? children);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AgendaResource(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AgendaResource(...).copyWith(id: 12, name: "My name")
  /// ````
  AgendaResource call({
    int? id,
    String? name,
    List<AgendaResource>? children,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAgendaResource.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAgendaResource.copyWith.fieldName(...)`
class _$AgendaResourceCWProxyImpl implements _$AgendaResourceCWProxy {
  const _$AgendaResourceCWProxyImpl(this._value);

  final AgendaResource _value;

  @override
  AgendaResource id(int? id) => this(id: id);

  @override
  AgendaResource name(String name) => this(name: name);

  @override
  AgendaResource children(List<AgendaResource>? children) =>
      this(children: children);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AgendaResource(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AgendaResource(...).copyWith(id: 12, name: "My name")
  /// ````
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
  /// Returns a callable class that can be used as follows: `instanceOfAgendaResource.copyWith(...)` or like so:`instanceOfAgendaResource.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AgendaResourceCWProxy get copyWith => _$AgendaResourceCWProxyImpl(this);
}
