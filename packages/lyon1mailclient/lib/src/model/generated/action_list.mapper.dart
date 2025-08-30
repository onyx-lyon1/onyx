// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../action_list.dart';

class ActionListMapper extends ClassMapperBase<ActionList> {
  ActionListMapper._();

  static ActionListMapper? _instance;
  static ActionListMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ActionListMapper._());
      ActionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ActionList';

  static List<Action> _$action(ActionList v) => v.action;
  static const Field<ActionList, List<Action>> _f$action = Field(
    'action',
    _$action,
  );

  @override
  final MappableFields<ActionList> fields = const {#action: _f$action};

  static ActionList _instantiate(DecodingData data) {
    return ActionList(action: data.dec(_f$action));
  }

  @override
  final Function instantiate = _instantiate;

  static ActionList fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ActionList>(map);
  }

  static ActionList fromJson(String json) {
    return ensureInitialized().decodeJson<ActionList>(json);
  }
}

mixin ActionListMappable {
  String toJson() {
    return ActionListMapper.ensureInitialized().encodeJson<ActionList>(
      this as ActionList,
    );
  }

  Map<String, dynamic> toMap() {
    return ActionListMapper.ensureInitialized().encodeMap<ActionList>(
      this as ActionList,
    );
  }

  ActionListCopyWith<ActionList, ActionList, ActionList> get copyWith =>
      _ActionListCopyWithImpl<ActionList, ActionList>(
        this as ActionList,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ActionListMapper.ensureInitialized().stringifyValue(
      this as ActionList,
    );
  }

  @override
  bool operator ==(Object other) {
    return ActionListMapper.ensureInitialized().equalsValue(
      this as ActionList,
      other,
    );
  }

  @override
  int get hashCode {
    return ActionListMapper.ensureInitialized().hashValue(this as ActionList);
  }
}

extension ActionListValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ActionList, $Out> {
  ActionListCopyWith<$R, ActionList, $Out> get $asActionList =>
      $base.as((v, t, t2) => _ActionListCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ActionListCopyWith<$R, $In extends ActionList, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Action, ActionCopyWith<$R, Action, Action>> get action;
  $R call({List<Action>? action});
  ActionListCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ActionListCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ActionList, $Out>
    implements ActionListCopyWith<$R, ActionList, $Out> {
  _ActionListCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ActionList> $mapper =
      ActionListMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Action, ActionCopyWith<$R, Action, Action>> get action =>
      ListCopyWith(
        $value.action,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(action: v),
      );
  @override
  $R call({List<Action>? action}) =>
      $apply(FieldCopyWithData({if (action != null) #action: action}));
  @override
  ActionList $make(CopyWithData data) =>
      ActionList(action: data.get(#action, or: $value.action));

  @override
  ActionListCopyWith<$R2, ActionList, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ActionListCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

