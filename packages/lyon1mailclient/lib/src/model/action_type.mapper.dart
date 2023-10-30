// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'action_type.dart';

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
      case 000:
        return ActionType.archive;
      case 100:
        return ActionType.markAsRead;
      case 200:
        return ActionType.markAsUnread;
      case 300:
        return ActionType.move;
      case 400:
        return ActionType.send;
      case 500:
        return ActionType.reply;
      case 700:
        return ActionType.forward;
      case 800:
        return ActionType.delete;
      case 900:
        return ActionType.flag;
      case 1000:
        return ActionType.unflag;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ActionType self) {
    switch (self) {
      case ActionType.archive:
        return 000;
      case ActionType.markAsRead:
        return 100;
      case ActionType.markAsUnread:
        return 200;
      case ActionType.move:
        return 300;
      case ActionType.send:
        return 400;
      case ActionType.reply:
        return 500;
      case ActionType.forward:
        return 700;
      case ActionType.delete:
        return 800;
      case ActionType.flag:
        return 900;
      case ActionType.unflag:
        return 1000;
    }
  }
}

extension ActionTypeMapperExtension on ActionType {
  dynamic toValue() {
    ActionTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ActionType>(this);
  }
}
