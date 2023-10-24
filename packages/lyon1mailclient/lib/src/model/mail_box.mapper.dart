// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'mail_box.dart';

class SpecialMailBoxMapper extends EnumMapper<SpecialMailBox> {
  SpecialMailBoxMapper._();

  static SpecialMailBoxMapper? _instance;
  static SpecialMailBoxMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SpecialMailBoxMapper._());
    }
    return _instance!;
  }

  static SpecialMailBox fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SpecialMailBox decode(dynamic value) {
    switch (value) {
      case 000:
        return SpecialMailBox.inbox;
      case 100:
        return SpecialMailBox.sent;
      case 200:
        return SpecialMailBox.trash;
      case 300:
        return SpecialMailBox.flagged;
      case 400:
        return SpecialMailBox.archive;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SpecialMailBox self) {
    switch (self) {
      case SpecialMailBox.inbox:
        return 000;
      case SpecialMailBox.sent:
        return 100;
      case SpecialMailBox.trash:
        return 200;
      case SpecialMailBox.flagged:
        return 300;
      case SpecialMailBox.archive:
        return 400;
    }
  }
}

extension SpecialMailBoxMapperExtension on SpecialMailBox {
  dynamic toValue() {
    SpecialMailBoxMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SpecialMailBox>(this);
  }
}

class MailBoxMapper extends ClassMapperBase<MailBox> {
  MailBoxMapper._();

  static MailBoxMapper? _instance;
  static MailBoxMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MailBoxMapper._());
      MailMapper.ensureInitialized();
      SpecialMailBoxMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MailBox';

  static String _$name(MailBox v) => v.name;
  static const Field<MailBox, String> _f$name = Field('name', _$name);
  static List<Mail> _$emails(MailBox v) => v.emails;
  static const Field<MailBox, List<Mail>> _f$emails = Field('emails', _$emails);
  static SpecialMailBox? _$specialMailBox(MailBox v) => v.specialMailBox;
  static const Field<MailBox, SpecialMailBox> _f$specialMailBox =
      Field('specialMailBox', _$specialMailBox, opt: true);

  @override
  final Map<Symbol, Field<MailBox, dynamic>> fields = const {
    #name: _f$name,
    #emails: _f$emails,
    #specialMailBox: _f$specialMailBox,
  };

  static MailBox _instantiate(DecodingData data) {
    return MailBox(
        name: data.dec(_f$name),
        emails: data.dec(_f$emails),
        specialMailBox: data.dec(_f$specialMailBox));
  }

  @override
  final Function instantiate = _instantiate;

  static MailBox fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MailBox>(map);
  }

  static MailBox fromJson(String json) {
    return ensureInitialized().decodeJson<MailBox>(json);
  }
}

mixin MailBoxMappable {
  String toJson() {
    return MailBoxMapper.ensureInitialized()
        .encodeJson<MailBox>(this as MailBox);
  }

  Map<String, dynamic> toMap() {
    return MailBoxMapper.ensureInitialized()
        .encodeMap<MailBox>(this as MailBox);
  }

  MailBoxCopyWith<MailBox, MailBox, MailBox> get copyWith =>
      _MailBoxCopyWithImpl(this as MailBox, $identity, $identity);
  @override
  String toString() {
    return MailBoxMapper.ensureInitialized().stringifyValue(this as MailBox);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MailBoxMapper.ensureInitialized()
                .isValueEqual(this as MailBox, other));
  }

  @override
  int get hashCode {
    return MailBoxMapper.ensureInitialized().hashValue(this as MailBox);
  }
}

extension MailBoxValueCopy<$R, $Out> on ObjectCopyWith<$R, MailBox, $Out> {
  MailBoxCopyWith<$R, MailBox, $Out> get $asMailBox =>
      $base.as((v, t, t2) => _MailBoxCopyWithImpl(v, t, t2));
}

abstract class MailBoxCopyWith<$R, $In extends MailBox, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Mail, MailCopyWith<$R, Mail, Mail>> get emails;
  $R call({String? name, List<Mail>? emails, SpecialMailBox? specialMailBox});
  MailBoxCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MailBoxCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MailBox, $Out>
    implements MailBoxCopyWith<$R, MailBox, $Out> {
  _MailBoxCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MailBox> $mapper =
      MailBoxMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Mail, MailCopyWith<$R, Mail, Mail>> get emails =>
      ListCopyWith($value.emails, (v, t) => v.copyWith.$chain(t),
          (v) => call(emails: v));
  @override
  $R call({String? name, List<Mail>? emails, Object? specialMailBox = $none}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (emails != null) #emails: emails,
        if (specialMailBox != $none) #specialMailBox: specialMailBox
      }));
  @override
  MailBox $make(CopyWithData data) => MailBox(
      name: data.get(#name, or: $value.name),
      emails: data.get(#emails, or: $value.emails),
      specialMailBox: data.get(#specialMailBox, or: $value.specialMailBox));

  @override
  MailBoxCopyWith<$R2, MailBox, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MailBoxCopyWithImpl($value, $cast, t);
}
