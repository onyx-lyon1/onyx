// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../izly_qrcode.dart';

class IzlyQrCodeMapper extends ClassMapperBase<IzlyQrCode> {
  IzlyQrCodeMapper._();

  static IzlyQrCodeMapper? _instance;
  static IzlyQrCodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IzlyQrCodeMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'IzlyQrCode';

  static Uint8List _$qrCode(IzlyQrCode v) => v.qrCode;
  static const Field<IzlyQrCode, Uint8List> _f$qrCode = Field(
    'qrCode',
    _$qrCode,
  );
  static DateTime _$expirationDate(IzlyQrCode v) => v.expirationDate;
  static const Field<IzlyQrCode, DateTime> _f$expirationDate = Field(
    'expirationDate',
    _$expirationDate,
  );

  @override
  final MappableFields<IzlyQrCode> fields = const {
    #qrCode: _f$qrCode,
    #expirationDate: _f$expirationDate,
  };

  static IzlyQrCode _instantiate(DecodingData data) {
    return IzlyQrCode(
      qrCode: data.dec(_f$qrCode),
      expirationDate: data.dec(_f$expirationDate),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static IzlyQrCode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IzlyQrCode>(map);
  }

  static IzlyQrCode fromJson(String json) {
    return ensureInitialized().decodeJson<IzlyQrCode>(json);
  }
}

mixin IzlyQrCodeMappable {
  String toJson() {
    return IzlyQrCodeMapper.ensureInitialized().encodeJson<IzlyQrCode>(
      this as IzlyQrCode,
    );
  }

  Map<String, dynamic> toMap() {
    return IzlyQrCodeMapper.ensureInitialized().encodeMap<IzlyQrCode>(
      this as IzlyQrCode,
    );
  }

  IzlyQrCodeCopyWith<IzlyQrCode, IzlyQrCode, IzlyQrCode> get copyWith =>
      _IzlyQrCodeCopyWithImpl<IzlyQrCode, IzlyQrCode>(
        this as IzlyQrCode,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return IzlyQrCodeMapper.ensureInitialized().stringifyValue(
      this as IzlyQrCode,
    );
  }

  @override
  bool operator ==(Object other) {
    return IzlyQrCodeMapper.ensureInitialized().equalsValue(
      this as IzlyQrCode,
      other,
    );
  }

  @override
  int get hashCode {
    return IzlyQrCodeMapper.ensureInitialized().hashValue(this as IzlyQrCode);
  }
}

extension IzlyQrCodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IzlyQrCode, $Out> {
  IzlyQrCodeCopyWith<$R, IzlyQrCode, $Out> get $asIzlyQrCode =>
      $base.as((v, t, t2) => _IzlyQrCodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class IzlyQrCodeCopyWith<$R, $In extends IzlyQrCode, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Uint8List? qrCode, DateTime? expirationDate});
  IzlyQrCodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IzlyQrCodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IzlyQrCode, $Out>
    implements IzlyQrCodeCopyWith<$R, IzlyQrCode, $Out> {
  _IzlyQrCodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IzlyQrCode> $mapper =
      IzlyQrCodeMapper.ensureInitialized();
  @override
  $R call({Uint8List? qrCode, DateTime? expirationDate}) => $apply(
    FieldCopyWithData({
      if (qrCode != null) #qrCode: qrCode,
      if (expirationDate != null) #expirationDate: expirationDate,
    }),
  );
  @override
  IzlyQrCode $make(CopyWithData data) => IzlyQrCode(
    qrCode: data.get(#qrCode, or: $value.qrCode),
    expirationDate: data.get(#expirationDate, or: $value.expirationDate),
  );

  @override
  IzlyQrCodeCopyWith<$R2, IzlyQrCode, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _IzlyQrCodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

