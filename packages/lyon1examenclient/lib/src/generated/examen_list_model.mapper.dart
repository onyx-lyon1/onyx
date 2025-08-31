// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../examen_list_model.dart';

class ExamenListModelMapper extends ClassMapperBase<ExamenListModel> {
  ExamenListModelMapper._();

  static ExamenListModelMapper? _instance;
  static ExamenListModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExamenListModelMapper._());
      ExamenModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ExamenListModel';

  static List<ExamenModel> _$examens(ExamenListModel v) => v.examens;
  static const Field<ExamenListModel, List<ExamenModel>> _f$examens = Field(
    'examens',
    _$examens,
  );

  @override
  final MappableFields<ExamenListModel> fields = const {#examens: _f$examens};

  static ExamenListModel _instantiate(DecodingData data) {
    return ExamenListModel(data.dec(_f$examens));
  }

  @override
  final Function instantiate = _instantiate;

  static ExamenListModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ExamenListModel>(map);
  }

  static ExamenListModel fromJson(String json) {
    return ensureInitialized().decodeJson<ExamenListModel>(json);
  }
}

mixin ExamenListModelMappable {
  String toJson() {
    return ExamenListModelMapper.ensureInitialized()
        .encodeJson<ExamenListModel>(this as ExamenListModel);
  }

  Map<String, dynamic> toMap() {
    return ExamenListModelMapper.ensureInitialized().encodeMap<ExamenListModel>(
      this as ExamenListModel,
    );
  }

  ExamenListModelCopyWith<ExamenListModel, ExamenListModel, ExamenListModel>
  get copyWith =>
      _ExamenListModelCopyWithImpl<ExamenListModel, ExamenListModel>(
        this as ExamenListModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ExamenListModelMapper.ensureInitialized().stringifyValue(
      this as ExamenListModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ExamenListModelMapper.ensureInitialized().equalsValue(
      this as ExamenListModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ExamenListModelMapper.ensureInitialized().hashValue(
      this as ExamenListModel,
    );
  }
}

extension ExamenListModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ExamenListModel, $Out> {
  ExamenListModelCopyWith<$R, ExamenListModel, $Out> get $asExamenListModel =>
      $base.as((v, t, t2) => _ExamenListModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ExamenListModelCopyWith<$R, $In extends ExamenListModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ExamenModel,
    ExamenModelCopyWith<$R, ExamenModel, ExamenModel>
  >
  get examens;
  $R call({List<ExamenModel>? examens});
  ExamenListModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ExamenListModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ExamenListModel, $Out>
    implements ExamenListModelCopyWith<$R, ExamenListModel, $Out> {
  _ExamenListModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ExamenListModel> $mapper =
      ExamenListModelMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    ExamenModel,
    ExamenModelCopyWith<$R, ExamenModel, ExamenModel>
  >
  get examens => ListCopyWith(
    $value.examens,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(examens: v),
  );
  @override
  $R call({List<ExamenModel>? examens}) =>
      $apply(FieldCopyWithData({if (examens != null) #examens: examens}));
  @override
  ExamenListModel $make(CopyWithData data) =>
      ExamenListModel(data.get(#examens, or: $value.examens));

  @override
  ExamenListModelCopyWith<$R2, ExamenListModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ExamenListModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

