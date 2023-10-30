// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'email_cubit.dart';

class MailStatusMapper extends EnumMapper<MailStatus> {
  MailStatusMapper._();

  static MailStatusMapper? _instance;
  static MailStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MailStatusMapper._());
    }
    return _instance!;
  }

  static MailStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  MailStatus decode(dynamic value) {
    switch (value) {
      case 000:
        return MailStatus.initial;
      case 100:
        return MailStatus.connecting;
      case 200:
        return MailStatus.connected;
      case 300:
        return MailStatus.loading;
      case 400:
        return MailStatus.cacheLoaded;
      case 500:
        return MailStatus.loaded;
      case 600:
        return MailStatus.sending;
      case 700:
        return MailStatus.sended;
      case 800:
        return MailStatus.updated;
      case 900:
        return MailStatus.error;
      case 1000:
        return MailStatus.nonFatalError;
      case 1100:
        return MailStatus.sorted;
      case 1200:
        return MailStatus.cacheSorted;
      case 1300:
        return MailStatus.mailboxesLoaded;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(MailStatus self) {
    switch (self) {
      case MailStatus.initial:
        return 000;
      case MailStatus.connecting:
        return 100;
      case MailStatus.connected:
        return 200;
      case MailStatus.loading:
        return 300;
      case MailStatus.cacheLoaded:
        return 400;
      case MailStatus.loaded:
        return 500;
      case MailStatus.sending:
        return 600;
      case MailStatus.sended:
        return 700;
      case MailStatus.updated:
        return 800;
      case MailStatus.error:
        return 900;
      case MailStatus.nonFatalError:
        return 1000;
      case MailStatus.sorted:
        return 1100;
      case MailStatus.cacheSorted:
        return 1200;
      case MailStatus.mailboxesLoaded:
        return 1300;
    }
  }
}

extension MailStatusMapperExtension on MailStatus {
  dynamic toValue() {
    MailStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<MailStatus>(this);
  }
}

class EmailStateMapper extends ClassMapperBase<EmailState> {
  EmailStateMapper._();

  static EmailStateMapper? _instance;
  static EmailStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EmailStateMapper._());
      MailStatusMapper.ensureInitialized();
      MailBoxMapper.ensureInitialized();
      MailMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'EmailState';

  static MailStatus _$status(EmailState v) => v.status;
  static const Field<EmailState, MailStatus> _f$status =
      Field('status', _$status, opt: true, def: MailStatus.initial);
  static List<MailBox> _$mailBoxes(EmailState v) => v.mailBoxes;
  static const Field<EmailState, List<MailBox>> _f$mailBoxes =
      Field('mailBoxes', _$mailBoxes, opt: true, def: const []);
  static MailBox? _$currentMailBox(EmailState v) => v.currentMailBox;
  static const Field<EmailState, MailBox> _f$currentMailBox =
      Field('currentMailBox', _$currentMailBox, opt: true);
  static int _$emailNumber(EmailState v) => v.emailNumber;
  static const Field<EmailState, int> _f$emailNumber =
      Field('emailNumber', _$emailNumber, opt: true, def: 20);
  static bool _$connected(EmailState v) => v.connected;
  static const Field<EmailState, bool> _f$connected =
      Field('connected', _$connected, opt: true, def: false);
  static List<Mail> _$selectedMails(EmailState v) => v.selectedMails;
  static const Field<EmailState, List<Mail>> _f$selectedMails =
      Field('selectedMails', _$selectedMails, opt: true, def: const []);

  @override
  final Map<Symbol, Field<EmailState, dynamic>> fields = const {
    #status: _f$status,
    #mailBoxes: _f$mailBoxes,
    #currentMailBox: _f$currentMailBox,
    #emailNumber: _f$emailNumber,
    #connected: _f$connected,
    #selectedMails: _f$selectedMails,
  };

  static EmailState _instantiate(DecodingData data) {
    return EmailState(
        status: data.dec(_f$status),
        mailBoxes: data.dec(_f$mailBoxes),
        currentMailBox: data.dec(_f$currentMailBox),
        emailNumber: data.dec(_f$emailNumber),
        connected: data.dec(_f$connected),
        selectedMails: data.dec(_f$selectedMails));
  }

  @override
  final Function instantiate = _instantiate;

  static EmailState fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EmailState>(map);
  }

  static EmailState deserialize(String json) {
    return ensureInitialized().decodeJson<EmailState>(json);
  }
}

