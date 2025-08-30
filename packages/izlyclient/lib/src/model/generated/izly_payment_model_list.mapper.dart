// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../izly_payment_model_list.dart';

class IzlyPaymentModelListMapper extends ClassMapperBase<IzlyPaymentModelList> {
  IzlyPaymentModelListMapper._();

  static IzlyPaymentModelListMapper? _instance;
  static IzlyPaymentModelListMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IzlyPaymentModelListMapper._());
      IzlyPaymentModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'IzlyPaymentModelList';

  static List<IzlyPaymentModel> _$payments(IzlyPaymentModelList v) =>
      v.payments;
  static const Field<IzlyPaymentModelList, List<IzlyPaymentModel>> _f$payments =
      Field('payments', _$payments);

  @override
  final MappableFields<IzlyPaymentModelList> fields = const {
    #payments: _f$payments,
  };

  static IzlyPaymentModelList _instantiate(DecodingData data) {
    return IzlyPaymentModelList(payments: data.dec(_f$payments));
  }

  @override
  final Function instantiate = _instantiate;

  static IzlyPaymentModelList fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IzlyPaymentModelList>(map);
  }

  static IzlyPaymentModelList fromJson(String json) {
    return ensureInitialized().decodeJson<IzlyPaymentModelList>(json);
  }
}

mixin IzlyPaymentModelListMappable {
  String toJson() {
    return IzlyPaymentModelListMapper.ensureInitialized()
        .encodeJson<IzlyPaymentModelList>(this as IzlyPaymentModelList);
  }

  Map<String, dynamic> toMap() {
    return IzlyPaymentModelListMapper.ensureInitialized()
        .encodeMap<IzlyPaymentModelList>(this as IzlyPaymentModelList);
  }

  IzlyPaymentModelListCopyWith<
    IzlyPaymentModelList,
    IzlyPaymentModelList,
    IzlyPaymentModelList
  >
  get copyWith =>
      _IzlyPaymentModelListCopyWithImpl<
        IzlyPaymentModelList,
        IzlyPaymentModelList
      >(this as IzlyPaymentModelList, $identity, $identity);
  @override
  String toString() {
    return IzlyPaymentModelListMapper.ensureInitialized().stringifyValue(
      this as IzlyPaymentModelList,
    );
  }

  @override
  bool operator ==(Object other) {
    return IzlyPaymentModelListMapper.ensureInitialized().equalsValue(
      this as IzlyPaymentModelList,
      other,
    );
  }

  @override
  int get hashCode {
    return IzlyPaymentModelListMapper.ensureInitialized().hashValue(
      this as IzlyPaymentModelList,
    );
  }
}

extension IzlyPaymentModelListValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IzlyPaymentModelList, $Out> {
  IzlyPaymentModelListCopyWith<$R, IzlyPaymentModelList, $Out>
  get $asIzlyPaymentModelList => $base.as(
    (v, t, t2) => _IzlyPaymentModelListCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class IzlyPaymentModelListCopyWith<
  $R,
  $In extends IzlyPaymentModelList,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    IzlyPaymentModel,
    IzlyPaymentModelCopyWith<$R, IzlyPaymentModel, IzlyPaymentModel>
  >
  get payments;
  $R call({List<IzlyPaymentModel>? payments});
  IzlyPaymentModelListCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _IzlyPaymentModelListCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IzlyPaymentModelList, $Out>
    implements IzlyPaymentModelListCopyWith<$R, IzlyPaymentModelList, $Out> {
  _IzlyPaymentModelListCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IzlyPaymentModelList> $mapper =
      IzlyPaymentModelListMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    IzlyPaymentModel,
    IzlyPaymentModelCopyWith<$R, IzlyPaymentModel, IzlyPaymentModel>
  >
  get payments => ListCopyWith(
    $value.payments,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(payments: v),
  );
  @override
  $R call({List<IzlyPaymentModel>? payments}) =>
      $apply(FieldCopyWithData({if (payments != null) #payments: payments}));
  @override
  IzlyPaymentModelList $make(CopyWithData data) =>
      IzlyPaymentModelList(payments: data.get(#payments, or: $value.payments));

  @override
  IzlyPaymentModelListCopyWith<$R2, IzlyPaymentModelList, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _IzlyPaymentModelListCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

