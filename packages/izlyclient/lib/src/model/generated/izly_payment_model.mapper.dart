// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../izly_payment_model.dart';

class IzlyPaymentModelMapper extends ClassMapperBase<IzlyPaymentModel> {
  IzlyPaymentModelMapper._();

  static IzlyPaymentModelMapper? _instance;
  static IzlyPaymentModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IzlyPaymentModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'IzlyPaymentModel';

  static DateTime _$paymentTime(IzlyPaymentModel v) => v.paymentTime;
  static const Field<IzlyPaymentModel, DateTime> _f$paymentTime = Field(
    'paymentTime',
    _$paymentTime,
  );
  static double _$amountSpent(IzlyPaymentModel v) => v.amountSpent;
  static const Field<IzlyPaymentModel, double> _f$amountSpent = Field(
    'amountSpent',
    _$amountSpent,
  );
  static bool _$isSucess(IzlyPaymentModel v) => v.isSucess;
  static const Field<IzlyPaymentModel, bool> _f$isSucess = Field(
    'isSucess',
    _$isSucess,
  );

  @override
  final MappableFields<IzlyPaymentModel> fields = const {
    #paymentTime: _f$paymentTime,
    #amountSpent: _f$amountSpent,
    #isSucess: _f$isSucess,
  };

  static IzlyPaymentModel _instantiate(DecodingData data) {
    return IzlyPaymentModel(
      paymentTime: data.dec(_f$paymentTime),
      amountSpent: data.dec(_f$amountSpent),
      isSucess: data.dec(_f$isSucess),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static IzlyPaymentModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IzlyPaymentModel>(map);
  }

  static IzlyPaymentModel fromJson(String json) {
    return ensureInitialized().decodeJson<IzlyPaymentModel>(json);
  }
}

mixin IzlyPaymentModelMappable {
  String toJson() {
    return IzlyPaymentModelMapper.ensureInitialized()
        .encodeJson<IzlyPaymentModel>(this as IzlyPaymentModel);
  }

  Map<String, dynamic> toMap() {
    return IzlyPaymentModelMapper.ensureInitialized()
        .encodeMap<IzlyPaymentModel>(this as IzlyPaymentModel);
  }

  IzlyPaymentModelCopyWith<IzlyPaymentModel, IzlyPaymentModel, IzlyPaymentModel>
  get copyWith =>
      _IzlyPaymentModelCopyWithImpl<IzlyPaymentModel, IzlyPaymentModel>(
        this as IzlyPaymentModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return IzlyPaymentModelMapper.ensureInitialized().stringifyValue(
      this as IzlyPaymentModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return IzlyPaymentModelMapper.ensureInitialized().equalsValue(
      this as IzlyPaymentModel,
      other,
    );
  }

  @override
  int get hashCode {
    return IzlyPaymentModelMapper.ensureInitialized().hashValue(
      this as IzlyPaymentModel,
    );
  }
}

extension IzlyPaymentModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IzlyPaymentModel, $Out> {
  IzlyPaymentModelCopyWith<$R, IzlyPaymentModel, $Out>
  get $asIzlyPaymentModel =>
      $base.as((v, t, t2) => _IzlyPaymentModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class IzlyPaymentModelCopyWith<$R, $In extends IzlyPaymentModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({DateTime? paymentTime, double? amountSpent, bool? isSucess});
  IzlyPaymentModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _IzlyPaymentModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IzlyPaymentModel, $Out>
    implements IzlyPaymentModelCopyWith<$R, IzlyPaymentModel, $Out> {
  _IzlyPaymentModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IzlyPaymentModel> $mapper =
      IzlyPaymentModelMapper.ensureInitialized();
  @override
  $R call({DateTime? paymentTime, double? amountSpent, bool? isSucess}) =>
      $apply(
        FieldCopyWithData({
          if (paymentTime != null) #paymentTime: paymentTime,
          if (amountSpent != null) #amountSpent: amountSpent,
          if (isSucess != null) #isSucess: isSucess,
        }),
      );
  @override
  IzlyPaymentModel $make(CopyWithData data) => IzlyPaymentModel(
    paymentTime: data.get(#paymentTime, or: $value.paymentTime),
    amountSpent: data.get(#amountSpent, or: $value.amountSpent),
    isSucess: data.get(#isSucess, or: $value.isSucess),
  );

  @override
  IzlyPaymentModelCopyWith<$R2, IzlyPaymentModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _IzlyPaymentModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