mixin EmailStateMappable {
  String serialize() {
    return EmailStateMapper.ensureInitialized()
        .encodeJson<EmailState>(this as EmailState);
  }

  Map<String, dynamic> toJson() {
    return EmailStateMapper.ensureInitialized()
        .encodeMap<EmailState>(this as EmailState);
  }

  EmailStateCopyWith<EmailState, EmailState, EmailState> get copyWith =>
      _EmailStateCopyWithImpl(this as EmailState, $identity, $identity);
  @override
  String toString() {
    return EmailStateMapper.ensureInitialized()
        .stringifyValue(this as EmailState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            EmailStateMapper.ensureInitialized()
                .isValueEqual(this as EmailState, other));
  }

  @override
  int get hashCode {
    return EmailStateMapper.ensureInitialized().hashValue(this as EmailState);
  }
}

extension EmailStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EmailState, $Out> {
  EmailStateCopyWith<$R, EmailState, $Out> get $asEmailState =>
      $base.as((v, t, t2) => _EmailStateCopyWithImpl(v, t, t2));
}

abstract class EmailStateCopyWith<$R, $In extends EmailState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, MailBox, MailBoxCopyWith<$R, MailBox, MailBox>>
      get mailBoxes;
  MailBoxCopyWith<$R, MailBox, MailBox>? get currentMailBox;
  ListCopyWith<$R, Mail, MailCopyWith<$R, Mail, Mail>> get selectedMails;
  $R call(
      {MailStatus? status,
      List<MailBox>? mailBoxes,
      MailBox? currentMailBox,
      int? emailNumber,
      bool? connected,
      List<Mail>? selectedMails});
  EmailStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EmailStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EmailState, $Out>
    implements EmailStateCopyWith<$R, EmailState, $Out> {
  _EmailStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EmailState> $mapper =
      EmailStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, MailBox, MailBoxCopyWith<$R, MailBox, MailBox>>
      get mailBoxes => ListCopyWith($value.mailBoxes,
          (v, t) => v.copyWith.$chain(t), (v) => call(mailBoxes: v));
  @override
  MailBoxCopyWith<$R, MailBox, MailBox>? get currentMailBox =>
      $value.currentMailBox?.copyWith.$chain((v) => call(currentMailBox: v));
  @override
  ListCopyWith<$R, Mail, MailCopyWith<$R, Mail, Mail>> get selectedMails =>
      ListCopyWith($value.selectedMails, (v, t) => v.copyWith.$chain(t),
          (v) => call(selectedMails: v));
  @override
  $R call(
          {MailStatus? status,
          List<MailBox>? mailBoxes,
          Object? currentMailBox = $none,
          int? emailNumber,
          bool? connected,
          List<Mail>? selectedMails}) =>
      $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (mailBoxes != null) #mailBoxes: mailBoxes,
        if (currentMailBox != $none) #currentMailBox: currentMailBox,
        if (emailNumber != null) #emailNumber: emailNumber,
        if (connected != null) #connected: connected,
        if (selectedMails != null) #selectedMails: selectedMails
      }));
  @override
  EmailState $make(CopyWithData data) => EmailState(
      status: data.get(#status, or: $value.status),
      mailBoxes: data.get(#mailBoxes, or: $value.mailBoxes),
      currentMailBox: data.get(#currentMailBox, or: $value.currentMailBox),
      emailNumber: data.get(#emailNumber, or: $value.emailNumber),
      connected: data.get(#connected, or: $value.connected),
      selectedMails: data.get(#selectedMails, or: $value.selectedMails));

  @override
  EmailStateCopyWith<$R2, EmailState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EmailStateCopyWithImpl($value, $cast, t);
}
