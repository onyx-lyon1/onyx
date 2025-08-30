// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../restaurant_list_model.dart';

class RestaurantListModelMapper extends ClassMapperBase<RestaurantListModel> {
  RestaurantListModelMapper._();

  static RestaurantListModelMapper? _instance;
  static RestaurantListModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RestaurantListModelMapper._());
      RestaurantModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RestaurantListModel';

  static List<RestaurantModel> _$restaurantList(RestaurantListModel v) =>
      v.restaurantList;
  static const Field<RestaurantListModel, List<RestaurantModel>>
  _f$restaurantList = Field('restaurantList', _$restaurantList);

  @override
  final MappableFields<RestaurantListModel> fields = const {
    #restaurantList: _f$restaurantList,
  };

  static RestaurantListModel _instantiate(DecodingData data) {
    return RestaurantListModel(restaurantList: data.dec(_f$restaurantList));
  }

  @override
  final Function instantiate = _instantiate;

  static RestaurantListModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RestaurantListModel>(map);
  }

  static RestaurantListModel fromJson(String json) {
    return ensureInitialized().decodeJson<RestaurantListModel>(json);
  }
}

mixin RestaurantListModelMappable {
  String toJson() {
    return RestaurantListModelMapper.ensureInitialized()
        .encodeJson<RestaurantListModel>(this as RestaurantListModel);
  }

  Map<String, dynamic> toMap() {
    return RestaurantListModelMapper.ensureInitialized()
        .encodeMap<RestaurantListModel>(this as RestaurantListModel);
  }

  RestaurantListModelCopyWith<
    RestaurantListModel,
    RestaurantListModel,
    RestaurantListModel
  >
  get copyWith =>
      _RestaurantListModelCopyWithImpl<
        RestaurantListModel,
        RestaurantListModel
      >(this as RestaurantListModel, $identity, $identity);
  @override
  String toString() {
    return RestaurantListModelMapper.ensureInitialized().stringifyValue(
      this as RestaurantListModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return RestaurantListModelMapper.ensureInitialized().equalsValue(
      this as RestaurantListModel,
      other,
    );
  }

  @override
  int get hashCode {
    return RestaurantListModelMapper.ensureInitialized().hashValue(
      this as RestaurantListModel,
    );
  }
}

extension RestaurantListModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RestaurantListModel, $Out> {
  RestaurantListModelCopyWith<$R, RestaurantListModel, $Out>
  get $asRestaurantListModel => $base.as(
    (v, t, t2) => _RestaurantListModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RestaurantListModelCopyWith<
  $R,
  $In extends RestaurantListModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    RestaurantModel,
    RestaurantModelCopyWith<$R, RestaurantModel, RestaurantModel>
  >
  get restaurantList;
  $R call({List<RestaurantModel>? restaurantList});
  RestaurantListModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RestaurantListModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RestaurantListModel, $Out>
    implements RestaurantListModelCopyWith<$R, RestaurantListModel, $Out> {
  _RestaurantListModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RestaurantListModel> $mapper =
      RestaurantListModelMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    RestaurantModel,
    RestaurantModelCopyWith<$R, RestaurantModel, RestaurantModel>
  >
  get restaurantList => ListCopyWith(
    $value.restaurantList,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(restaurantList: v),
  );
  @override
  $R call({List<RestaurantModel>? restaurantList}) => $apply(
    FieldCopyWithData({
      if (restaurantList != null) #restaurantList: restaurantList,
    }),
  );
  @override
  RestaurantListModel $make(CopyWithData data) => RestaurantListModel(
    restaurantList: data.get(#restaurantList, or: $value.restaurantList),
  );

  @override
  RestaurantListModelCopyWith<$R2, RestaurantListModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RestaurantListModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

