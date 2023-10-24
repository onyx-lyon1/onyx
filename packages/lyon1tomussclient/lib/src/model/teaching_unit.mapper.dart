// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'teaching_unit.dart';

class TeachingUnitMapper extends ClassMapperBase<TeachingUnit> {
  TeachingUnitMapper._();

  static TeachingUnitMapper? _instance;
  static TeachingUnitMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeachingUnitMapper._());
      TeacherMapper.ensureInitialized();
      GradeMapper.ensureInitialized();
      TomussTextMapper.ensureInitialized();
      EnumerationMapper.ensureInitialized();
      PresenceMapper.ensureInitialized();
      StageCodeMapper.ensureInitialized();
      UploadMapper.ensureInitialized();
      URLMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TeachingUnit';

  static String _$title(TeachingUnit v) => v.title;
  static const Field<TeachingUnit, String> _f$title =
      Field('title', _$title, opt: true, def: "");
  static List<Teacher> _$masters(TeachingUnit v) => v.masters;
  static const Field<TeachingUnit, List<Teacher>> _f$masters =
      Field('masters', _$masters, opt: true, def: const []);
  static List<Grade> _$grades(TeachingUnit v) => v.grades;
  static const Field<TeachingUnit, List<Grade>> _f$grades =
      Field('grades', _$grades, opt: true, def: const []);
  static List<TomussText> _$textValues(TeachingUnit v) => v.textValues;
  static const Field<TeachingUnit, List<TomussText>> _f$textValues =
      Field('textValues', _$textValues, opt: true, def: const []);
  static List<Enumeration> _$enumerations(TeachingUnit v) => v.enumerations;
  static const Field<TeachingUnit, List<Enumeration>> _f$enumerations =
      Field('enumerations', _$enumerations, opt: true, def: const []);
  static List<Presence> _$presences(TeachingUnit v) => v.presences;
  static const Field<TeachingUnit, List<Presence>> _f$presences =
      Field('presences', _$presences, opt: true, def: const []);
  static List<StageCode> _$stageCodes(TeachingUnit v) => v.stageCodes;
  static const Field<TeachingUnit, List<StageCode>> _f$stageCodes =
      Field('stageCodes', _$stageCodes, opt: true, def: const []);
  static List<Upload> _$uploads(TeachingUnit v) => v.uploads;
  static const Field<TeachingUnit, List<Upload>> _f$uploads =
      Field('uploads', _$uploads, opt: true, def: const []);
  static List<URL> _$urls(TeachingUnit v) => v.urls;
  static const Field<TeachingUnit, List<URL>> _f$urls =
      Field('urls', _$urls, opt: true, def: const []);
  static String _$ticket(TeachingUnit v) => v.ticket;
  static const Field<TeachingUnit, String> _f$ticket =
      Field('ticket', _$ticket, opt: true, def: "");
  static String _$ue(TeachingUnit v) => v.ue;
  static const Field<TeachingUnit, String> _f$ue =
      Field('ue', _$ue, opt: true, def: "");

  @override
  final Map<Symbol, Field<TeachingUnit, dynamic>> fields = const {
    #title: _f$title,
    #masters: _f$masters,
    #grades: _f$grades,
    #textValues: _f$textValues,
    #enumerations: _f$enumerations,
    #presences: _f$presences,
    #stageCodes: _f$stageCodes,
    #uploads: _f$uploads,
    #urls: _f$urls,
    #ticket: _f$ticket,
    #ue: _f$ue,
  };

  static TeachingUnit _instantiate(DecodingData data) {
    return TeachingUnit.mappableConstruct(
        title: data.dec(_f$title),
        masters: data.dec(_f$masters),
        grades: data.dec(_f$grades),
        textValues: data.dec(_f$textValues),
        enumerations: data.dec(_f$enumerations),
        presences: data.dec(_f$presences),
        stageCodes: data.dec(_f$stageCodes),
        uploads: data.dec(_f$uploads),
        urls: data.dec(_f$urls),
        ticket: data.dec(_f$ticket),
        ue: data.dec(_f$ue));
  }

  @override
  final Function instantiate = _instantiate;

  static TeachingUnit fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeachingUnit>(map);
  }

  static TeachingUnit fromJson(String json) {
    return ensureInitialized().decodeJson<TeachingUnit>(json);
  }
}

mixin TeachingUnitMappable {
  String toJson() {
    return TeachingUnitMapper.ensureInitialized()
        .encodeJson<TeachingUnit>(this as TeachingUnit);
  }

  Map<String, dynamic> toMap() {
    return TeachingUnitMapper.ensureInitialized()
        .encodeMap<TeachingUnit>(this as TeachingUnit);
  }

  TeachingUnitCopyWith<TeachingUnit, TeachingUnit, TeachingUnit> get copyWith =>
      _TeachingUnitCopyWithImpl(this as TeachingUnit, $identity, $identity);
  @override
  String toString() {
    return TeachingUnitMapper.ensureInitialized()
        .stringifyValue(this as TeachingUnit);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TeachingUnitMapper.ensureInitialized()
                .isValueEqual(this as TeachingUnit, other));
  }

  @override
  int get hashCode {
    return TeachingUnitMapper.ensureInitialized()
        .hashValue(this as TeachingUnit);
  }
}

