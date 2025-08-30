// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../presence.dart';

class PresenceMapper extends ClassMapperBase<Presence> {
  PresenceMapper._();

  static PresenceMapper? _instance;
  static PresenceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PresenceMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Presence';

  static String _$title(Presence v) => v.title;
  static const Field<Presence, String> _f$title = Field('title', _$title);
  static String _$author(Presence v) => v.author;
  static const Field<Presence, String> _f$author = Field('author', _$author);
  static DateTime? _$date(Presence v) => v.date;
  static const Field<Presence, DateTime> _f$date = Field('date', _$date);
  static double _$position(Presence v) => v.position;
  static const Field<Presence, double> _f$position = Field(
    'position',
    _$position,
  );
  static String _$value(Presence v) => v.value;
  static const Field<Presence, String> _f$value = Field(
    'value',
    _$value,
    opt: true,
    def: "",
  );
  static String? _$emptyIs(Presence v) => v.emptyIs;
  static const Field<Presence, String> _f$emptyIs = Field(
    'emptyIs',
    _$emptyIs,
    opt: true,
    def: "",
  );
  static PresenceColor _$color(Presence v) => v.color;
  static const Field<Presence, PresenceColor> _f$color = Field(
    'color',
    _$color,
    opt: true,
    def: PresenceColor.unset,
  );
  static DateTime? _$visibilityDate(Presence v) => v.visibilityDate;
  static const Field<Presence, DateTime> _f$visibilityDate = Field(
    'visibilityDate',
    _$visibilityDate,
    opt: true,
  );
  static bool? _$visible(Presence v) => v.visible;
  static const Field<Presence, bool> _f$visible = Field(
    'visible',
    _$visible,
    opt: true,
  );
  static bool _$isVisible(Presence v) => v.isVisible;
  static const Field<Presence, bool> _f$isVisible = Field(
    'isVisible',
    _$isVisible,
    mode: FieldMode.member,
  );
  static List<Object?> _$customProps(Presence v) => v.customProps;
  static const Field<Presence, List<Object?>> _f$customProps = Field(
    'customProps',
    _$customProps,
    mode: FieldMode.member,
  );

  @override
  final MappableFields<Presence> fields = const {
    #title: _f$title,
    #author: _f$author,
    #date: _f$date,
    #position: _f$position,
    #value: _f$value,
    #emptyIs: _f$emptyIs,
    #color: _f$color,
    #visibilityDate: _f$visibilityDate,
    #visible: _f$visible,
    #isVisible: _f$isVisible,
    #customProps: _f$customProps,
  };

  static Presence _instantiate(DecodingData data) {
    return Presence(
      title: data.dec(_f$title),
      author: data.dec(_f$author),
      date: data.dec(_f$date),
      position: data.dec(_f$position),
      value: data.dec(_f$value),
      emptyIs: data.dec(_f$emptyIs),
      color: data.dec(_f$color),
      visibilityDate: data.dec(_f$visibilityDate),
      visible: data.dec(_f$visible),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Presence fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Presence>(map);
  }

  static Presence fromJson(String json) {
    return ensureInitialized().decodeJson<Presence>(json);
  }
}

mixin PresenceMappable {
  String toJson() {
    return PresenceMapper.ensureInitialized().encodeJson<Presence>(
      this as Presence,
    );
  }

  Map<String, dynamic> toMap() {
    return PresenceMapper.ensureInitialized().encodeMap<Presence>(
      this as Presence,
    );
  }

  PresenceCopyWith<Presence, Presence, Presence> get copyWith =>
      _PresenceCopyWithImpl<Presence, Presence>(
        this as Presence,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PresenceMapper.ensureInitialized().stringifyValue(this as Presence);
  }

  @override
  bool operator ==(Object other) {
    return PresenceMapper.ensureInitialized().equalsValue(
      this as Presence,
      other,
    );
  }

  @override
  int get hashCode {
    return PresenceMapper.ensureInitialized().hashValue(this as Presence);
  }
}

extension PresenceValueCopy<$R, $Out> on ObjectCopyWith<$R, Presence, $Out> {
  PresenceCopyWith<$R, Presence, $Out> get $asPresence =>
      $base.as((v, t, t2) => _PresenceCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PresenceCopyWith<$R, $In extends Presence, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? title,
    String? author,
    DateTime? date,
    double? position,
    String? value,
    String? emptyIs,
    PresenceColor? color,
    DateTime? visibilityDate,
    bool? visible,
  });
  PresenceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PresenceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Presence, $Out>
    implements PresenceCopyWith<$R, Presence, $Out> {
  _PresenceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Presence> $mapper =
      PresenceMapper.ensureInitialized();
  @override
  $R call({
    String? title,
    String? author,
    Object? date = $none,
    double? position,
    String? value,
    Object? emptyIs = $none,
    PresenceColor? color,
    Object? visibilityDate = $none,
    Object? visible = $none,
  }) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (author != null) #author: author,
      if (date != $none) #date: date,
      if (position != null) #position: position,
      if (value != null) #value: value,
      if (emptyIs != $none) #emptyIs: emptyIs,
      if (color != null) #color: color,
      if (visibilityDate != $none) #visibilityDate: visibilityDate,
      if (visible != $none) #visible: visible,
    }),
  );
  @override
  Presence $make(CopyWithData data) => Presence(
    title: data.get(#title, or: $value.title),
    author: data.get(#author, or: $value.author),
    date: data.get(#date, or: $value.date),
    position: data.get(#position, or: $value.position),
    value: data.get(#value, or: $value.value),
    emptyIs: data.get(#emptyIs, or: $value.emptyIs),
    color: data.get(#color, or: $value.color),
    visibilityDate: data.get(#visibilityDate, or: $value.visibilityDate),
    visible: data.get(#visible, or: $value.visible),
  );

  @override
  PresenceCopyWith<$R2, Presence, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PresenceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

