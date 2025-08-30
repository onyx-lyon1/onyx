// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../stage_code.dart';

class StageCodeMapper extends ClassMapperBase<StageCode> {
  StageCodeMapper._();

  static StageCodeMapper? _instance;
  static StageCodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StageCodeMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'StageCode';

  static String _$title(StageCode v) => v.title;
  static const Field<StageCode, String> _f$title = Field('title', _$title);
  static String _$author(StageCode v) => v.author;
  static const Field<StageCode, String> _f$author = Field('author', _$author);
  static DateTime? _$date(StageCode v) => v.date;
  static const Field<StageCode, DateTime> _f$date = Field('date', _$date);
  static double _$position(StageCode v) => v.position;
  static const Field<StageCode, double> _f$position = Field(
    'position',
    _$position,
  );
  static String _$value(StageCode v) => v.value;
  static const Field<StageCode, String> _f$value = Field(
    'value',
    _$value,
    opt: true,
    def: "",
  );
  static bool _$isVisible(StageCode v) => v.isVisible;
  static const Field<StageCode, bool> _f$isVisible = Field(
    'isVisible',
    _$isVisible,
    mode: FieldMode.member,
  );
  static List<Object?> _$customProps(StageCode v) => v.customProps;
  static const Field<StageCode, List<Object?>> _f$customProps = Field(
    'customProps',
    _$customProps,
    mode: FieldMode.member,
  );

  @override
  final MappableFields<StageCode> fields = const {
    #title: _f$title,
    #author: _f$author,
    #date: _f$date,
    #position: _f$position,
    #value: _f$value,
    #isVisible: _f$isVisible,
    #customProps: _f$customProps,
  };

  static StageCode _instantiate(DecodingData data) {
    return StageCode(
      title: data.dec(_f$title),
      author: data.dec(_f$author),
      date: data.dec(_f$date),
      position: data.dec(_f$position),
      value: data.dec(_f$value),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static StageCode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StageCode>(map);
  }

  static StageCode fromJson(String json) {
    return ensureInitialized().decodeJson<StageCode>(json);
  }
}

mixin StageCodeMappable {
  String toJson() {
    return StageCodeMapper.ensureInitialized().encodeJson<StageCode>(
      this as StageCode,
    );
  }

  Map<String, dynamic> toMap() {
    return StageCodeMapper.ensureInitialized().encodeMap<StageCode>(
      this as StageCode,
    );
  }

  StageCodeCopyWith<StageCode, StageCode, StageCode> get copyWith =>
      _StageCodeCopyWithImpl<StageCode, StageCode>(
        this as StageCode,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return StageCodeMapper.ensureInitialized().stringifyValue(
      this as StageCode,
    );
  }

  @override
  bool operator ==(Object other) {
    return StageCodeMapper.ensureInitialized().equalsValue(
      this as StageCode,
      other,
    );
  }

  @override
  int get hashCode {
    return StageCodeMapper.ensureInitialized().hashValue(this as StageCode);
  }
}

extension StageCodeValueCopy<$R, $Out> on ObjectCopyWith<$R, StageCode, $Out> {
  StageCodeCopyWith<$R, StageCode, $Out> get $asStageCode =>
      $base.as((v, t, t2) => _StageCodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StageCodeCopyWith<$R, $In extends StageCode, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? title,
    String? author,
    DateTime? date,
    double? position,
    String? value,
  });
  StageCodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StageCodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StageCode, $Out>
    implements StageCodeCopyWith<$R, StageCode, $Out> {
  _StageCodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StageCode> $mapper =
      StageCodeMapper.ensureInitialized();
  @override
  $R call({
    String? title,
    String? author,
    Object? date = $none,
    double? position,
    String? value,
  }) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (author != null) #author: author,
      if (date != $none) #date: date,
      if (position != null) #position: position,
      if (value != null) #value: value,
    }),
  );
  @override
  StageCode $make(CopyWithData data) => StageCode(
    title: data.get(#title, or: $value.title),
    author: data.get(#author, or: $value.author),
    date: data.get(#date, or: $value.date),
    position: data.get(#position, or: $value.position),
    value: data.get(#value, or: $value.value),
  );

  @override
  StageCodeCopyWith<$R2, StageCode, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _StageCodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

