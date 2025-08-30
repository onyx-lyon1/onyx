// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../semester.dart';

class SemesterMapper extends ClassMapperBase<Semester> {
  SemesterMapper._();

  static SemesterMapper? _instance;
  static SemesterMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SemesterMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Semester';

  static String _$title(Semester v) => v.title;
  static const Field<Semester, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
    def: "",
  );
  static String _$url(Semester v) => v.url;
  static const Field<Semester, String> _f$url = Field(
    'url',
    _$url,
    opt: true,
    def: "",
  );

  @override
  final MappableFields<Semester> fields = const {
    #title: _f$title,
    #url: _f$url,
  };

  static Semester _instantiate(DecodingData data) {
    return Semester(title: data.dec(_f$title), url: data.dec(_f$url));
  }

  @override
  final Function instantiate = _instantiate;

  static Semester fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Semester>(map);
  }

  static Semester fromJson(String json) {
    return ensureInitialized().decodeJson<Semester>(json);
  }
}

mixin SemesterMappable {
  String toJson() {
    return SemesterMapper.ensureInitialized().encodeJson<Semester>(
      this as Semester,
    );
  }

  Map<String, dynamic> toMap() {
    return SemesterMapper.ensureInitialized().encodeMap<Semester>(
      this as Semester,
    );
  }

  SemesterCopyWith<Semester, Semester, Semester> get copyWith =>
      _SemesterCopyWithImpl<Semester, Semester>(
        this as Semester,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SemesterMapper.ensureInitialized().stringifyValue(this as Semester);
  }

  @override
  bool operator ==(Object other) {
    return SemesterMapper.ensureInitialized().equalsValue(
      this as Semester,
      other,
    );
  }

  @override
  int get hashCode {
    return SemesterMapper.ensureInitialized().hashValue(this as Semester);
  }
}

extension SemesterValueCopy<$R, $Out> on ObjectCopyWith<$R, Semester, $Out> {
  SemesterCopyWith<$R, Semester, $Out> get $asSemester =>
      $base.as((v, t, t2) => _SemesterCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SemesterCopyWith<$R, $In extends Semester, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? url});
  SemesterCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SemesterCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Semester, $Out>
    implements SemesterCopyWith<$R, Semester, $Out> {
  _SemesterCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Semester> $mapper =
      SemesterMapper.ensureInitialized();
  @override
  $R call({String? title, String? url}) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (url != null) #url: url,
    }),
  );
  @override
  Semester $make(CopyWithData data) => Semester(
    title: data.get(#title, or: $value.title),
    url: data.get(#url, or: $value.url),
  );

  @override
  SemesterCopyWith<$R2, Semester, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SemesterCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

