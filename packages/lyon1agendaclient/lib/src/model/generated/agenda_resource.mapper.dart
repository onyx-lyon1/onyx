// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../agenda_resource.dart';

class AgendaResourceMapper extends ClassMapperBase<AgendaResource> {
  AgendaResourceMapper._();

  static AgendaResourceMapper? _instance;
  static AgendaResourceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AgendaResourceMapper._());
      AgendaResourceMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AgendaResource';

  static int? _$id(AgendaResource v) => v.id;
  static const Field<AgendaResource, int> _f$id = Field('id', _$id);
  static String _$name(AgendaResource v) => v.name;
  static const Field<AgendaResource, String> _f$name = Field('name', _$name);
  static List<AgendaResource>? _$children(AgendaResource v) => v.children;
  static const Field<AgendaResource, List<AgendaResource>> _f$children = Field(
    'children',
    _$children,
  );

  @override
  final MappableFields<AgendaResource> fields = const {
    #id: _f$id,
    #name: _f$name,
    #children: _f$children,
  };

  static AgendaResource _instantiate(DecodingData data) {
    return AgendaResource(
      data.dec(_f$id),
      data.dec(_f$name),
      data.dec(_f$children),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AgendaResource fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AgendaResource>(map);
  }

  static AgendaResource fromJson(String json) {
    return ensureInitialized().decodeJson<AgendaResource>(json);
  }
}

mixin AgendaResourceMappable {
  String toJson() {
    return AgendaResourceMapper.ensureInitialized().encodeJson<AgendaResource>(
      this as AgendaResource,
    );
  }

  Map<String, dynamic> toMap() {
    return AgendaResourceMapper.ensureInitialized().encodeMap<AgendaResource>(
      this as AgendaResource,
    );
  }

  AgendaResourceCopyWith<AgendaResource, AgendaResource, AgendaResource>
  get copyWith => _AgendaResourceCopyWithImpl<AgendaResource, AgendaResource>(
    this as AgendaResource,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return AgendaResourceMapper.ensureInitialized().stringifyValue(
      this as AgendaResource,
    );
  }

  @override
  bool operator ==(Object other) {
    return AgendaResourceMapper.ensureInitialized().equalsValue(
      this as AgendaResource,
      other,
    );
  }

  @override
  int get hashCode {
    return AgendaResourceMapper.ensureInitialized().hashValue(
      this as AgendaResource,
    );
  }
}

extension AgendaResourceValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AgendaResource, $Out> {
  AgendaResourceCopyWith<$R, AgendaResource, $Out> get $asAgendaResource =>
      $base.as((v, t, t2) => _AgendaResourceCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AgendaResourceCopyWith<$R, $In extends AgendaResource, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    AgendaResource,
    AgendaResourceCopyWith<$R, AgendaResource, AgendaResource>
  >?
  get children;
  $R call({int? id, String? name, List<AgendaResource>? children});
  AgendaResourceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AgendaResourceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AgendaResource, $Out>
    implements AgendaResourceCopyWith<$R, AgendaResource, $Out> {
  _AgendaResourceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AgendaResource> $mapper =
      AgendaResourceMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    AgendaResource,
    AgendaResourceCopyWith<$R, AgendaResource, AgendaResource>
  >?
  get children => $value.children != null
      ? ListCopyWith(
          $value.children!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(children: v),
        )
      : null;
  @override
  $R call({Object? id = $none, String? name, Object? children = $none}) =>
      $apply(
        FieldCopyWithData({
          if (id != $none) #id: id,
          if (name != null) #name: name,
          if (children != $none) #children: children,
        }),
      );
  @override
  AgendaResource $make(CopyWithData data) => AgendaResource(
    data.get(#id, or: $value.id),
    data.get(#name, or: $value.name),
    data.get(#children, or: $value.children),
  );

  @override
  AgendaResourceCopyWith<$R2, AgendaResource, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AgendaResourceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

