// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../cb_model.dart';

class CbModelMapper extends ClassMapperBase<CbModel> {
  CbModelMapper._();

  static CbModelMapper? _instance;
  static CbModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CbModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CbModel';

  static String _$name(CbModel v) => v.name;
  static const Field<CbModel, String> _f$name = Field('name', _$name);
  static String _$id(CbModel v) => v.id;
  static const Field<CbModel, String> _f$id = Field('id', _$id);

  @override
  final MappableFields<CbModel> fields = const {#name: _f$name, #id: _f$id};

  static CbModel _instantiate(DecodingData data) {
    return CbModel(data.dec(_f$name), data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static CbModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CbModel>(map);
  }

  static CbModel fromJson(String json) {
    return ensureInitialized().decodeJson<CbModel>(json);
  }
}

mixin CbModelMappable {
  String toJson() {
    return CbModelMapper.ensureInitialized().encodeJson<CbModel>(
      this as CbModel,
    );
  }

  Map<String, dynamic> toMap() {
    return CbModelMapper.ensureInitialized().encodeMap<CbModel>(
      this as CbModel,
    );
  }

  CbModelCopyWith<CbModel, CbModel, CbModel> get copyWith =>
      _CbModelCopyWithImpl<CbModel, CbModel>(
        this as CbModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CbModelMapper.ensureInitialized().stringifyValue(this as CbModel);
  }

  @override
  bool operator ==(Object other) {
    return CbModelMapper.ensureInitialized().equalsValue(
      this as CbModel,
      other,
    );
  }

  @override
  int get hashCode {
    return CbModelMapper.ensureInitialized().hashValue(this as CbModel);
  }
}

extension CbModelValueCopy<$R, $Out> on ObjectCopyWith<$R, CbModel, $Out> {
  CbModelCopyWith<$R, CbModel, $Out> get $asCbModel =>
      $base.as((v, t, t2) => _CbModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CbModelCopyWith<$R, $In extends CbModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? id});
  CbModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CbModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CbModel, $Out>
    implements CbModelCopyWith<$R, CbModel, $Out> {
  _CbModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CbModel> $mapper =
      CbModelMapper.ensureInitialized();
  @override
  $R call({String? name, String? id}) => $apply(
    FieldCopyWithData({if (name != null) #name: name, if (id != null) #id: id}),
  );
  @override
  CbModel $make(CopyWithData data) =>
      CbModel(data.get(#name, or: $value.name), data.get(#id, or: $value.id));

  @override
  CbModelCopyWith<$R2, CbModel, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CbModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

