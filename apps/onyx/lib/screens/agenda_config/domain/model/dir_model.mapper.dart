// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dir_model.dart';

class DirModelMapper extends ClassMapperBase<DirModel> {
  DirModelMapper._();

  static DirModelMapper? _instance;
  static DirModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DirModelMapper._());
      DirModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DirModel';

  static String _$name(DirModel v) => v.name;
  static const Field<DirModel, String> _f$name = Field('name', _$name);
  static int _$identifier(DirModel v) => v.identifier;
  static const Field<DirModel, int> _f$identifier =
      Field('identifier', _$identifier);
  static List<DirModel>? _$children(DirModel v) => v.children;
  static const Field<DirModel, List<DirModel>> _f$children =
      Field('children', _$children, opt: true);

  @override
  final Map<Symbol, Field<DirModel, dynamic>> fields = const {
    #name: _f$name,
    #identifier: _f$identifier,
    #children: _f$children,
  };

  static DirModel _instantiate(DecodingData data) {
    return DirModel(
        name: data.dec(_f$name),
        identifier: data.dec(_f$identifier),
        children: data.dec(_f$children));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DirModelMappable {
  String serialize() {
    return DirModelMapper.ensureInitialized()
        .encodeJson<DirModel>(this as DirModel);
  }

  Map<String, dynamic> toJson() {
    return DirModelMapper.ensureInitialized()
        .encodeMap<DirModel>(this as DirModel);
  }

  DirModelCopyWith<DirModel, DirModel, DirModel> get copyWith =>
      _DirModelCopyWithImpl(this as DirModel, $identity, $identity);
  @override
  String toString() {
    return DirModelMapper.ensureInitialized().stringifyValue(this as DirModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DirModelMapper.ensureInitialized()
                .isValueEqual(this as DirModel, other));
  }

  @override
  int get hashCode {
    return DirModelMapper.ensureInitialized().hashValue(this as DirModel);
  }
}

extension DirModelValueCopy<$R, $Out> on ObjectCopyWith<$R, DirModel, $Out> {
  DirModelCopyWith<$R, DirModel, $Out> get $asDirModel =>
      $base.as((v, t, t2) => _DirModelCopyWithImpl(v, t, t2));
}

abstract class DirModelCopyWith<$R, $In extends DirModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, DirModel, DirModelCopyWith<$R, DirModel, DirModel>>?
      get children;
  $R call({String? name, int? identifier, List<DirModel>? children});
  DirModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DirModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DirModel, $Out>
    implements DirModelCopyWith<$R, DirModel, $Out> {
  _DirModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DirModel> $mapper =
      DirModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, DirModel, DirModelCopyWith<$R, DirModel, DirModel>>?
      get children => $value.children != null
          ? ListCopyWith($value.children!, (v, t) => v.copyWith.$chain(t),
              (v) => call(children: v))
          : null;
  @override
  $R call({String? name, int? identifier, Object? children = $none}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (identifier != null) #identifier: identifier,
        if (children != $none) #children: children
      }));
  @override
  DirModel $make(CopyWithData data) => DirModel(
      name: data.get(#name, or: $value.name),
      identifier: data.get(#identifier, or: $value.identifier),
      children: data.get(#children, or: $value.children));

  @override
  DirModelCopyWith<$R2, DirModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DirModelCopyWithImpl($value, $cast, t);
}
