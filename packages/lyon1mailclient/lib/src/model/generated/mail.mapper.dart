// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../mail.dart';

class MailMapper extends ClassMapperBase<Mail> {
  MailMapper._();

  static MailMapper? _instance;
  static MailMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MailMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Mail';

  static String _$subject(Mail v) => v.subject;
  static const Field<Mail, String> _f$subject = Field('subject', _$subject);
  static String _$sender(Mail v) => v.sender;
  static const Field<Mail, String> _f$sender = Field('sender', _$sender);
  static String _$excerpt(Mail v) => v.excerpt;
  static const Field<Mail, String> _f$excerpt = Field('excerpt', _$excerpt);
  static bool _$isRead(Mail v) => v.isRead;
  static const Field<Mail, bool> _f$isRead = Field('isRead', _$isRead);
  static DateTime _$date(Mail v) => v.date;
  static const Field<Mail, DateTime> _f$date = Field('date', _$date);
  static String _$body(Mail v) => v.body;
  static const Field<Mail, String> _f$body = Field('body', _$body);
  static int? _$id(Mail v) => v.id;
  static const Field<Mail, int> _f$id = Field('id', _$id);
  static String _$receiver(Mail v) => v.receiver;
  static const Field<Mail, String> _f$receiver = Field('receiver', _$receiver);
  static List<String> _$attachments(Mail v) => v.attachments;
  static const Field<Mail, List<String>> _f$attachments = Field(
    'attachments',
    _$attachments,
  );
  static bool _$isFlagged(Mail v) => v.isFlagged;
  static const Field<Mail, bool> _f$isFlagged = Field('isFlagged', _$isFlagged);
  static MimeMessage? _$rawMail(Mail v) => v.rawMail;
  static const Field<Mail, MimeMessage> _f$rawMail = Field(
    'rawMail',
    _$rawMail,
    opt: true,
  );
  static List<File> _$attachmentsFiles(Mail v) => v.attachmentsFiles;
  static const Field<Mail, List<File>> _f$attachmentsFiles = Field(
    'attachmentsFiles',
    _$attachmentsFiles,
    opt: true,
    def: const [],
  );
  static bool _$removeTrackingImages(Mail v) => v.removeTrackingImages;
  static const Field<Mail, bool> _f$removeTrackingImages = Field(
    'removeTrackingImages',
    _$removeTrackingImages,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<Mail> fields = const {
    #subject: _f$subject,
    #sender: _f$sender,
    #excerpt: _f$excerpt,
    #isRead: _f$isRead,
    #date: _f$date,
    #body: _f$body,
    #id: _f$id,
    #receiver: _f$receiver,
    #attachments: _f$attachments,
    #isFlagged: _f$isFlagged,
    #rawMail: _f$rawMail,
    #attachmentsFiles: _f$attachmentsFiles,
    #removeTrackingImages: _f$removeTrackingImages,
  };
  @override
  final Iterable<String> ignore = const ['rawMail', 'attachmentsFiles'];

  static Mail _instantiate(DecodingData data) {
    return Mail(
      subject: data.dec(_f$subject),
      sender: data.dec(_f$sender),
      excerpt: data.dec(_f$excerpt),
      isRead: data.dec(_f$isRead),
      date: data.dec(_f$date),
      body: data.dec(_f$body),
      id: data.dec(_f$id),
      receiver: data.dec(_f$receiver),
      attachments: data.dec(_f$attachments),
      isFlagged: data.dec(_f$isFlagged),
      rawMail: data.dec(_f$rawMail),
      attachmentsFiles: data.dec(_f$attachmentsFiles),
      removeTrackingImages: data.dec(_f$removeTrackingImages),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Mail fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Mail>(map);
  }

  static Mail fromJson(String json) {
    return ensureInitialized().decodeJson<Mail>(json);
  }
}

mixin MailMappable {
  String toJson() {
    return MailMapper.ensureInitialized().encodeJson<Mail>(this as Mail);
  }

  Map<String, dynamic> toMap() {
    return MailMapper.ensureInitialized().encodeMap<Mail>(this as Mail);
  }

  MailCopyWith<Mail, Mail, Mail> get copyWith =>
      _MailCopyWithImpl<Mail, Mail>(this as Mail, $identity, $identity);
  @override
  String toString() {
    return MailMapper.ensureInitialized().stringifyValue(this as Mail);
  }

  @override
  bool operator ==(Object other) {
    return MailMapper.ensureInitialized().equalsValue(this as Mail, other);
  }

  @override
  int get hashCode {
    return MailMapper.ensureInitialized().hashValue(this as Mail);
  }
}

extension MailValueCopy<$R, $Out> on ObjectCopyWith<$R, Mail, $Out> {
  MailCopyWith<$R, Mail, $Out> get $asMail =>
      $base.as((v, t, t2) => _MailCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MailCopyWith<$R, $In extends Mail, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get attachments;
  ListCopyWith<$R, File, ObjectCopyWith<$R, File, File>> get attachmentsFiles;
  $R call({
    String? subject,
    String? sender,
    String? excerpt,
    bool? isRead,
    DateTime? date,
    String? body,
    int? id,
    String? receiver,
    List<String>? attachments,
    bool? isFlagged,
    MimeMessage? rawMail,
    List<File>? attachmentsFiles,
    bool? removeTrackingImages,
  });
  MailCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MailCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Mail, $Out>
    implements MailCopyWith<$R, Mail, $Out> {
  _MailCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Mail> $mapper = MailMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get attachments => ListCopyWith(
    $value.attachments,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(attachments: v),
  );
  @override
  ListCopyWith<$R, File, ObjectCopyWith<$R, File, File>> get attachmentsFiles =>
      ListCopyWith(
        $value.attachmentsFiles,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(attachmentsFiles: v),
      );
  @override
  $R call({
    String? subject,
    String? sender,
    String? excerpt,
    bool? isRead,
    DateTime? date,
    String? body,
    Object? id = $none,
    String? receiver,
    List<String>? attachments,
    bool? isFlagged,
    Object? rawMail = $none,
    List<File>? attachmentsFiles,
    bool? removeTrackingImages,
  }) => $apply(
    FieldCopyWithData({
      if (subject != null) #subject: subject,
      if (sender != null) #sender: sender,
      if (excerpt != null) #excerpt: excerpt,
      if (isRead != null) #isRead: isRead,
      if (date != null) #date: date,
      if (body != null) #body: body,
      if (id != $none) #id: id,
      if (receiver != null) #receiver: receiver,
      if (attachments != null) #attachments: attachments,
      if (isFlagged != null) #isFlagged: isFlagged,
      if (rawMail != $none) #rawMail: rawMail,
      if (attachmentsFiles != null) #attachmentsFiles: attachmentsFiles,
      if (removeTrackingImages != null)
        #removeTrackingImages: removeTrackingImages,
    }),
  );
  @override
  Mail $make(CopyWithData data) => Mail(
    subject: data.get(#subject, or: $value.subject),
    sender: data.get(#sender, or: $value.sender),
    excerpt: data.get(#excerpt, or: $value.excerpt),
    isRead: data.get(#isRead, or: $value.isRead),
    date: data.get(#date, or: $value.date),
    body: data.get(#body, or: $value.body),
    id: data.get(#id, or: $value.id),
    receiver: data.get(#receiver, or: $value.receiver),
    attachments: data.get(#attachments, or: $value.attachments),
    isFlagged: data.get(#isFlagged, or: $value.isFlagged),
    rawMail: data.get(#rawMail, or: $value.rawMail),
    attachmentsFiles: data.get(#attachmentsFiles, or: $value.attachmentsFiles),
    removeTrackingImages: data.get(
      #removeTrackingImages,
      or: $value.removeTrackingImages,
    ),
  );

  @override
  MailCopyWith<$R2, Mail, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MailCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

