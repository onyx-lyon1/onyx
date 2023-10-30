// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'agenda_cubit.dart';

class AgendaStatusMapper extends EnumMapper<AgendaStatus> {
  AgendaStatusMapper._();

  static AgendaStatusMapper? _instance;
  static AgendaStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AgendaStatusMapper._());
    }
    return _instance!;
  }

  static AgendaStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AgendaStatus decode(dynamic value) {
    switch (value) {
      case 000:
        return AgendaStatus.initial;
      case 100:
        return AgendaStatus.loading;
      case 200:
        return AgendaStatus.ready;
      case 300:
        return AgendaStatus.cacheReady;
      case 400:
        return AgendaStatus.dateUpdated;
      case 500:
        return AgendaStatus.error;
      case 600:
        return AgendaStatus.haveToChooseManualy;
      case 700:
        return AgendaStatus.updateDayCount;
      case 800:
        return AgendaStatus.updateAnimating;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AgendaStatus self) {
    switch (self) {
      case AgendaStatus.initial:
        return 000;
      case AgendaStatus.loading:
        return 100;
      case AgendaStatus.ready:
        return 200;
      case AgendaStatus.cacheReady:
        return 300;
      case AgendaStatus.dateUpdated:
        return 400;
      case AgendaStatus.error:
        return 500;
      case AgendaStatus.haveToChooseManualy:
        return 600;
      case AgendaStatus.updateDayCount:
        return 700;
      case AgendaStatus.updateAnimating:
        return 800;
    }
  }
}

extension AgendaStatusMapperExtension on AgendaStatus {
  dynamic toValue() {
    AgendaStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AgendaStatus>(this);
  }
}

class AgendaStateMapper extends ClassMapperBase<AgendaState> {
  AgendaStateMapper._();

  static AgendaStateMapper? _instance;
  static AgendaStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AgendaStateMapper._());
      AgendaStatusMapper.ensureInitialized();
      DayMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AgendaState';

  static AgendaStatus _$status(AgendaState v) => v.status;
  static const Field<AgendaState, AgendaStatus> _f$status =
      Field('status', _$status, opt: true, def: AgendaStatus.initial);
  static List<Day> _$realDays(AgendaState v) => v.realDays;
  static const Field<AgendaState, List<Day>> _f$realDays =
      Field('realDays', _$realDays, opt: true, def: const []);
  static int _$wantedDate(AgendaState v) => v.wantedDate;
  static const Field<AgendaState, int> _f$wantedDate =
      Field('wantedDate', _$wantedDate);

  @override
  final Map<Symbol, Field<AgendaState, dynamic>> fields = const {
    #status: _f$status,
    #realDays: _f$realDays,
    #wantedDate: _f$wantedDate,
  };

  static AgendaState _instantiate(DecodingData data) {
    return AgendaState(
        status: data.dec(_f$status),
        realDays: data.dec(_f$realDays),
        wantedDate: data.dec(_f$wantedDate));
  }

  @override
  final Function instantiate = _instantiate;

  static AgendaState fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AgendaState>(map);
  }

  static AgendaState deserialize(String json) {
    return ensureInitialized().decodeJson<AgendaState>(json);
  }
}

mixin AgendaStateMappable {
  String serialize() {
    return AgendaStateMapper.ensureInitialized()
        .encodeJson<AgendaState>(this as AgendaState);
  }

  Map<String, dynamic> toJson() {
    return AgendaStateMapper.ensureInitialized()
        .encodeMap<AgendaState>(this as AgendaState);
  }

  AgendaStateCopyWith<AgendaState, AgendaState, AgendaState> get copyWith =>
      _AgendaStateCopyWithImpl(this as AgendaState, $identity, $identity);
  @override
  String toString() {
    return AgendaStateMapper.ensureInitialized()
        .stringifyValue(this as AgendaState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            AgendaStateMapper.ensureInitialized()
                .isValueEqual(this as AgendaState, other));
  }

  @override
  int get hashCode {
    return AgendaStateMapper.ensureInitialized().hashValue(this as AgendaState);
  }
}

extension AgendaStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AgendaState, $Out> {
  AgendaStateCopyWith<$R, AgendaState, $Out> get $asAgendaState =>
      $base.as((v, t, t2) => _AgendaStateCopyWithImpl(v, t, t2));
}

abstract class AgendaStateCopyWith<$R, $In extends AgendaState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Day, DayCopyWith<$R, Day, Day>> get realDays;
  $R call({AgendaStatus? status, List<Day>? realDays, int? wantedDate});
  AgendaStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AgendaStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AgendaState, $Out>
    implements AgendaStateCopyWith<$R, AgendaState, $Out> {
  _AgendaStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AgendaState> $mapper =
      AgendaStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Day, DayCopyWith<$R, Day, Day>> get realDays => ListCopyWith(
      $value.realDays,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(realDays: v));
  @override
  $R call({AgendaStatus? status, List<Day>? realDays, int? wantedDate}) =>
      $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (realDays != null) #realDays: realDays,
        if (wantedDate != null) #wantedDate: wantedDate
      }));
  @override
  AgendaState $make(CopyWithData data) => AgendaState(
      status: data.get(#status, or: $value.status),
      realDays: data.get(#realDays, or: $value.realDays),
      wantedDate: data.get(#wantedDate, or: $value.wantedDate));

  @override
  AgendaStateCopyWith<$R2, AgendaState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AgendaStateCopyWithImpl($value, $cast, t);
}
