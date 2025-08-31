// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../mail_box_list.dart';

class MailBoxListMapper extends ClassMapperBase<MailBoxList> {
  MailBoxListMapper._();

  static MailBoxListMapper? _instance;
  static MailBoxListMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MailBoxListMapper._());
      MailBoxMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MailBoxList';

  static List<MailBox> _$mailBoxes(MailBoxList v) => v.mailBoxes;
  static const Field<MailBoxList, List<MailBox>> _f$mailBoxes = Field(
    'mailBoxes',
    _$mailBoxes,
  );

  @override
  final MappableFields<MailBoxList> fields = const {#mailBoxes: _f$mailBoxes};

  static MailBoxList _instantiate(DecodingData data) {
    return MailBoxList(mailBoxes: data.dec(_f$mailBoxes));
  }

  @override
  final Function instantiate = _instantiate;

  static MailBoxList fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MailBoxList>(map);
  }

  static MailBoxList fromJson(String json) {
    return ensureInitialized().decodeJson<MailBoxList>(json);
  }
}

mixin MailBoxListMappable {
  String toJson() {
    return MailBoxListMapper.ensureInitialized().encodeJson<MailBoxList>(
      this as MailBoxList,
    );
  }

  Map<String, dynamic> toMap() {
    return MailBoxListMapper.ensureInitialized().encodeMap<MailBoxList>(
      this as MailBoxList,
    );
  }

  MailBoxListCopyWith<MailBoxList, MailBoxList, MailBoxList> get copyWith =>
      _MailBoxListCopyWithImpl<MailBoxList, MailBoxList>(
        this as MailBoxList,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MailBoxListMapper.ensureInitialized().stringifyValue(
      this as MailBoxList,
    );
  }

  @override
  bool operator ==(Object other) {
    return MailBoxListMapper.ensureInitialized().equalsValue(
      this as MailBoxList,
      other,
    );
  }

  @override
  int get hashCode {
    return MailBoxListMapper.ensureInitialized().hashValue(this as MailBoxList);
  }
}

extension MailBoxListValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MailBoxList, $Out> {
  MailBoxListCopyWith<$R, MailBoxList, $Out> get $asMailBoxList =>
      $base.as((v, t, t2) => _MailBoxListCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MailBoxListCopyWith<$R, $In extends MailBoxList, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, MailBox, MailBoxCopyWith<$R, MailBox, MailBox>>
  get mailBoxes;
  $R call({List<MailBox>? mailBoxes});
  MailBoxListCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MailBoxListCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MailBoxList, $Out>
    implements MailBoxListCopyWith<$R, MailBoxList, $Out> {
  _MailBoxListCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MailBoxList> $mapper =
      MailBoxListMapper.ensureInitialized();
  @override
  ListCopyWith<$R, MailBox, MailBoxCopyWith<$R, MailBox, MailBox>>
  get mailBoxes => ListCopyWith(
    $value.mailBoxes,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(mailBoxes: v),
  );
  @override
  $R call({List<MailBox>? mailBoxes}) =>
      $apply(FieldCopyWithData({if (mailBoxes != null) #mailBoxes: mailBoxes}));
  @override
  MailBoxList $make(CopyWithData data) =>
      MailBoxList(mailBoxes: data.get(#mailBoxes, or: $value.mailBoxes));

  @override
  MailBoxListCopyWith<$R2, MailBoxList, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MailBoxListCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