extension TeachingUnitValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TeachingUnit, $Out> {
  TeachingUnitCopyWith<$R, TeachingUnit, $Out> get $asTeachingUnit =>
      $base.as((v, t, t2) => _TeachingUnitCopyWithImpl(v, t, t2));
}

abstract class TeachingUnitCopyWith<$R, $In extends TeachingUnit, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Teacher, TeacherCopyWith<$R, Teacher, Teacher>> get masters;
  ListCopyWith<$R, Grade, GradeCopyWith<$R, Grade, Grade>> get grades;
  ListCopyWith<$R, TomussText, TomussTextCopyWith<$R, TomussText, TomussText>>
      get textValues;
  ListCopyWith<$R, Enumeration,
      EnumerationCopyWith<$R, Enumeration, Enumeration>> get enumerations;
  ListCopyWith<$R, Presence, PresenceCopyWith<$R, Presence, Presence>>
      get presences;
  ListCopyWith<$R, StageCode, StageCodeCopyWith<$R, StageCode, StageCode>>
      get stageCodes;
  ListCopyWith<$R, Upload, UploadCopyWith<$R, Upload, Upload>> get uploads;
  ListCopyWith<$R, URL, URLCopyWith<$R, URL, URL>> get urls;
  $R call(
      {String? title,
      List<Teacher>? masters,
      List<Grade>? grades,
      List<TomussText>? textValues,
      List<Enumeration>? enumerations,
      List<Presence>? presences,
      List<StageCode>? stageCodes,
      List<Upload>? uploads,
      List<URL>? urls,
      String? ticket,
      String? ue});
  TeachingUnitCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TeachingUnitCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeachingUnit, $Out>
    implements TeachingUnitCopyWith<$R, TeachingUnit, $Out> {
  _TeachingUnitCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeachingUnit> $mapper =
      TeachingUnitMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Teacher, TeacherCopyWith<$R, Teacher, Teacher>>
      get masters => ListCopyWith($value.masters,
          (v, t) => v.copyWith.$chain(t), (v) => call(masters: v));
  @override
  ListCopyWith<$R, Grade, GradeCopyWith<$R, Grade, Grade>> get grades =>
      ListCopyWith($value.grades, (v, t) => v.copyWith.$chain(t),
          (v) => call(grades: v));
  @override
  ListCopyWith<$R, TomussText, TomussTextCopyWith<$R, TomussText, TomussText>>
      get textValues => ListCopyWith($value.textValues,
          (v, t) => v.copyWith.$chain(t), (v) => call(textValues: v));
  @override
  ListCopyWith<$R, Enumeration,
          EnumerationCopyWith<$R, Enumeration, Enumeration>>
      get enumerations => ListCopyWith($value.enumerations,
          (v, t) => v.copyWith.$chain(t), (v) => call(enumerations: v));
  @override
  ListCopyWith<$R, Presence, PresenceCopyWith<$R, Presence, Presence>>
      get presences => ListCopyWith($value.presences,
          (v, t) => v.copyWith.$chain(t), (v) => call(presences: v));
  @override
  ListCopyWith<$R, StageCode, StageCodeCopyWith<$R, StageCode, StageCode>>
      get stageCodes => ListCopyWith($value.stageCodes,
          (v, t) => v.copyWith.$chain(t), (v) => call(stageCodes: v));
  @override
  ListCopyWith<$R, Upload, UploadCopyWith<$R, Upload, Upload>> get uploads =>
      ListCopyWith($value.uploads, (v, t) => v.copyWith.$chain(t),
          (v) => call(uploads: v));
  @override
  ListCopyWith<$R, URL, URLCopyWith<$R, URL, URL>> get urls => ListCopyWith(
      $value.urls, (v, t) => v.copyWith.$chain(t), (v) => call(urls: v));
  @override
  $R call(
          {String? title,
          List<Teacher>? masters,
          List<Grade>? grades,
          List<TomussText>? textValues,
          List<Enumeration>? enumerations,
          List<Presence>? presences,
          List<StageCode>? stageCodes,
          List<Upload>? uploads,
          List<URL>? urls,
          String? ticket,
          String? ue}) =>
      $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (masters != null) #masters: masters,
        if (grades != null) #grades: grades,
        if (textValues != null) #textValues: textValues,
        if (enumerations != null) #enumerations: enumerations,
        if (presences != null) #presences: presences,
        if (stageCodes != null) #stageCodes: stageCodes,
        if (uploads != null) #uploads: uploads,
        if (urls != null) #urls: urls,
        if (ticket != null) #ticket: ticket,
        if (ue != null) #ue: ue
      }));
  @override
  TeachingUnit $make(CopyWithData data) => TeachingUnit.mappableConstruct(
      title: data.get(#title, or: $value.title),
      masters: data.get(#masters, or: $value.masters),
      grades: data.get(#grades, or: $value.grades),
      textValues: data.get(#textValues, or: $value.textValues),
      enumerations: data.get(#enumerations, or: $value.enumerations),
      presences: data.get(#presences, or: $value.presences),
      stageCodes: data.get(#stageCodes, or: $value.stageCodes),
      uploads: data.get(#uploads, or: $value.uploads),
      urls: data.get(#urls, or: $value.urls),
      ticket: data.get(#ticket, or: $value.ticket),
      ue: data.get(#ue, or: $value.ue));

  @override
  TeachingUnitCopyWith<$R2, TeachingUnit, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TeachingUnitCopyWithImpl($value, $cast, t);
}
