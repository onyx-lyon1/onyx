// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../action_type.dart';

class ActionTypeMapper extends EnumMapper<ActionType> {
  ActionTypeMapper._();

  static ActionTypeMapper? _instance;
  static ActionTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ActionTypeMapper._());
    }
    return _instance!;
  }

  static ActionType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ActionType decode(dynamic value) {
    switch (value) {
      case r'archive':
        return ActionType.archive;
      case r'markAsRead':
        return ActionType.markAsRead;
      case r'markAsUnread':
        return ActionType.markAsUnread;
      case r'move':
        return ActionType.move;
      case r'send':
        return ActionType.send;
      case r'reply':
        return ActionType.reply;
      case r'forward':
        return ActionType.forward;
      case r'delete':
        return ActionType.delete;
      case r'flag':
        return ActionType.flag;
      case r'unflag':
        return ActionType.unflag;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ActionType self) {
    switch (self) {
      case ActionType.archive:
        return r'archive';
      case ActionType.markAsRead:
        return r'markAsRead';
      case ActionType.markAsUnread:
        return r'markAsUnread';
      case ActionType.move:
        return r'move';
      case ActionType.send:
        return r'send';
      case ActionType.reply:
        return r'reply';
      case ActionType.forward:
        return r'forward';
      case ActionType.delete:
        return r'delete';
      case ActionType.flag:
        return r'flag';
      case ActionType.unflag:
        return r'unflag';
    }
  }
}

extension ActionTypeMapperExtension on ActionType {
  String toValue() {
    ActionTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ActionType>(this) as String;
  }
}

