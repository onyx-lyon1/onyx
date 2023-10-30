// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'agenda.dart';

class AgendaMapper extends ClassMapperBase<Agenda> {
  AgendaMapper._();

  static AgendaMapper? _instance;
  static AgendaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AgendaMapper._());
      DayMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Agenda';

  static List<Day> _$days(Agenda v) => v.days;
  static const Field<Agenda, List<Day>> _f$days = Field('days', _$days);

  @override
  final Map<Symbol, Field<Agenda, dynamic>> fields = const {
    #days: _f$days,
  };

  static Agenda _instantiate(DecodingData data) {
    return Agenda(data.dec(_f$days));
  }

  @override
  final Function instantiate = _instantiate;

  static Agenda fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Agenda>(map);
  }

  static Agenda deserialize(String json) {
    return ensureInitialized().decodeJson<Agenda>(json);
  }
}

mixin AgendaMappable {
  String serialize() {
    return AgendaMapper.ensureInitialized().encodeJson<Agenda>(this as Agenda);
  }

  Map<String, dynamic> toJson() {
    return AgendaMapper.ensureInitialized().encodeMap<Agenda>(this as Agenda);
  }

  AgendaCopyWith<Agenda, Agenda, Agenda> get copyWith =>
      _AgendaCopyWithImpl(this as Agenda, $identity, $identity);
  @override
  String toString() {
    return AgendaMapper.ensureInitialized().stringifyValue(this as Agenda);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            AgendaMapper.ensureInitialized()
                .isValueEqual(this as Agenda, other));
  }

  @override
  int get hashCode {
    return AgendaMapper.ensureInitialized().hashValue(this as Agenda);
  }
}

extension AgendaValueCopy<$R, $Out> on ObjectCopyWith<$R, Agenda, $Out> {
  AgendaCopyWith<$R, Agenda, $Out> get $asAgenda =>
      $base.as((v, t, t2) => _AgendaCopyWithImpl(v, t, t2));
}

abstract class AgendaCopyWith<$R, $In extends Agenda, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Day, DayCopyWith<$R, Day, Day>> get days;
  $R call({List<Day>? days});
  AgendaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AgendaCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Agenda, $Out>
    implements AgendaCopyWith<$R, Agenda, $Out> {
  _AgendaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Agenda> $mapper = AgendaMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Day, DayCopyWith<$R, Day, Day>> get days => ListCopyWith(
      $value.days, (v, t) => v.copyWith.$chain(t), (v) => call(days: v));
  @override
  $R call({List<Day>? days}) =>
      $apply(FieldCopyWithData({if (days != null) #days: days}));
  @override
  Agenda $make(CopyWithData data) => Agenda(data.get(#days, or: $value.days));

  @override
  AgendaCopyWith<$R2, Agenda, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AgendaCopyWithImpl($value, $cast, t);
}
