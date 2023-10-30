// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'batiment_model.dart';

class BatimentModelMapper extends ClassMapperBase<BatimentModel> {
  BatimentModelMapper._();

  static BatimentModelMapper? _instance;
  static BatimentModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BatimentModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BatimentModel';

  static String _$name(BatimentModel v) => v.name;
  static const Field<BatimentModel, String> _f$name = Field('name', _$name);
  static LatLng _$position(BatimentModel v) => v.position;
  static const Field<BatimentModel, LatLng> _f$position =
      Field('position', _$position);

  @override
  final Map<Symbol, Field<BatimentModel, dynamic>> fields = const {
    #name: _f$name,
    #position: _f$position,
  };

  static BatimentModel _instantiate(DecodingData data) {
    return BatimentModel(data.dec(_f$name), data.dec(_f$position));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin BatimentModelMappable {
  String serialize() {
    return BatimentModelMapper.ensureInitialized()
        .encodeJson<BatimentModel>(this as BatimentModel);
  }

  Map<String, dynamic> toJson() {
    return BatimentModelMapper.ensureInitialized()
        .encodeMap<BatimentModel>(this as BatimentModel);
  }

  BatimentModelCopyWith<BatimentModel, BatimentModel, BatimentModel>
      get copyWith => _BatimentModelCopyWithImpl(
          this as BatimentModel, $identity, $identity);
  @override
  String toString() {
    return BatimentModelMapper.ensureInitialized()
        .stringifyValue(this as BatimentModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BatimentModelMapper.ensureInitialized()
                .isValueEqual(this as BatimentModel, other));
  }

  @override
  int get hashCode {
    return BatimentModelMapper.ensureInitialized()
        .hashValue(this as BatimentModel);
  }
}

extension BatimentModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BatimentModel, $Out> {
  BatimentModelCopyWith<$R, BatimentModel, $Out> get $asBatimentModel =>
      $base.as((v, t, t2) => _BatimentModelCopyWithImpl(v, t, t2));
}

abstract class BatimentModelCopyWith<$R, $In extends BatimentModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, LatLng? position});
  BatimentModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BatimentModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BatimentModel, $Out>
    implements BatimentModelCopyWith<$R, BatimentModel, $Out> {
  _BatimentModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BatimentModel> $mapper =
      BatimentModelMapper.ensureInitialized();
  @override
  $R call({String? name, LatLng? position}) => $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (position != null) #position: position
      }));
  @override
  BatimentModel $make(CopyWithData data) => BatimentModel(
      data.get(#name, or: $value.name),
      data.get(#position, or: $value.position));

  @override
  BatimentModelCopyWith<$R2, BatimentModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BatimentModelCopyWithImpl($value, $cast, t);
}
