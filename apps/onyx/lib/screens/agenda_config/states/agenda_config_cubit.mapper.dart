// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'agenda_config_cubit.dart';

class AgendaConfigStatusMapper extends EnumMapper<AgendaConfigStatus> {
  AgendaConfigStatusMapper._();

  static AgendaConfigStatusMapper? _instance;
  static AgendaConfigStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AgendaConfigStatusMapper._());
    }
    return _instance!;
  }

  static AgendaConfigStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AgendaConfigStatus decode(dynamic value) {
    switch (value) {
      case 000:
        return AgendaConfigStatus.initial;
      case 100:
        return AgendaConfigStatus.loading;
      case 200:
        return AgendaConfigStatus.loaded;
      case 300:
        return AgendaConfigStatus.choosed;
      case 400:
        return AgendaConfigStatus.searchResult;
      case 500:
        return AgendaConfigStatus.error;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AgendaConfigStatus self) {
    switch (self) {
      case AgendaConfigStatus.initial:
        return 000;
      case AgendaConfigStatus.loading:
        return 100;
      case AgendaConfigStatus.loaded:
        return 200;
      case AgendaConfigStatus.choosed:
        return 300;
      case AgendaConfigStatus.searchResult:
        return 400;
      case AgendaConfigStatus.error:
        return 500;
    }
  }
}

extension AgendaConfigStatusMapperExtension on AgendaConfigStatus {
  dynamic toValue() {
    AgendaConfigStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AgendaConfigStatus>(this);
  }
}

class AgendaConfigStateMapper extends ClassMapperBase<AgendaConfigState> {
  AgendaConfigStateMapper._();

  static AgendaConfigStateMapper? _instance;
  static AgendaConfigStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AgendaConfigStateMapper._());
      AgendaConfigStatusMapper.ensureInitialized();
      DirModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AgendaConfigState';

  static AgendaConfigStatus _$status(AgendaConfigState v) => v.status;
  static const Field<AgendaConfigState, AgendaConfigStatus> _f$status =
      Field('status', _$status);
  static List<DirModel> _$dirs(AgendaConfigState v) => v.dirs;
  static const Field<AgendaConfigState, List<DirModel>> _f$dirs =
      Field('dirs', _$dirs);
  static String _$error(AgendaConfigState v) => v.error;
  static const Field<AgendaConfigState, String> _f$error =
      Field('error', _$error);
  static int _$choosedId(AgendaConfigState v) => v.choosedId;
  static const Field<AgendaConfigState, int> _f$choosedId =
      Field('choosedId', _$choosedId);
  static List<DirModel> _$expandedDirs(AgendaConfigState v) => v.expandedDirs;
  static const Field<AgendaConfigState, List<DirModel>> _f$expandedDirs =
      Field('expandedDirs', _$expandedDirs, opt: true, def: const []);

  @override
  final Map<Symbol, Field<AgendaConfigState, dynamic>> fields = const {
    #status: _f$status,
    #dirs: _f$dirs,
    #error: _f$error,
    #choosedId: _f$choosedId,
    #expandedDirs: _f$expandedDirs,
  };

  static AgendaConfigState _instantiate(DecodingData data) {
    return AgendaConfigState(
        status: data.dec(_f$status),
        dirs: data.dec(_f$dirs),
        error: data.dec(_f$error),
        choosedId: data.dec(_f$choosedId),
        expandedDirs: data.dec(_f$expandedDirs));
  }

  @override
  final Function instantiate = _instantiate;

  static AgendaConfigState fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AgendaConfigState>(map);
  }

  static AgendaConfigState deserialize(String json) {
    return ensureInitialized().decodeJson<AgendaConfigState>(json);
  }
}

mixin AgendaConfigStateMappable {
  String serialize() {
    return AgendaConfigStateMapper.ensureInitialized()
        .encodeJson<AgendaConfigState>(this as AgendaConfigState);
  }

  Map<String, dynamic> toJson() {
    return AgendaConfigStateMapper.ensureInitialized()
        .encodeMap<AgendaConfigState>(this as AgendaConfigState);
  }

  AgendaConfigStateCopyWith<AgendaConfigState, AgendaConfigState,
          AgendaConfigState>
      get copyWith => _AgendaConfigStateCopyWithImpl(
          this as AgendaConfigState, $identity, $identity);
  @override
  String toString() {
    return AgendaConfigStateMapper.ensureInitialized()
        .stringifyValue(this as AgendaConfigState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            AgendaConfigStateMapper.ensureInitialized()
                .isValueEqual(this as AgendaConfigState, other));
  }

  @override
  int get hashCode {
    return AgendaConfigStateMapper.ensureInitialized()
        .hashValue(this as AgendaConfigState);
  }
}

extension AgendaConfigStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AgendaConfigState, $Out> {
  AgendaConfigStateCopyWith<$R, AgendaConfigState, $Out>
      get $asAgendaConfigState =>
          $base.as((v, t, t2) => _AgendaConfigStateCopyWithImpl(v, t, t2));
}

abstract class AgendaConfigStateCopyWith<$R, $In extends AgendaConfigState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, DirModel, DirModelCopyWith<$R, DirModel, DirModel>> get dirs;
  ListCopyWith<$R, DirModel, DirModelCopyWith<$R, DirModel, DirModel>>
      get expandedDirs;
  $R call(
      {AgendaConfigStatus? status,
      List<DirModel>? dirs,
      String? error,
      int? choosedId,
      List<DirModel>? expandedDirs});
  AgendaConfigStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AgendaConfigStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AgendaConfigState, $Out>
    implements AgendaConfigStateCopyWith<$R, AgendaConfigState, $Out> {
  _AgendaConfigStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AgendaConfigState> $mapper =
      AgendaConfigStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, DirModel, DirModelCopyWith<$R, DirModel, DirModel>>
      get dirs => ListCopyWith(
          $value.dirs, (v, t) => v.copyWith.$chain(t), (v) => call(dirs: v));
  @override
  ListCopyWith<$R, DirModel, DirModelCopyWith<$R, DirModel, DirModel>>
      get expandedDirs => ListCopyWith($value.expandedDirs,
          (v, t) => v.copyWith.$chain(t), (v) => call(expandedDirs: v));
  @override
  $R call(
          {AgendaConfigStatus? status,
          List<DirModel>? dirs,
          String? error,
          int? choosedId,
          List<DirModel>? expandedDirs}) =>
      $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (dirs != null) #dirs: dirs,
        if (error != null) #error: error,
        if (choosedId != null) #choosedId: choosedId,
        if (expandedDirs != null) #expandedDirs: expandedDirs
      }));
  @override
  AgendaConfigState $make(CopyWithData data) => AgendaConfigState(
      status: data.get(#status, or: $value.status),
      dirs: data.get(#dirs, or: $value.dirs),
      error: data.get(#error, or: $value.error),
      choosedId: data.get(#choosedId, or: $value.choosedId),
      expandedDirs: data.get(#expandedDirs, or: $value.expandedDirs));

  @override
  AgendaConfigStateCopyWith<$R2, AgendaConfigState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AgendaConfigStateCopyWithImpl($value, $cast, t);
}
