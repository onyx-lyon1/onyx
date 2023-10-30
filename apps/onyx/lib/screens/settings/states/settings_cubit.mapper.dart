// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings_cubit.dart';

class SettingsStatusMapper extends EnumMapper<SettingsStatus> {
  SettingsStatusMapper._();

  static SettingsStatusMapper? _instance;
  static SettingsStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsStatusMapper._());
    }
    return _instance!;
  }

  static SettingsStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SettingsStatus decode(dynamic value) {
    switch (value) {
      case 000:
        return SettingsStatus.initial;
      case 100:
        return SettingsStatus.loading;
      case 200:
        return SettingsStatus.ready;
      case 300:
        return SettingsStatus.error;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SettingsStatus self) {
    switch (self) {
      case SettingsStatus.initial:
        return 000;
      case SettingsStatus.loading:
        return 100;
      case SettingsStatus.ready:
        return 200;
      case SettingsStatus.error:
        return 300;
    }
  }
}

extension SettingsStatusMapperExtension on SettingsStatus {
  dynamic toValue() {
    SettingsStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SettingsStatus>(this);
  }
}

class SettingsStateMapper extends ClassMapperBase<SettingsState> {
  SettingsStateMapper._();

  static SettingsStateMapper? _instance;
  static SettingsStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsStateMapper._());
      SettingsStatusMapper.ensureInitialized();
      SettingsModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsState';

  static SettingsStatus _$status(SettingsState v) => v.status;
  static const Field<SettingsState, SettingsStatus> _f$status =
      Field('status', _$status, opt: true, def: SettingsStatus.initial);
  static bool _$collapseAll(SettingsState v) => v.collapseAll;
  static const Field<SettingsState, bool> _f$collapseAll =
      Field('collapseAll', _$collapseAll, opt: true, def: false);
  static SettingsModel _$settings(SettingsState v) => v.settings;
  static const Field<SettingsState, SettingsModel> _f$settings =
      Field('settings', _$settings);

  @override
  final Map<Symbol, Field<SettingsState, dynamic>> fields = const {
    #status: _f$status,
    #collapseAll: _f$collapseAll,
    #settings: _f$settings,
  };

  static SettingsState _instantiate(DecodingData data) {
    return SettingsState(
        status: data.dec(_f$status),
        collapseAll: data.dec(_f$collapseAll),
        settings: data.dec(_f$settings));
  }

  @override
  final Function instantiate = _instantiate;

  static SettingsState fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SettingsState>(map);
  }

  static SettingsState deserialize(String json) {
    return ensureInitialized().decodeJson<SettingsState>(json);
  }
}

mixin SettingsStateMappable {
  String serialize() {
    return SettingsStateMapper.ensureInitialized()
        .encodeJson<SettingsState>(this as SettingsState);
  }

  Map<String, dynamic> toJson() {
    return SettingsStateMapper.ensureInitialized()
        .encodeMap<SettingsState>(this as SettingsState);
  }

  SettingsStateCopyWith<SettingsState, SettingsState, SettingsState>
      get copyWith => _SettingsStateCopyWithImpl(
          this as SettingsState, $identity, $identity);
  @override
  String toString() {
    return SettingsStateMapper.ensureInitialized()
        .stringifyValue(this as SettingsState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SettingsStateMapper.ensureInitialized()
                .isValueEqual(this as SettingsState, other));
  }

  @override
  int get hashCode {
    return SettingsStateMapper.ensureInitialized()
        .hashValue(this as SettingsState);
  }
}

extension SettingsStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SettingsState, $Out> {
  SettingsStateCopyWith<$R, SettingsState, $Out> get $asSettingsState =>
      $base.as((v, t, t2) => _SettingsStateCopyWithImpl(v, t, t2));
}

abstract class SettingsStateCopyWith<$R, $In extends SettingsState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  SettingsModelCopyWith<$R, SettingsModel, SettingsModel> get settings;
  $R call({SettingsStatus? status, bool? collapseAll, SettingsModel? settings});
  SettingsStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SettingsStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SettingsState, $Out>
    implements SettingsStateCopyWith<$R, SettingsState, $Out> {
  _SettingsStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SettingsState> $mapper =
      SettingsStateMapper.ensureInitialized();
  @override
  SettingsModelCopyWith<$R, SettingsModel, SettingsModel> get settings =>
      $value.settings.copyWith.$chain((v) => call(settings: v));
  @override
  $R call(
          {SettingsStatus? status,
          bool? collapseAll,
          SettingsModel? settings}) =>
      $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (collapseAll != null) #collapseAll: collapseAll,
        if (settings != null) #settings: settings
      }));
  @override
  SettingsState $make(CopyWithData data) => SettingsState(
      status: data.get(#status, or: $value.status),
      collapseAll: data.get(#collapseAll, or: $value.collapseAll),
      settings: data.get(#settings, or: $value.settings));

  @override
  SettingsStateCopyWith<$R2, SettingsState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SettingsStateCopyWithImpl($value, $cast, t);
}
