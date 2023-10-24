// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'semester.dart';

class SemesterMapper extends ClassMapperBase<Semester> {
  SemesterMapper._();

  static SemesterMapper? _instance;
  static SemesterMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SemesterMapper._());
      TeachingUnitMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Semester';

  static String _$title(Semester v) => v.title;
  static const Field<Semester, String> _f$title =
      Field('title', _$title, opt: true, def: "");
  static String _$url(Semester v) => v.url;
  static const Field<Semester, String> _f$url =
      Field('url', _$url, opt: true, def: "");
  static List<TeachingUnit> _$teachingUnits(Semester v) => v.teachingUnits;
  static const Field<Semester, List<TeachingUnit>> _f$teachingUnits =
      Field('teachingUnits', _$teachingUnits, opt: true, def: const []);

  @override
  final Map<Symbol, Field<Semester, dynamic>> fields = const {
    #title: _f$title,
    #url: _f$url,
    #teachingUnits: _f$teachingUnits,
  };

  static Semester _instantiate(DecodingData data) {
    return Semester.mappableConstruct(
        title: data.dec(_f$title),
        url: data.dec(_f$url),
        teachingUnits: data.dec(_f$teachingUnits));
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
    return SemesterMapper.ensureInitialized()
        .encodeJson<Semester>(this as Semester);
  }

  Map<String, dynamic> toMap() {
    return SemesterMapper.ensureInitialized()
        .encodeMap<Semester>(this as Semester);
  }

  SemesterCopyWith<Semester, Semester, Semester> get copyWith =>
      _SemesterCopyWithImpl(this as Semester, $identity, $identity);
  @override
  String toString() {
    return SemesterMapper.ensureInitialized().stringifyValue(this as Semester);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SemesterMapper.ensureInitialized()
                .isValueEqual(this as Semester, other));
  }

  @override
  int get hashCode {
    return SemesterMapper.ensureInitialized().hashValue(this as Semester);
  }
}

extension SemesterValueCopy<$R, $Out> on ObjectCopyWith<$R, Semester, $Out> {
  SemesterCopyWith<$R, Semester, $Out> get $asSemester =>
      $base.as((v, t, t2) => _SemesterCopyWithImpl(v, t, t2));
}

abstract class SemesterCopyWith<$R, $In extends Semester, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, TeachingUnit,
      TeachingUnitCopyWith<$R, TeachingUnit, TeachingUnit>> get teachingUnits;
  $R call({String? title, String? url, List<TeachingUnit>? teachingUnits});
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
  ListCopyWith<$R, TeachingUnit,
          TeachingUnitCopyWith<$R, TeachingUnit, TeachingUnit>>
      get teachingUnits => ListCopyWith($value.teachingUnits,
          (v, t) => v.copyWith.$chain(t), (v) => call(teachingUnits: v));
  @override
  $R call({String? title, String? url, List<TeachingUnit>? teachingUnits}) =>
      $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (url != null) #url: url,
        if (teachingUnits != null) #teachingUnits: teachingUnits
      }));
  @override
  Semester $make(CopyWithData data) => Semester.mappableConstruct(
      title: data.get(#title, or: $value.title),
      url: data.get(#url, or: $value.url),
      teachingUnits: data.get(#teachingUnits, or: $value.teachingUnits));

  @override
  SemesterCopyWith<$R2, Semester, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SemesterCopyWithImpl($value, $cast, t);
}
