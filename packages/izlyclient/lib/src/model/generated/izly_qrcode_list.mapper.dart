// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../izly_qrcode_list.dart';

class IzlyQrCodeListMapper extends ClassMapperBase<IzlyQrCodeList> {
  IzlyQrCodeListMapper._();

  static IzlyQrCodeListMapper? _instance;
  static IzlyQrCodeListMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IzlyQrCodeListMapper._());
      IzlyQrCodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'IzlyQrCodeList';

  static List<IzlyQrCode> _$qrCodes(IzlyQrCodeList v) => v.qrCodes;
  static const Field<IzlyQrCodeList, List<IzlyQrCode>> _f$qrCodes = Field(
    'qrCodes',
    _$qrCodes,
  );

  @override
  final MappableFields<IzlyQrCodeList> fields = const {#qrCodes: _f$qrCodes};

  static IzlyQrCodeList _instantiate(DecodingData data) {
    return IzlyQrCodeList(qrCodes: data.dec(_f$qrCodes));
  }

  @override
  final Function instantiate = _instantiate;

  static IzlyQrCodeList fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IzlyQrCodeList>(map);
  }

  static IzlyQrCodeList fromJson(String json) {
    return ensureInitialized().decodeJson<IzlyQrCodeList>(json);
  }
}

mixin IzlyQrCodeListMappable {
  String toJson() {
    return IzlyQrCodeListMapper.ensureInitialized().encodeJson<IzlyQrCodeList>(
      this as IzlyQrCodeList,
    );
  }

  Map<String, dynamic> toMap() {
    return IzlyQrCodeListMapper.ensureInitialized().encodeMap<IzlyQrCodeList>(
      this as IzlyQrCodeList,
    );
  }

  IzlyQrCodeListCopyWith<IzlyQrCodeList, IzlyQrCodeList, IzlyQrCodeList>
  get copyWith => _IzlyQrCodeListCopyWithImpl<IzlyQrCodeList, IzlyQrCodeList>(
    this as IzlyQrCodeList,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return IzlyQrCodeListMapper.ensureInitialized().stringifyValue(
      this as IzlyQrCodeList,
    );
  }

  @override
  bool operator ==(Object other) {
    return IzlyQrCodeListMapper.ensureInitialized().equalsValue(
      this as IzlyQrCodeList,
      other,
    );
  }

  @override
  int get hashCode {
    return IzlyQrCodeListMapper.ensureInitialized().hashValue(
      this as IzlyQrCodeList,
    );
  }
}

extension IzlyQrCodeListValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IzlyQrCodeList, $Out> {
  IzlyQrCodeListCopyWith<$R, IzlyQrCodeList, $Out> get $asIzlyQrCodeList =>
      $base.as((v, t, t2) => _IzlyQrCodeListCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class IzlyQrCodeListCopyWith<$R, $In extends IzlyQrCodeList, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, IzlyQrCode, IzlyQrCodeCopyWith<$R, IzlyQrCode, IzlyQrCode>>
  get qrCodes;
  $R call({List<IzlyQrCode>? qrCodes});
  IzlyQrCodeListCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _IzlyQrCodeListCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IzlyQrCodeList, $Out>
    implements IzlyQrCodeListCopyWith<$R, IzlyQrCodeList, $Out> {
  _IzlyQrCodeListCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IzlyQrCodeList> $mapper =
      IzlyQrCodeListMapper.ensureInitialized();
  @override
  ListCopyWith<$R, IzlyQrCode, IzlyQrCodeCopyWith<$R, IzlyQrCode, IzlyQrCode>>
  get qrCodes => ListCopyWith(
    $value.qrCodes,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(qrCodes: v),
  );
  @override
  $R call({List<IzlyQrCode>? qrCodes}) =>
      $apply(FieldCopyWithData({if (qrCodes != null) #qrCodes: qrCodes}));
  @override
  IzlyQrCodeList $make(CopyWithData data) =>
      IzlyQrCodeList(qrCodes: data.get(#qrCodes, or: $value.qrCodes));

  @override
  IzlyQrCodeListCopyWith<$R2, IzlyQrCodeList, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _IzlyQrCodeListCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

