// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'map_cubit.dart';

class MapStatusMapper extends EnumMapper<MapStatus> {
  MapStatusMapper._();

  static MapStatusMapper? _instance;
  static MapStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MapStatusMapper._());
    }
    return _instance!;
  }

  static MapStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  MapStatus decode(dynamic value) {
    switch (value) {
      case 000:
        return MapStatus.initial;
      case 100:
        return MapStatus.batimentsUpdated;
      case 200:
        return MapStatus.loading;
      case 300:
        return MapStatus.error;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(MapStatus self) {
    switch (self) {
      case MapStatus.initial:
        return 000;
      case MapStatus.batimentsUpdated:
        return 100;
      case MapStatus.loading:
        return 200;
      case MapStatus.error:
        return 300;
    }
  }
}

extension MapStatusMapperExtension on MapStatus {
  dynamic toValue() {
    MapStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<MapStatus>(this);
  }
}

class MapStateMapper extends ClassMapperBase<MapState> {
  MapStateMapper._();

  static MapStateMapper? _instance;
  static MapStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MapStateMapper._());
      MapStatusMapper.ensureInitialized();
      BatimentModelMapper.ensureInitialized();
      RestaurantModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MapState';

  static MapStatus _$status(MapState v) => v.status;
  static const Field<MapState, MapStatus> _f$status =
      Field('status', _$status, opt: true, def: MapStatus.initial);
  static List<BatimentModel> _$batiments(MapState v) => v.batiments;
  static const Field<MapState, List<BatimentModel>> _f$batiments =
      Field('batiments', _$batiments, opt: true, def: const []);
  static List<LatLng> _$path(MapState v) => v.path;
  static const Field<MapState, List<LatLng>> _f$path =
      Field('path', _$path, opt: true, def: const []);
  static List<RestaurantModel> _$restaurant(MapState v) => v.restaurant;
  static const Field<MapState, List<RestaurantModel>> _f$restaurant =
      Field('restaurant', _$restaurant, opt: true, def: const []);
  static bool _$geolocationAutorisation(MapState v) =>
      v.geolocationAutorisation;
  static const Field<MapState, bool> _f$geolocationAutorisation = Field(
      'geolocationAutorisation', _$geolocationAutorisation,
      opt: true, def: false);

  @override
  final Map<Symbol, Field<MapState, dynamic>> fields = const {
    #status: _f$status,
    #batiments: _f$batiments,
    #path: _f$path,
    #restaurant: _f$restaurant,
    #geolocationAutorisation: _f$geolocationAutorisation,
  };

  static MapState _instantiate(DecodingData data) {
    return MapState(
        status: data.dec(_f$status),
        batiments: data.dec(_f$batiments),
        path: data.dec(_f$path),
        restaurant: data.dec(_f$restaurant),
        geolocationAutorisation: data.dec(_f$geolocationAutorisation));
  }

  @override
  final Function instantiate = _instantiate;

  static MapState fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MapState>(map);
  }

  static MapState deserialize(String json) {
    return ensureInitialized().decodeJson<MapState>(json);
  }
}

mixin MapStateMappable {
  String serialize() {
    return MapStateMapper.ensureInitialized()
        .encodeJson<MapState>(this as MapState);
  }

  Map<String, dynamic> toJson() {
    return MapStateMapper.ensureInitialized()
        .encodeMap<MapState>(this as MapState);
  }

  MapStateCopyWith<MapState, MapState, MapState> get copyWith =>
      _MapStateCopyWithImpl(this as MapState, $identity, $identity);
  @override
  String toString() {
    return MapStateMapper.ensureInitialized().stringifyValue(this as MapState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MapStateMapper.ensureInitialized()
                .isValueEqual(this as MapState, other));
  }

  @override
  int get hashCode {
    return MapStateMapper.ensureInitialized().hashValue(this as MapState);
  }
}

extension MapStateValueCopy<$R, $Out> on ObjectCopyWith<$R, MapState, $Out> {
  MapStateCopyWith<$R, MapState, $Out> get $asMapState =>
      $base.as((v, t, t2) => _MapStateCopyWithImpl(v, t, t2));
}

abstract class MapStateCopyWith<$R, $In extends MapState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, BatimentModel,
      BatimentModelCopyWith<$R, BatimentModel, BatimentModel>> get batiments;
  ListCopyWith<$R, LatLng, ObjectCopyWith<$R, LatLng, LatLng>> get path;
  ListCopyWith<$R, RestaurantModel,
          RestaurantModelCopyWith<$R, RestaurantModel, RestaurantModel>>
      get restaurant;
  $R call(
      {MapStatus? status,
      List<BatimentModel>? batiments,
      List<LatLng>? path,
      List<RestaurantModel>? restaurant,
      bool? geolocationAutorisation});
  MapStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MapStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MapState, $Out>
    implements MapStateCopyWith<$R, MapState, $Out> {
  _MapStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MapState> $mapper =
      MapStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, BatimentModel,
          BatimentModelCopyWith<$R, BatimentModel, BatimentModel>>
      get batiments => ListCopyWith($value.batiments,
          (v, t) => v.copyWith.$chain(t), (v) => call(batiments: v));
  @override
  ListCopyWith<$R, LatLng, ObjectCopyWith<$R, LatLng, LatLng>> get path =>
      ListCopyWith($value.path, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(path: v));
  @override
  ListCopyWith<$R, RestaurantModel,
          RestaurantModelCopyWith<$R, RestaurantModel, RestaurantModel>>
      get restaurant => ListCopyWith($value.restaurant,
          (v, t) => v.copyWith.$chain(t), (v) => call(restaurant: v));
  @override
  $R call(
          {MapStatus? status,
          List<BatimentModel>? batiments,
          List<LatLng>? path,
          List<RestaurantModel>? restaurant,
          bool? geolocationAutorisation}) =>
      $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (batiments != null) #batiments: batiments,
        if (path != null) #path: path,
        if (restaurant != null) #restaurant: restaurant,
        if (geolocationAutorisation != null)
          #geolocationAutorisation: geolocationAutorisation
      }));
  @override
  MapState $make(CopyWithData data) => MapState(
      status: data.get(#status, or: $value.status),
      batiments: data.get(#batiments, or: $value.batiments),
      path: data.get(#path, or: $value.path),
      restaurant: data.get(#restaurant, or: $value.restaurant),
      geolocationAutorisation: data.get(#geolocationAutorisation,
          or: $value.geolocationAutorisation));

  @override
  MapStateCopyWith<$R2, MapState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MapStateCopyWithImpl($value, $cast, t);
}
