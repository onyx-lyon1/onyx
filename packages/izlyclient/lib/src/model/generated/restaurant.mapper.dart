// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../restaurant.dart';

class RestaurantModelMapper extends ClassMapperBase<RestaurantModel> {
  RestaurantModelMapper._();

  static RestaurantModelMapper? _instance;
  static RestaurantModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RestaurantModelMapper._());
      MenuCrousMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RestaurantModel';

  static int _$id(RestaurantModel v) => v.id;
  static const Field<RestaurantModel, int> _f$id = Field('id', _$id);
  static String _$name(RestaurantModel v) => v.name;
  static const Field<RestaurantModel, String> _f$name = Field('name', _$name);
  static String _$description(RestaurantModel v) => v.description;
  static const Field<RestaurantModel, String> _f$description = Field(
    'description',
    _$description,
  );
  static String _$shortDescription(RestaurantModel v) => v.shortDescription;
  static const Field<RestaurantModel, String> _f$shortDescription = Field(
    'shortDescription',
    _$shortDescription,
  );
  static CrousType _$type(RestaurantModel v) => v.type;
  static const Field<RestaurantModel, CrousType> _f$type = Field(
    'type',
    _$type,
  );
  static double _$lat(RestaurantModel v) => v.lat;
  static const Field<RestaurantModel, double> _f$lat = Field('lat', _$lat);
  static double _$lon(RestaurantModel v) => v.lon;
  static const Field<RestaurantModel, double> _f$lon = Field('lon', _$lon);
  static String _$opening(RestaurantModel v) => v.opening;
  static const Field<RestaurantModel, String> _f$opening = Field(
    'opening',
    _$opening,
  );
  static List<MenuCrous> _$menus(RestaurantModel v) => v.menus;
  static const Field<RestaurantModel, List<MenuCrous>> _f$menus = Field(
    'menus',
    _$menus,
  );
  static String _$imageUrl(RestaurantModel v) => v.imageUrl;
  static const Field<RestaurantModel, String> _f$imageUrl = Field(
    'imageUrl',
    _$imageUrl,
  );

  @override
  final MappableFields<RestaurantModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #shortDescription: _f$shortDescription,
    #type: _f$type,
    #lat: _f$lat,
    #lon: _f$lon,
    #opening: _f$opening,
    #menus: _f$menus,
    #imageUrl: _f$imageUrl,
  };

  static RestaurantModel _instantiate(DecodingData data) {
    return RestaurantModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      description: data.dec(_f$description),
      shortDescription: data.dec(_f$shortDescription),
      type: data.dec(_f$type),
      lat: data.dec(_f$lat),
      lon: data.dec(_f$lon),
      opening: data.dec(_f$opening),
      menus: data.dec(_f$menus),
      imageUrl: data.dec(_f$imageUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RestaurantModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RestaurantModel>(map);
  }

  static RestaurantModel fromJson(String json) {
    return ensureInitialized().decodeJson<RestaurantModel>(json);
  }
}

mixin RestaurantModelMappable {
  String toJson() {
    return RestaurantModelMapper.ensureInitialized()
        .encodeJson<RestaurantModel>(this as RestaurantModel);
  }

  Map<String, dynamic> toMap() {
    return RestaurantModelMapper.ensureInitialized().encodeMap<RestaurantModel>(
      this as RestaurantModel,
    );
  }

  RestaurantModelCopyWith<RestaurantModel, RestaurantModel, RestaurantModel>
  get copyWith =>
      _RestaurantModelCopyWithImpl<RestaurantModel, RestaurantModel>(
        this as RestaurantModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return RestaurantModelMapper.ensureInitialized().stringifyValue(
      this as RestaurantModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return RestaurantModelMapper.ensureInitialized().equalsValue(
      this as RestaurantModel,
      other,
    );
  }

  @override
  int get hashCode {
    return RestaurantModelMapper.ensureInitialized().hashValue(
      this as RestaurantModel,
    );
  }
}

extension RestaurantModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RestaurantModel, $Out> {
  RestaurantModelCopyWith<$R, RestaurantModel, $Out> get $asRestaurantModel =>
      $base.as((v, t, t2) => _RestaurantModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RestaurantModelCopyWith<$R, $In extends RestaurantModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, MenuCrous, MenuCrousCopyWith<$R, MenuCrous, MenuCrous>>
  get menus;
  $R call({
    int? id,
    String? name,
    String? description,
    String? shortDescription,
    CrousType? type,
    double? lat,
    double? lon,
    String? opening,
    List<MenuCrous>? menus,
    String? imageUrl,
  });
  RestaurantModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RestaurantModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RestaurantModel, $Out>
    implements RestaurantModelCopyWith<$R, RestaurantModel, $Out> {
  _RestaurantModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RestaurantModel> $mapper =
      RestaurantModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, MenuCrous, MenuCrousCopyWith<$R, MenuCrous, MenuCrous>>
  get menus => ListCopyWith(
    $value.menus,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(menus: v),
  );
  @override
  $R call({
    int? id,
    String? name,
    String? description,
    String? shortDescription,
    CrousType? type,
    double? lat,
    double? lon,
    String? opening,
    List<MenuCrous>? menus,
    String? imageUrl,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (description != null) #description: description,
      if (shortDescription != null) #shortDescription: shortDescription,
      if (type != null) #type: type,
      if (lat != null) #lat: lat,
      if (lon != null) #lon: lon,
      if (opening != null) #opening: opening,
      if (menus != null) #menus: menus,
      if (imageUrl != null) #imageUrl: imageUrl,
    }),
  );
  @override
  RestaurantModel $make(CopyWithData data) => RestaurantModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
    shortDescription: data.get(#shortDescription, or: $value.shortDescription),
    type: data.get(#type, or: $value.type),
    lat: data.get(#lat, or: $value.lat),
    lon: data.get(#lon, or: $value.lon),
    opening: data.get(#opening, or: $value.opening),
    menus: data.get(#menus, or: $value.menus),
    imageUrl: data.get(#imageUrl, or: $value.imageUrl),
  );

  @override
  RestaurantModelCopyWith<$R2, RestaurantModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _RestaurantModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

