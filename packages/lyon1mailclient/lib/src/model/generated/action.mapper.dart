// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../action.dart';

class ActionMapper extends ClassMapperBase<Action> {
  ActionMapper._();

  static ActionMapper? _instance;
  static ActionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ActionMapper._());
      MailMapper.ensureInitialized();
      MailBoxMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Action';

  static ActionType _$type(Action v) => v.type;
  static const Field<Action, ActionType> _f$type = Field('type', _$type);
  static Mail _$mail(Action v) => v.mail;
  static const Field<Action, Mail> _f$mail = Field('mail', _$mail);
  static MailBox? _$fromMailBox(Action v) => v.fromMailBox;
  static const Field<Action, MailBox> _f$fromMailBox = Field(
    'fromMailBox',
    _$fromMailBox,
    opt: true,
  );
  static int? _$originalMessageId(Action v) => v.originalMessageId;
  static const Field<Action, int> _f$originalMessageId = Field(
    'originalMessageId',
    _$originalMessageId,
    opt: true,
  );
  static bool? _$replyAll(Action v) => v.replyAll;
  static const Field<Action, bool> _f$replyAll = Field(
    'replyAll',
    _$replyAll,
    opt: true,
  );
  static MailBox? _$destinationMailBox(Action v) => v.destinationMailBox;
  static const Field<Action, MailBox> _f$destinationMailBox = Field(
    'destinationMailBox',
    _$destinationMailBox,
    opt: true,
  );

  @override
  final MappableFields<Action> fields = const {
    #type: _f$type,
    #mail: _f$mail,
    #fromMailBox: _f$fromMailBox,
    #originalMessageId: _f$originalMessageId,
    #replyAll: _f$replyAll,
    #destinationMailBox: _f$destinationMailBox,
  };

  static Action _instantiate(DecodingData data) {
    return Action(
      type: data.dec(_f$type),
      mail: data.dec(_f$mail),
      fromMailBox: data.dec(_f$fromMailBox),
      originalMessageId: data.dec(_f$originalMessageId),
      replyAll: data.dec(_f$replyAll),
      destinationMailBox: data.dec(_f$destinationMailBox),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Action fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Action>(map);
  }

  static Action fromJson(String json) {
    return ensureInitialized().decodeJson<Action>(json);
  }
}

mixin ActionMappable {
  String toJson() {
    return ActionMapper.ensureInitialized().encodeJson<Action>(this as Action);
  }

  Map<String, dynamic> toMap() {
    return ActionMapper.ensureInitialized().encodeMap<Action>(this as Action);
  }

  ActionCopyWith<Action, Action, Action> get copyWith =>
      _ActionCopyWithImpl<Action, Action>(this as Action, $identity, $identity);
  @override
  String toString() {
    return ActionMapper.ensureInitialized().stringifyValue(this as Action);
  }

  @override
  bool operator ==(Object other) {
    return ActionMapper.ensureInitialized().equalsValue(this as Action, other);
  }

  @override
  int get hashCode {
    return ActionMapper.ensureInitialized().hashValue(this as Action);
  }
}

extension ActionValueCopy<$R, $Out> on ObjectCopyWith<$R, Action, $Out> {
  ActionCopyWith<$R, Action, $Out> get $asAction =>
      $base.as((v, t, t2) => _ActionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ActionCopyWith<$R, $In extends Action, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MailCopyWith<$R, Mail, Mail> get mail;
  MailBoxCopyWith<$R, MailBox, MailBox>? get fromMailBox;
  MailBoxCopyWith<$R, MailBox, MailBox>? get destinationMailBox;
  $R call({
    ActionType? type,
    Mail? mail,
    MailBox? fromMailBox,
    int? originalMessageId,
    bool? replyAll,
    MailBox? destinationMailBox,
  });
  ActionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ActionCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Action, $Out>
    implements ActionCopyWith<$R, Action, $Out> {
  _ActionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Action> $mapper = ActionMapper.ensureInitialized();
  @override
  MailCopyWith<$R, Mail, Mail> get mail =>
      $value.mail.copyWith.$chain((v) => call(mail: v));
  @override
  MailBoxCopyWith<$R, MailBox, MailBox>? get fromMailBox =>
      $value.fromMailBox?.copyWith.$chain((v) => call(fromMailBox: v));
  @override
  MailBoxCopyWith<$R, MailBox, MailBox>? get destinationMailBox => $value
      .destinationMailBox
      ?.copyWith
      .$chain((v) => call(destinationMailBox: v));
  @override
  $R call({
    ActionType? type,
    Mail? mail,
    Object? fromMailBox = $none,
    Object? originalMessageId = $none,
    Object? replyAll = $none,
    Object? destinationMailBox = $none,
  }) => $apply(
    FieldCopyWithData({
      if (type != null) #type: type,
      if (mail != null) #mail: mail,
      if (fromMailBox != $none) #fromMailBox: fromMailBox,
      if (originalMessageId != $none) #originalMessageId: originalMessageId,
      if (replyAll != $none) #replyAll: replyAll,
      if (destinationMailBox != $none) #destinationMailBox: destinationMailBox,
    }),
  );
  @override
  Action $make(CopyWithData data) => Action(
    type: data.get(#type, or: $value.type),
    mail: data.get(#mail, or: $value.mail),
    fromMailBox: data.get(#fromMailBox, or: $value.fromMailBox),
    originalMessageId: data.get(
      #originalMessageId,
      or: $value.originalMessageId,
    ),
    replyAll: data.get(#replyAll, or: $value.replyAll),
    destinationMailBox: data.get(
      #destinationMailBox,
      or: $value.destinationMailBox,
    ),
  );

  @override
  ActionCopyWith<$R2, Action, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ActionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

