// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../day.dart';

class DayMapper extends ClassMapperBase<Day> {
  DayMapper._();

  static DayMapper? _instance;
  static DayMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DayMapper._());
      EventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Day';

  static DateTime _$date(Day v) => v.date;
  static const Field<Day, DateTime> _f$date = Field('date', _$date);
  static List<Event> _$events(Day v) => v.events;
  static const Field<Day, List<Event>> _f$events = Field('events', _$events);

  @override
  final MappableFields<Day> fields = const {#date: _f$date, #events: _f$events};

  static Day _instantiate(DecodingData data) {
    return Day(data.dec(_f$date), data.dec(_f$events));
  }

  @override
  final Function instantiate = _instantiate;

  static Day fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Day>(map);
  }

  static Day fromJson(String json) {
    return ensureInitialized().decodeJson<Day>(json);
  }
}

mixin DayMappable {
  String toJson() {
    return DayMapper.ensureInitialized().encodeJson<Day>(this as Day);
  }

  Map<String, dynamic> toMap() {
    return DayMapper.ensureInitialized().encodeMap<Day>(this as Day);
  }

  DayCopyWith<Day, Day, Day> get copyWith =>
      _DayCopyWithImpl<Day, Day>(this as Day, $identity, $identity);
  @override
  String toString() {
    return DayMapper.ensureInitialized().stringifyValue(this as Day);
  }

  @override
  bool operator ==(Object other) {
    return DayMapper.ensureInitialized().equalsValue(this as Day, other);
  }

  @override
  int get hashCode {
    return DayMapper.ensureInitialized().hashValue(this as Day);
  }
}

extension DayValueCopy<$R, $Out> on ObjectCopyWith<$R, Day, $Out> {
  DayCopyWith<$R, Day, $Out> get $asDay =>
      $base.as((v, t, t2) => _DayCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DayCopyWith<$R, $In extends Day, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Event, EventCopyWith<$R, Event, Event>> get events;
  $R call({DateTime? date, List<Event>? events});
  DayCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DayCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Day, $Out>
    implements DayCopyWith<$R, Day, $Out> {
  _DayCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Day> $mapper = DayMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Event, EventCopyWith<$R, Event, Event>> get events =>
      ListCopyWith(
        $value.events,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(events: v),
      );
  @override
  $R call({DateTime? date, List<Event>? events}) => $apply(
    FieldCopyWithData({
      if (date != null) #date: date,
      if (events != null) #events: events,
    }),
  );
  @override
  Day $make(CopyWithData data) => Day(
    data.get(#date, or: $value.date),
    data.get(#events, or: $value.events),
  );

  @override
  DayCopyWith<$R2, Day, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _DayCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

