// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../action_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ActionListCWProxy {
  ActionList action(List<Action> action);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ActionList(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ActionList(...).copyWith(id: 12, name: "My name")
  /// ```
  ActionList call({
    List<Action> action,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfActionList.copyWith(...)` or call `instanceOfActionList.copyWith.fieldName(value)` for a single field.
class _$ActionListCWProxyImpl implements _$ActionListCWProxy {
  const _$ActionListCWProxyImpl(this._value);

  final ActionList _value;

  @override
  ActionList action(List<Action> action) => call(action: action);

  @override

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ActionList(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ActionList(...).copyWith(id: 12, name: "My name")
  /// ```
  ActionList call({
    Object? action = const $CopyWithPlaceholder(),
  }) {
    return ActionList(
      action: action == const $CopyWithPlaceholder()
          ? _value.action
          // ignore: cast_nullable_to_non_nullable
          : action as List<Action>,
    );
  }
}

extension $ActionListCopyWith on ActionList {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfActionList.copyWith(...)` or `instanceOfActionList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ActionListCWProxy get copyWith => _$ActionListCWProxyImpl(this);
}
