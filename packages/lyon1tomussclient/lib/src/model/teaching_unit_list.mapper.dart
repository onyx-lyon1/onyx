// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'teaching_unit_list.dart';

class TeachingUnitListMapper extends ClassMapperBase<TeachingUnitList> {
  TeachingUnitListMapper._();

  static TeachingUnitListMapper? _instance;
  static TeachingUnitListMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeachingUnitListMapper._());
      TeachingUnitMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TeachingUnitList';

  static List<TeachingUnit> _$teachingUnitModels(TeachingUnitList v) =>
      v.teachingUnitModels;
  static const Field<TeachingUnitList, List<TeachingUnit>>
      _f$teachingUnitModels = Field('teachingUnitModels', _$teachingUnitModels);
  static int _$semesterIndex(TeachingUnitList v) => v.semesterIndex;
  static const Field<TeachingUnitList, int> _f$semesterIndex =
      Field('semesterIndex', _$semesterIndex);

  @override
  final Map<Symbol, Field<TeachingUnitList, dynamic>> fields = const {
    #teachingUnitModels: _f$teachingUnitModels,
    #semesterIndex: _f$semesterIndex,
  };

  static TeachingUnitList _instantiate(DecodingData data) {
    return TeachingUnitList(
        data.dec(_f$teachingUnitModels), data.dec(_f$semesterIndex));
  }

  @override
  final Function instantiate = _instantiate;

  static TeachingUnitList fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeachingUnitList>(map);
  }

  static TeachingUnitList fromJson(String json) {
    return ensureInitialized().decodeJson<TeachingUnitList>(json);
  }
}

mixin TeachingUnitListMappable {
  String toJson() {
    return TeachingUnitListMapper.ensureInitialized()
        .encodeJson<TeachingUnitList>(this as TeachingUnitList);
  }

  Map<String, dynamic> toMap() {
    return TeachingUnitListMapper.ensureInitialized()
        .encodeMap<TeachingUnitList>(this as TeachingUnitList);
  }

  TeachingUnitListCopyWith<TeachingUnitList, TeachingUnitList, TeachingUnitList>
      get copyWith => _TeachingUnitListCopyWithImpl(
          this as TeachingUnitList, $identity, $identity);
  @override
  String toString() {
    return TeachingUnitListMapper.ensureInitialized()
        .stringifyValue(this as TeachingUnitList);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TeachingUnitListMapper.ensureInitialized()
                .isValueEqual(this as TeachingUnitList, other));
  }

  @override
  int get hashCode {
    return TeachingUnitListMapper.ensureInitialized()
        .hashValue(this as TeachingUnitList);
  }
}

extension TeachingUnitListValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TeachingUnitList, $Out> {
  TeachingUnitListCopyWith<$R, TeachingUnitList, $Out>
      get $asTeachingUnitList =>
          $base.as((v, t, t2) => _TeachingUnitListCopyWithImpl(v, t, t2));
}

abstract class TeachingUnitListCopyWith<$R, $In extends TeachingUnitList, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, TeachingUnit,
          TeachingUnitCopyWith<$R, TeachingUnit, TeachingUnit>>
      get teachingUnitModels;
  $R call({List<TeachingUnit>? teachingUnitModels, int? semesterIndex});
  TeachingUnitListCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TeachingUnitListCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeachingUnitList, $Out>
    implements TeachingUnitListCopyWith<$R, TeachingUnitList, $Out> {
  _TeachingUnitListCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeachingUnitList> $mapper =
      TeachingUnitListMapper.ensureInitialized();
  @override
  ListCopyWith<$R, TeachingUnit,
          TeachingUnitCopyWith<$R, TeachingUnit, TeachingUnit>>
      get teachingUnitModels => ListCopyWith($value.teachingUnitModels,
          (v, t) => v.copyWith.$chain(t), (v) => call(teachingUnitModels: v));
  @override
  $R call({List<TeachingUnit>? teachingUnitModels, int? semesterIndex}) =>
      $apply(FieldCopyWithData({
        if (teachingUnitModels != null) #teachingUnitModels: teachingUnitModels,
        if (semesterIndex != null) #semesterIndex: semesterIndex
      }));
  @override
  TeachingUnitList $make(CopyWithData data) => TeachingUnitList(
      data.get(#teachingUnitModels, or: $value.teachingUnitModels),
      data.get(#semesterIndex, or: $value.semesterIndex));

  @override
  TeachingUnitListCopyWith<$R2, TeachingUnitList, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TeachingUnitListCopyWithImpl($value, $cast, t);
}
