// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../email_send_cubit.dart';

class EmailSendStateMapper extends ClassMapperBase<EmailSendState> {
  EmailSendStateMapper._();

  static EmailSendStateMapper? _instance;
  static EmailSendStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EmailSendStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EmailSendState';

  static EmailSendStatus _$status(EmailSendState v) => v.status;
  static const Field<EmailSendState, EmailSendStatus> _f$status = Field(
    'status',
    _$status,
  );
  static QuillController? _$controller(EmailSendState v) => v.controller;
  static const Field<EmailSendState, QuillController> _f$controller = Field(
    'controller',
    _$controller,
    opt: true,
  );
  static TextEditingController? _$subjectEditor(EmailSendState v) =>
      v.subjectEditor;
  static const Field<EmailSendState, TextEditingController> _f$subjectEditor =
      Field('subjectEditor', _$subjectEditor, opt: true);
  static TextEditingController? _$destinationEditor(EmailSendState v) =>
      v.destinationEditor;
  static const Field<EmailSendState, TextEditingController>
  _f$destinationEditor = Field(
    'destinationEditor',
    _$destinationEditor,
    opt: true,
  );
  static int? _$originalMessage(EmailSendState v) => v.originalMessage;
  static const Field<EmailSendState, int> _f$originalMessage = Field(
    'originalMessage',
    _$originalMessage,
    opt: true,
  );
  static bool? _$replyAll(EmailSendState v) => v.replyAll;
  static const Field<EmailSendState, bool> _f$replyAll = Field(
    'replyAll',
    _$replyAll,
    opt: true,
  );
  static bool? _$reply(EmailSendState v) => v.reply;
  static const Field<EmailSendState, bool> _f$reply = Field(
    'reply',
    _$reply,
    opt: true,
  );
  static bool? _$forward(EmailSendState v) => v.forward;
  static const Field<EmailSendState, bool> _f$forward = Field(
    'forward',
    _$forward,
    opt: true,
  );
  static List<File> _$attachments(EmailSendState v) => v.attachments;
  static const Field<EmailSendState, List<File>> _f$attachments = Field(
    'attachments',
    _$attachments,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<EmailSendState> fields = const {
    #status: _f$status,
    #controller: _f$controller,
    #subjectEditor: _f$subjectEditor,
    #destinationEditor: _f$destinationEditor,
    #originalMessage: _f$originalMessage,
    #replyAll: _f$replyAll,
    #reply: _f$reply,
    #forward: _f$forward,
    #attachments: _f$attachments,
  };

  static EmailSendState _instantiate(DecodingData data) {
    return EmailSendState(
      status: data.dec(_f$status),
      controller: data.dec(_f$controller),
      subjectEditor: data.dec(_f$subjectEditor),
      destinationEditor: data.dec(_f$destinationEditor),
      originalMessage: data.dec(_f$originalMessage),
      replyAll: data.dec(_f$replyAll),
      reply: data.dec(_f$reply),
      forward: data.dec(_f$forward),
      attachments: data.dec(_f$attachments),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EmailSendState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EmailSendState>(map);
  }

  static EmailSendState fromJson(String json) {
    return ensureInitialized().decodeJson<EmailSendState>(json);
  }
}

mixin EmailSendStateMappable {
  String toJson() {
    return EmailSendStateMapper.ensureInitialized().encodeJson<EmailSendState>(
      this as EmailSendState,
    );
  }

  Map<String, dynamic> toMap() {
    return EmailSendStateMapper.ensureInitialized().encodeMap<EmailSendState>(
      this as EmailSendState,
    );
  }

  EmailSendStateCopyWith<EmailSendState, EmailSendState, EmailSendState>
  get copyWith => _EmailSendStateCopyWithImpl<EmailSendState, EmailSendState>(
    this as EmailSendState,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return EmailSendStateMapper.ensureInitialized().stringifyValue(
      this as EmailSendState,
    );
  }

  @override
  bool operator ==(Object other) {
    return EmailSendStateMapper.ensureInitialized().equalsValue(
      this as EmailSendState,
      other,
    );
  }

  @override
  int get hashCode {
    return EmailSendStateMapper.ensureInitialized().hashValue(
      this as EmailSendState,
    );
  }
}

extension EmailSendStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EmailSendState, $Out> {
  EmailSendStateCopyWith<$R, EmailSendState, $Out> get $asEmailSendState =>
      $base.as((v, t, t2) => _EmailSendStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EmailSendStateCopyWith<$R, $In extends EmailSendState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, File, ObjectCopyWith<$R, File, File>> get attachments;
  $R call({
    EmailSendStatus? status,
    QuillController? controller,
    TextEditingController? subjectEditor,
    TextEditingController? destinationEditor,
    int? originalMessage,
    bool? replyAll,
    bool? reply,
    bool? forward,
    List<File>? attachments,
  });
  EmailSendStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _EmailSendStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EmailSendState, $Out>
    implements EmailSendStateCopyWith<$R, EmailSendState, $Out> {
  _EmailSendStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EmailSendState> $mapper =
      EmailSendStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, File, ObjectCopyWith<$R, File, File>> get attachments =>
      ListCopyWith(
        $value.attachments,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(attachments: v),
      );
  @override
  $R call({
    EmailSendStatus? status,
    Object? controller = $none,
    Object? subjectEditor = $none,
    Object? destinationEditor = $none,
    Object? originalMessage = $none,
    Object? replyAll = $none,
    Object? reply = $none,
    Object? forward = $none,
    List<File>? attachments,
  }) => $apply(
    FieldCopyWithData({
      if (status != null) #status: status,
      if (controller != $none) #controller: controller,
      if (subjectEditor != $none) #subjectEditor: subjectEditor,
      if (destinationEditor != $none) #destinationEditor: destinationEditor,
      if (originalMessage != $none) #originalMessage: originalMessage,
      if (replyAll != $none) #replyAll: replyAll,
      if (reply != $none) #reply: reply,
      if (forward != $none) #forward: forward,
      if (attachments != null) #attachments: attachments,
    }),
  );
  @override
  EmailSendState $make(CopyWithData data) => EmailSendState(
    status: data.get(#status, or: $value.status),
    controller: data.get(#controller, or: $value.controller),
    subjectEditor: data.get(#subjectEditor, or: $value.subjectEditor),
    destinationEditor: data.get(
      #destinationEditor,
      or: $value.destinationEditor,
    ),
    originalMessage: data.get(#originalMessage, or: $value.originalMessage),
    replyAll: data.get(#replyAll, or: $value.replyAll),
    reply: data.get(#reply, or: $value.reply),
    forward: data.get(#forward, or: $value.forward),
    attachments: data.get(#attachments, or: $value.attachments),
  );

  @override
  EmailSendStateCopyWith<$R2, EmailSendState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EmailSendStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

