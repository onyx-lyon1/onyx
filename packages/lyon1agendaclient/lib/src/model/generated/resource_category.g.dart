// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../resource_category.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ResourceCategoryCWProxy {
  ResourceCategory category(String category);

  ResourceCategory branch(List<ResourceAgenda> branch);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResourceCategory(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResourceCategory(...).copyWith(id: 12, name: "My name")
  /// ````
  ResourceCategory call({
    String? category,
    List<ResourceAgenda>? branch,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResourceCategory.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfResourceCategory.copyWith.fieldName(...)`
class _$ResourceCategoryCWProxyImpl implements _$ResourceCategoryCWProxy {
  const _$ResourceCategoryCWProxyImpl(this._value);

  final ResourceCategory _value;

  @override
  ResourceCategory category(String category) => this(category: category);

  @override
  ResourceCategory branch(List<ResourceAgenda> branch) => this(branch: branch);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResourceCategory(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResourceCategory(...).copyWith(id: 12, name: "My name")
  /// ````
  ResourceCategory call({
    Object? category = const $CopyWithPlaceholder(),
    Object? branch = const $CopyWithPlaceholder(),
  }) {
    return ResourceCategory(
      category == const $CopyWithPlaceholder() || category == null
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String,
      branch == const $CopyWithPlaceholder() || branch == null
          ? _value.branch
          // ignore: cast_nullable_to_non_nullable
          : branch as List<ResourceAgenda>,
    );
  }
}

extension $ResourceCategoryCopyWith on ResourceCategory {
  /// Returns a callable class that can be used as follows: `instanceOfResourceCategory.copyWith(...)` or like so:`instanceOfResourceCategory.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ResourceCategoryCWProxy get copyWith => _$ResourceCategoryCWProxyImpl(this);
}
