// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'authentification_cubit.dart';

class AuthentificationStatusMapper extends EnumMapper<AuthentificationStatus> {
  AuthentificationStatusMapper._();

  static AuthentificationStatusMapper? _instance;
  static AuthentificationStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthentificationStatusMapper._());
    }
    return _instance!;
  }

  static AuthentificationStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AuthentificationStatus decode(dynamic value) {
    switch (value) {
      case 000:
        return AuthentificationStatus.initial;
      case 100:
        return AuthentificationStatus.needCredential;
      case 200:
        return AuthentificationStatus.authentificating;
      case 300:
        return AuthentificationStatus.authentificated;
      case 400:
        return AuthentificationStatus.error;
      case 500:
        return AuthentificationStatus.waitingBiometric;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AuthentificationStatus self) {
    switch (self) {
      case AuthentificationStatus.initial:
        return 000;
      case AuthentificationStatus.needCredential:
        return 100;
      case AuthentificationStatus.authentificating:
        return 200;
      case AuthentificationStatus.authentificated:
        return 300;
      case AuthentificationStatus.error:
        return 400;
      case AuthentificationStatus.waitingBiometric:
        return 500;
    }
  }
}

extension AuthentificationStatusMapperExtension on AuthentificationStatus {
  dynamic toValue() {
    AuthentificationStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AuthentificationStatus>(this);
  }
}

class AuthentificationStateMapper
    extends ClassMapperBase<AuthentificationState> {
  AuthentificationStateMapper._();

  static AuthentificationStateMapper? _instance;
  static AuthentificationStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthentificationStateMapper._());
      AuthentificationStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthentificationState';

  static AuthentificationStatus _$status(AuthentificationState v) => v.status;
  static const Field<AuthentificationState, AuthentificationStatus> _f$status =
      Field('status', _$status);
  static Lyon1CasClient _$lyon1Cas(AuthentificationState v) => v.lyon1Cas;
  static const Field<AuthentificationState, Lyon1CasClient> _f$lyon1Cas =
      Field('lyon1Cas', _$lyon1Cas);

  @override
  final Map<Symbol, Field<AuthentificationState, dynamic>> fields = const {
    #status: _f$status,
    #lyon1Cas: _f$lyon1Cas,
  };

  static AuthentificationState _instantiate(DecodingData data) {
    return AuthentificationState(
        status: data.dec(_f$status), lyon1Cas: data.dec(_f$lyon1Cas));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthentificationState fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthentificationState>(map);
  }

  static AuthentificationState deserialize(String json) {
    return ensureInitialized().decodeJson<AuthentificationState>(json);
  }
}

mixin AuthentificationStateMappable {
  String serialize() {
    return AuthentificationStateMapper.ensureInitialized()
        .encodeJson<AuthentificationState>(this as AuthentificationState);
  }

  Map<String, dynamic> toJson() {
    return AuthentificationStateMapper.ensureInitialized()
        .encodeMap<AuthentificationState>(this as AuthentificationState);
  }

  AuthentificationStateCopyWith<AuthentificationState, AuthentificationState,
          AuthentificationState>
      get copyWith => _AuthentificationStateCopyWithImpl(
          this as AuthentificationState, $identity, $identity);
  @override
  String toString() {
    return AuthentificationStateMapper.ensureInitialized()
        .stringifyValue(this as AuthentificationState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            AuthentificationStateMapper.ensureInitialized()
                .isValueEqual(this as AuthentificationState, other));
  }

  @override
  int get hashCode {
    return AuthentificationStateMapper.ensureInitialized()
        .hashValue(this as AuthentificationState);
  }
}

extension AuthentificationStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthentificationState, $Out> {
  AuthentificationStateCopyWith<$R, AuthentificationState, $Out>
      get $asAuthentificationState =>
          $base.as((v, t, t2) => _AuthentificationStateCopyWithImpl(v, t, t2));
}

abstract class AuthentificationStateCopyWith<
    $R,
    $In extends AuthentificationState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({AuthentificationStatus? status, Lyon1CasClient? lyon1Cas});
  AuthentificationStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthentificationStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthentificationState, $Out>
    implements AuthentificationStateCopyWith<$R, AuthentificationState, $Out> {
  _AuthentificationStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthentificationState> $mapper =
      AuthentificationStateMapper.ensureInitialized();
  @override
  $R call({AuthentificationStatus? status, Lyon1CasClient? lyon1Cas}) =>
      $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (lyon1Cas != null) #lyon1Cas: lyon1Cas
      }));
  @override
  AuthentificationState $make(CopyWithData data) => AuthentificationState(
      status: data.get(#status, or: $value.status),
      lyon1Cas: data.get(#lyon1Cas, or: $value.lyon1Cas));

  @override
  AuthentificationStateCopyWith<$R2, AuthentificationState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _AuthentificationStateCopyWithImpl($value, $cast, t);
}
