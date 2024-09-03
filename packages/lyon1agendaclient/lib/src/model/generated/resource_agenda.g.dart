// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../resource_agenda.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ResourceAgendaCWProxy {
  ResourceAgenda id(int id);

  ResourceAgenda name(String name);

  ResourceAgenda branch(List<ResourceAgenda>? branch);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResourceAgenda(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResourceAgenda(...).copyWith(id: 12, name: "My name")
  /// ````
  ResourceAgenda call({
    int? id,
    String? name,
    List<ResourceAgenda>? branch,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResourceAgenda.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfResourceAgenda.copyWith.fieldName(...)`
class _$ResourceAgendaCWProxyImpl implements _$ResourceAgendaCWProxy {
  const _$ResourceAgendaCWProxyImpl(this._value);

  final ResourceAgenda _value;

  @override
  ResourceAgenda id(int id) => this(id: id);

  @override
  ResourceAgenda name(String name) => this(name: name);

  @override
  ResourceAgenda branch(List<ResourceAgenda>? branch) => this(branch: branch);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResourceAgenda(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResourceAgenda(...).copyWith(id: 12, name: "My name")
  /// ````
  ResourceAgenda call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? branch = const $CopyWithPlaceholder(),
  }) {
    return ResourceAgenda(
      id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      branch == const $CopyWithPlaceholder()
          ? _value.branch
          // ignore: cast_nullable_to_non_nullable
          : branch as List<ResourceAgenda>?,
    );
  }
}

extension $ResourceAgendaCopyWith on ResourceAgenda {
  /// Returns a callable class that can be used as follows: `instanceOfResourceAgenda.copyWith(...)` or like so:`instanceOfResourceAgenda.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ResourceAgendaCWProxy get copyWith => _$ResourceAgendaCWProxyImpl(this);
}
