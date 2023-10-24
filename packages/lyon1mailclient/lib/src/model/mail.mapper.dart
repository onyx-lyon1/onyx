// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'mail.dart';

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

  static MimeMessage? _$rawMail(Mail v) => v.rawMail;
  static const Field<Mail, MimeMessage> _f$rawMail =
      Field('rawMail', _$rawMail);
  static const Field<Mail, bool> _f$removeTrackingImages = Field(
      'removeTrackingImages', null,
      mode: FieldMode.param, opt: true, def: false);
  static String _$subject(Mail v) => v.subject;
  static const Field<Mail, String> _f$subject =
      Field('subject', _$subject, mode: FieldMode.member);
  static String _$sender(Mail v) => v.sender;
  static const Field<Mail, String> _f$sender =
      Field('sender', _$sender, mode: FieldMode.member);
  static String _$excerpt(Mail v) => v.excerpt;
  static const Field<Mail, String> _f$excerpt =
      Field('excerpt', _$excerpt, mode: FieldMode.member);
  static String _$body(Mail v) => v.body;
  static const Field<Mail, String> _f$body =
      Field('body', _$body, mode: FieldMode.member);
  static int? _$id(Mail v) => v.id;
  static const Field<Mail, int> _f$id =
      Field('id', _$id, mode: FieldMode.member);
  static bool _$isRead(Mail v) => v.isRead;
  static const Field<Mail, bool> _f$isRead =
      Field('isRead', _$isRead, mode: FieldMode.member);
  static bool _$isFlagged(Mail v) => v.isFlagged;
  static const Field<Mail, bool> _f$isFlagged =
      Field('isFlagged', _$isFlagged, mode: FieldMode.member);
  static DateTime _$date(Mail v) => v.date;
  static const Field<Mail, DateTime> _f$date =
      Field('date', _$date, mode: FieldMode.member);
  static String _$receiver(Mail v) => v.receiver;
  static const Field<Mail, String> _f$receiver =
      Field('receiver', _$receiver, mode: FieldMode.member);
  static List<String> _$attachments(Mail v) => v.attachments;
  static const Field<Mail, List<String>> _f$attachments =
      Field('attachments', _$attachments, mode: FieldMode.member);
  static List<File> _$attachmentsFiles(Mail v) => v.attachmentsFiles;
  static const Field<Mail, List<File>> _f$attachmentsFiles =
      Field('attachmentsFiles', _$attachmentsFiles, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<Mail, dynamic>> fields = const {
    #rawMail: _f$rawMail,
    #removeTrackingImages: _f$removeTrackingImages,
    #subject: _f$subject,
    #sender: _f$sender,
    #excerpt: _f$excerpt,
    #body: _f$body,
    #id: _f$id,
    #isRead: _f$isRead,
    #isFlagged: _f$isFlagged,
    #date: _f$date,
    #receiver: _f$receiver,
    #attachments: _f$attachments,
    #attachmentsFiles: _f$attachmentsFiles,
  };

  static Mail _instantiate(DecodingData data) {
    return Mail.fromRaw(data.dec(_f$rawMail),
        removeTrackingImages: data.dec(_f$removeTrackingImages));
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
      _MailCopyWithImpl(this as Mail, $identity, $identity);
  @override
  String toString() {
    return MailMapper.ensureInitialized().stringifyValue(this as Mail);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MailMapper.ensureInitialized().isValueEqual(this as Mail, other));
  }

  @override
  int get hashCode {
    return MailMapper.ensureInitialized().hashValue(this as Mail);
  }
}

extension MailValueCopy<$R, $Out> on ObjectCopyWith<$R, Mail, $Out> {
  MailCopyWith<$R, Mail, $Out> get $asMail =>
      $base.as((v, t, t2) => _MailCopyWithImpl(v, t, t2));
}

abstract class MailCopyWith<$R, $In extends Mail, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({MimeMessage? rawMail, required bool removeTrackingImages});
  MailCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MailCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Mail, $Out>
    implements MailCopyWith<$R, Mail, $Out> {
  _MailCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Mail> $mapper = MailMapper.ensureInitialized();
  @override
  $R call({Object? rawMail = $none, required bool removeTrackingImages}) =>
      $apply(FieldCopyWithData({
        if (rawMail != $none) #rawMail: rawMail,
        #removeTrackingImages: removeTrackingImages
      }));
  @override
  Mail $make(CopyWithData data) =>
      Mail.fromRaw(data.get(#rawMail, or: $value.rawMail),
          removeTrackingImages: data.get(#removeTrackingImages));

  @override
  MailCopyWith<$R2, Mail, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MailCopyWithImpl($value, $cast, t);
}
