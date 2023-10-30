// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'izly_cubit.dart';

class IzlyStatusMapper extends EnumMapper<IzlyStatus> {
  IzlyStatusMapper._();

  static IzlyStatusMapper? _instance;
  static IzlyStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IzlyStatusMapper._());
    }
    return _instance!;
  }

  static IzlyStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  IzlyStatus decode(dynamic value) {
    switch (value) {
      case 000:
        return IzlyStatus.initial;
      case 100:
        return IzlyStatus.connecting;
      case 200:
        return IzlyStatus.connected;
      case 300:
        return IzlyStatus.loading;
      case 400:
        return IzlyStatus.loaded;
      case 500:
        return IzlyStatus.cacheLoaded;
      case 600:
        return IzlyStatus.error;
      case 700:
        return IzlyStatus.noCredentials;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(IzlyStatus self) {
    switch (self) {
      case IzlyStatus.initial:
        return 000;
      case IzlyStatus.connecting:
        return 100;
      case IzlyStatus.connected:
        return 200;
      case IzlyStatus.loading:
        return 300;
      case IzlyStatus.loaded:
        return 400;
      case IzlyStatus.cacheLoaded:
        return 500;
      case IzlyStatus.error:
        return 600;
      case IzlyStatus.noCredentials:
        return 700;
    }
  }
}

extension IzlyStatusMapperExtension on IzlyStatus {
  dynamic toValue() {
    IzlyStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<IzlyStatus>(this);
  }
}

class IzlyStateMapper extends ClassMapperBase<IzlyState> {
  IzlyStateMapper._();

  static IzlyStateMapper? _instance;
  static IzlyStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IzlyStateMapper._());
      IzlyStatusMapper.ensureInitialized();
      IzlyPaymentModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'IzlyState';

  static IzlyClient? _$izlyClient(IzlyState v) => v.izlyClient;
  static const Field<IzlyState, IzlyClient> _f$izlyClient =
      Field('izlyClient', _$izlyClient, opt: true);
  static IzlyStatus _$status(IzlyState v) => v.status;
  static const Field<IzlyState, IzlyStatus> _f$status =
      Field('status', _$status, opt: true, def: IzlyStatus.initial);
  static double _$balance(IzlyState v) => v.balance;
  static const Field<IzlyState, double> _f$balance =
      Field('balance', _$balance, opt: true, def: 0.0);
  static List<int>? _$qrCode(IzlyState v) => v.qrCode;
  static const Field<IzlyState, List<int>> _f$qrCode =
      Field('qrCode', _$qrCode, opt: true);
  static int _$qrCodeAvailables(IzlyState v) => v.qrCodeAvailables;
  static const Field<IzlyState, int> _f$qrCodeAvailables =
      Field('qrCodeAvailables', _$qrCodeAvailables, opt: true, def: 0);
  static List<IzlyPaymentModel> _$paymentList(IzlyState v) => v.paymentList;
  static const Field<IzlyState, List<IzlyPaymentModel>> _f$paymentList =
      Field('paymentList', _$paymentList, opt: true, def: const []);

  @override
  final Map<Symbol, Field<IzlyState, dynamic>> fields = const {
    #izlyClient: _f$izlyClient,
    #status: _f$status,
    #balance: _f$balance,
    #qrCode: _f$qrCode,
    #qrCodeAvailables: _f$qrCodeAvailables,
    #paymentList: _f$paymentList,
  };

  static IzlyState _instantiate(DecodingData data) {
    return IzlyState(
        izlyClient: data.dec(_f$izlyClient),
        status: data.dec(_f$status),
        balance: data.dec(_f$balance),
        qrCode: data.dec(_f$qrCode),
        qrCodeAvailables: data.dec(_f$qrCodeAvailables),
        paymentList: data.dec(_f$paymentList));
  }

  @override
  final Function instantiate = _instantiate;

  static IzlyState fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IzlyState>(map);
  }

  static IzlyState deserialize(String json) {
    return ensureInitialized().decodeJson<IzlyState>(json);
  }
}

mixin IzlyStateMappable {
  String serialize() {
    return IzlyStateMapper.ensureInitialized()
        .encodeJson<IzlyState>(this as IzlyState);
  }

  Map<String, dynamic> toJson() {
    return IzlyStateMapper.ensureInitialized()
        .encodeMap<IzlyState>(this as IzlyState);
  }

  IzlyStateCopyWith<IzlyState, IzlyState, IzlyState> get copyWith =>
      _IzlyStateCopyWithImpl(this as IzlyState, $identity, $identity);
  @override
  String toString() {
    return IzlyStateMapper.ensureInitialized()
        .stringifyValue(this as IzlyState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IzlyStateMapper.ensureInitialized()
                .isValueEqual(this as IzlyState, other));
  }

  @override
  int get hashCode {
    return IzlyStateMapper.ensureInitialized().hashValue(this as IzlyState);
  }
}

extension IzlyStateValueCopy<$R, $Out> on ObjectCopyWith<$R, IzlyState, $Out> {
  IzlyStateCopyWith<$R, IzlyState, $Out> get $asIzlyState =>
      $base.as((v, t, t2) => _IzlyStateCopyWithImpl(v, t, t2));
}

abstract class IzlyStateCopyWith<$R, $In extends IzlyState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>>? get qrCode;
  ListCopyWith<$R, IzlyPaymentModel,
          IzlyPaymentModelCopyWith<$R, IzlyPaymentModel, IzlyPaymentModel>>
      get paymentList;
  $R call(
      {IzlyClient? izlyClient,
      IzlyStatus? status,
      double? balance,
      List<int>? qrCode,
      int? qrCodeAvailables,
      List<IzlyPaymentModel>? paymentList});
  IzlyStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IzlyStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IzlyState, $Out>
    implements IzlyStateCopyWith<$R, IzlyState, $Out> {
  _IzlyStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IzlyState> $mapper =
      IzlyStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>>? get qrCode =>
      $value.qrCode != null
          ? ListCopyWith($value.qrCode!,
              (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(qrCode: v))
          : null;
  @override
  ListCopyWith<$R, IzlyPaymentModel,
          IzlyPaymentModelCopyWith<$R, IzlyPaymentModel, IzlyPaymentModel>>
      get paymentList => ListCopyWith($value.paymentList,
          (v, t) => v.copyWith.$chain(t), (v) => call(paymentList: v));
  @override
  $R call(
          {Object? izlyClient = $none,
          IzlyStatus? status,
          double? balance,
          Object? qrCode = $none,
          int? qrCodeAvailables,
          List<IzlyPaymentModel>? paymentList}) =>
      $apply(FieldCopyWithData({
        if (izlyClient != $none) #izlyClient: izlyClient,
        if (status != null) #status: status,
        if (balance != null) #balance: balance,
        if (qrCode != $none) #qrCode: qrCode,
        if (qrCodeAvailables != null) #qrCodeAvailables: qrCodeAvailables,
        if (paymentList != null) #paymentList: paymentList
      }));
  @override
  IzlyState $make(CopyWithData data) => IzlyState(
      izlyClient: data.get(#izlyClient, or: $value.izlyClient),
      status: data.get(#status, or: $value.status),
      balance: data.get(#balance, or: $value.balance),
      qrCode: data.get(#qrCode, or: $value.qrCode),
      qrCodeAvailables:
          data.get(#qrCodeAvailables, or: $value.qrCodeAvailables),
      paymentList: data.get(#paymentList, or: $value.paymentList));

  @override
  IzlyStateCopyWith<$R2, IzlyState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IzlyStateCopyWithImpl($value, $cast, t);
}
