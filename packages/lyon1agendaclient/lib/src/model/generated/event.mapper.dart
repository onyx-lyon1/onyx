// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../event.dart';

class EventMapper extends ClassMapperBase<Event> {
  EventMapper._();

  static EventMapper? _instance;
  static EventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Event';

  static String _$location(Event v) => v.location;
  static const Field<Event, String> _f$location = Field('location', _$location);
  static String _$description(Event v) => v.description;
  static const Field<Event, String> _f$description = Field(
    'description',
    _$description,
  );
  static String _$teacher(Event v) => v.teacher;
  static const Field<Event, String> _f$teacher = Field('teacher', _$teacher);
  static String _$name(Event v) => v.name;
  static const Field<Event, String> _f$name = Field('name', _$name);
  static DateTime _$start(Event v) => v.start;
  static const Field<Event, DateTime> _f$start = Field('start', _$start);
  static DateTime _$end(Event v) => v.end;
  static const Field<Event, DateTime> _f$end = Field('end', _$end);
  static dynamic _$menuCrous(Event v) => v.menuCrous;
  static const Field<Event, dynamic> _f$menuCrous = Field(
    'menuCrous',
    _$menuCrous,
    opt: true,
  );

  @override
  final MappableFields<Event> fields = const {
    #location: _f$location,
    #description: _f$description,
    #teacher: _f$teacher,
    #name: _f$name,
    #start: _f$start,
    #end: _f$end,
    #menuCrous: _f$menuCrous,
  };

  static Event _instantiate(DecodingData data) {
    return Event(
      location: data.dec(_f$location),
      description: data.dec(_f$description),
      teacher: data.dec(_f$teacher),
      name: data.dec(_f$name),
      start: data.dec(_f$start),
      end: data.dec(_f$end),
      menuCrous: data.dec(_f$menuCrous),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Event fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Event>(map);
  }

  static Event fromJson(String json) {
    return ensureInitialized().decodeJson<Event>(json);
  }
}

mixin EventMappable {
  String toJson() {
    return EventMapper.ensureInitialized().encodeJson<Event>(this as Event);
  }

  Map<String, dynamic> toMap() {
    return EventMapper.ensureInitialized().encodeMap<Event>(this as Event);
  }

  EventCopyWith<Event, Event, Event> get copyWith =>
      _EventCopyWithImpl<Event, Event>(this as Event, $identity, $identity);
  @override
  String toString() {
    return EventMapper.ensureInitialized().stringifyValue(this as Event);
  }

  @override
  bool operator ==(Object other) {
    return EventMapper.ensureInitialized().equalsValue(this as Event, other);
  }

  @override
  int get hashCode {
    return EventMapper.ensureInitialized().hashValue(this as Event);
  }
}

extension EventValueCopy<$R, $Out> on ObjectCopyWith<$R, Event, $Out> {
  EventCopyWith<$R, Event, $Out> get $asEvent =>
      $base.as((v, t, t2) => _EventCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EventCopyWith<$R, $In extends Event, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? location,
    String? description,
    String? teacher,
    String? name,
    DateTime? start,
    DateTime? end,
    dynamic menuCrous,
  });
  EventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Event, $Out>
    implements EventCopyWith<$R, Event, $Out> {
  _EventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Event> $mapper = EventMapper.ensureInitialized();
  @override
  $R call({
    String? location,
    String? description,
    String? teacher,
    String? name,
    DateTime? start,
    DateTime? end,
    Object? menuCrous = $none,
  }) => $apply(
    FieldCopyWithData({
      if (location != null) #location: location,
      if (description != null) #description: description,
      if (teacher != null) #teacher: teacher,
      if (name != null) #name: name,
      if (start != null) #start: start,
      if (end != null) #end: end,
      if (menuCrous != $none) #menuCrous: menuCrous,
    }),
  );
  @override
  Event $make(CopyWithData data) => Event(
    location: data.get(#location, or: $value.location),
    description: data.get(#description, or: $value.description),
    teacher: data.get(#teacher, or: $value.teacher),
    name: data.get(#name, or: $value.name),
    start: data.get(#start, or: $value.start),
    end: data.get(#end, or: $value.end),
    menuCrous: data.get(#menuCrous, or: $value.menuCrous),
  );

  @override
  EventCopyWith<$R2, Event, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _EventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

