// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'semester_list.dart';

class SemesterListMapper extends ClassMapperBase<SemesterList> {
  SemesterListMapper._();

  static SemesterListMapper? _instance;
  static SemesterListMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SemesterListMapper._());
      SemesterMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SemesterList';

  static List<Semester> _$semestres(SemesterList v) => v.semestres;
  static const Field<SemesterList, List<Semester>> _f$semestres =
      Field('semestres', _$semestres);
  static int _$currentSemesterIndex(SemesterList v) => v.currentSemesterIndex;
  static const Field<SemesterList, int> _f$currentSemesterIndex =
      Field('currentSemesterIndex', _$currentSemesterIndex, opt: true, def: 0);

  @override
  final Map<Symbol, Field<SemesterList, dynamic>> fields = const {
    #semestres: _f$semestres,
    #currentSemesterIndex: _f$currentSemesterIndex,
  };

  static SemesterList _instantiate(DecodingData data) {
    return SemesterList(data.dec(_f$semestres),
        currentSemesterIndex: data.dec(_f$currentSemesterIndex));
  }

  @override
  final Function instantiate = _instantiate;

  static SemesterList fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SemesterList>(map);
  }

  static SemesterList fromJson(String json) {
    return ensureInitialized().decodeJson<SemesterList>(json);
  }
}

mixin SemesterListMappable {
  String toJson() {
    return SemesterListMapper.ensureInitialized()
        .encodeJson<SemesterList>(this as SemesterList);
  }

  Map<String, dynamic> toMap() {
    return SemesterListMapper.ensureInitialized()
        .encodeMap<SemesterList>(this as SemesterList);
  }

  SemesterListCopyWith<SemesterList, SemesterList, SemesterList> get copyWith =>
      _SemesterListCopyWithImpl(this as SemesterList, $identity, $identity);
  @override
  String toString() {
    return SemesterListMapper.ensureInitialized()
        .stringifyValue(this as SemesterList);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SemesterListMapper.ensureInitialized()
                .isValueEqual(this as SemesterList, other));
  }

  @override
  int get hashCode {
    return SemesterListMapper.ensureInitialized()
        .hashValue(this as SemesterList);
  }
}

extension SemesterListValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SemesterList, $Out> {
  SemesterListCopyWith<$R, SemesterList, $Out> get $asSemesterList =>
      $base.as((v, t, t2) => _SemesterListCopyWithImpl(v, t, t2));
}

abstract class SemesterListCopyWith<$R, $In extends SemesterList, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Semester, SemesterCopyWith<$R, Semester, Semester>>
      get semestres;
  $R call({List<Semester>? semestres, int? currentSemesterIndex});
  SemesterListCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SemesterListCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SemesterList, $Out>
    implements SemesterListCopyWith<$R, SemesterList, $Out> {
  _SemesterListCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SemesterList> $mapper =
      SemesterListMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Semester, SemesterCopyWith<$R, Semester, Semester>>
      get semestres => ListCopyWith($value.semestres,
          (v, t) => v.copyWith.$chain(t), (v) => call(semestres: v));
  @override
  $R call({List<Semester>? semestres, int? currentSemesterIndex}) =>
      $apply(FieldCopyWithData({
        if (semestres != null) #semestres: semestres,
        if (currentSemesterIndex != null)
          #currentSemesterIndex: currentSemesterIndex
      }));
  @override
  SemesterList $make(CopyWithData data) =>
      SemesterList(data.get(#semestres, or: $value.semestres),
          currentSemesterIndex:
              data.get(#currentSemesterIndex, or: $value.currentSemesterIndex));

  @override
  SemesterListCopyWith<$R2, SemesterList, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SemesterListCopyWithImpl($value, $cast, t);
}
