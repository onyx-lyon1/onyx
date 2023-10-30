// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'enumeration.dart';

class EnumerationMapper extends SubClassMapperBase<Enumeration> {
  EnumerationMapper._();

  static EnumerationMapper? _instance;
  static EnumerationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EnumerationMapper._());
      TeachingUnitElementMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'Enumeration';

  static String _$title(Enumeration v) => v.title;
  static const Field<Enumeration, String> _f$title =
      Field('title', _$title, opt: true, def: "");
  static String _$author(Enumeration v) => v.author;
  static const Field<Enumeration, String> _f$author =
      Field('author', _$author, opt: true, def: "");
  static DateTime? _$date(Enumeration v) => v.date;
  static const Field<Enumeration, DateTime> _f$date =
      Field('date', _$date, opt: true);
  static double _$position(Enumeration v) => v.position;
  static const Field<Enumeration, double> _f$position =
      Field('position', _$position, opt: true, def: 0);
  static String? _$value(Enumeration v) => v.value;
  static const Field<Enumeration, String> _f$value =
      Field('value', _$value, opt: true);
  static List<String> _$values(Enumeration v) => v.values;
  static const Field<Enumeration, List<String>> _f$values =
      Field('values', _$values, opt: true, def: const []);
  static String _$comment(Enumeration v) => v.comment;
  static const Field<Enumeration, String> _f$comment =
      Field('comment', _$comment, opt: true, def: "");
  static String _$theId(Enumeration v) => v.theId;
  static const Field<Enumeration, String> _f$theId =
      Field('theId', _$theId, opt: true, def: "");
  static String _$lineId(Enumeration v) => v.lineId;
  static const Field<Enumeration, String> _f$lineId =
      Field('lineId', _$lineId, opt: true, def: "");
  static String _$ue(Enumeration v) => v.ue;
  static const Field<Enumeration, String> _f$ue =
      Field('ue', _$ue, opt: true, def: "");
  static String _$semester(Enumeration v) => v.semester;
  static const Field<Enumeration, String> _f$semester =
      Field('semester', _$semester, opt: true, def: "");
  static String _$year(Enumeration v) => v.year;
  static const Field<Enumeration, String> _f$year =
      Field('year', _$year, opt: true, def: "");
  static bool _$modifiable(Enumeration v) => v.modifiable;
  static const Field<Enumeration, bool> _f$modifiable =
      Field('modifiable', _$modifiable, opt: true, def: true);

  @override
  final Map<Symbol, Field<Enumeration, dynamic>> fields = const {
    #title: _f$title,
    #author: _f$author,
    #date: _f$date,
    #position: _f$position,
    #value: _f$value,
    #values: _f$values,
    #comment: _f$comment,
    #theId: _f$theId,
    #lineId: _f$lineId,
    #ue: _f$ue,
    #semester: _f$semester,
    #year: _f$year,
    #modifiable: _f$modifiable,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'Enumeration';
  @override
  late final ClassMapperBase superMapper =
      TeachingUnitElementMapper.ensureInitialized();

  static Enumeration _instantiate(DecodingData data) {
    return Enumeration.mappableConsctruct(
        title: data.dec(_f$title),
        author: data.dec(_f$author),
        date: data.dec(_f$date),
        position: data.dec(_f$position),
        value: data.dec(_f$value),
        values: data.dec(_f$values),
        comment: data.dec(_f$comment),
        theId: data.dec(_f$theId),
        lineId: data.dec(_f$lineId),
        ue: data.dec(_f$ue),
        semester: data.dec(_f$semester),
        year: data.dec(_f$year),
        modifiable: data.dec(_f$modifiable));
  }

  @override
  final Function instantiate = _instantiate;

  static Enumeration fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Enumeration>(map);
  }

  static Enumeration deserialize(String json) {
    return ensureInitialized().decodeJson<Enumeration>(json);
  }
}

mixin EnumerationMappable {
  String serialize() {
    return EnumerationMapper.ensureInitialized()
        .encodeJson<Enumeration>(this as Enumeration);
  }

  Map<String, dynamic> toJson() {
    return EnumerationMapper.ensureInitialized()
        .encodeMap<Enumeration>(this as Enumeration);
  }

  EnumerationCopyWith<Enumeration, Enumeration, Enumeration> get copyWith =>
      _EnumerationCopyWithImpl(this as Enumeration, $identity, $identity);
  @override
  String toString() {
    return EnumerationMapper.ensureInitialized()
        .stringifyValue(this as Enumeration);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            EnumerationMapper.ensureInitialized()
                .isValueEqual(this as Enumeration, other));
  }

  @override
  int get hashCode {
    return EnumerationMapper.ensureInitialized().hashValue(this as Enumeration);
  }
}

extension EnumerationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Enumeration, $Out> {
  EnumerationCopyWith<$R, Enumeration, $Out> get $asEnumeration =>
      $base.as((v, t, t2) => _EnumerationCopyWithImpl(v, t, t2));
}

abstract class EnumerationCopyWith<$R, $In extends Enumeration, $Out>
    implements TeachingUnitElementCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get values;
  @override
  $R call(
      {String? title,
      String? author,
      DateTime? date,
      double? position,
      String? value,
      List<String>? values,
      String? comment,
      String? theId,
      String? lineId,
      String? ue,
      String? semester,
      String? year,
      bool? modifiable});
  EnumerationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EnumerationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Enumeration, $Out>
    implements EnumerationCopyWith<$R, Enumeration, $Out> {
  _EnumerationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Enumeration> $mapper =
      EnumerationMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get values =>
      ListCopyWith($value.values, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(values: v));
  @override
  $R call(
          {String? title,
          String? author,
          Object? date = $none,
          double? position,
          Object? value = $none,
          List<String>? values,
          String? comment,
          String? theId,
          String? lineId,
          String? ue,
          String? semester,
          String? year,
          bool? modifiable}) =>
      $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (author != null) #author: author,
        if (date != $none) #date: date,
        if (position != null) #position: position,
        if (value != $none) #value: value,
        if (values != null) #values: values,
        if (comment != null) #comment: comment,
        if (theId != null) #theId: theId,
        if (lineId != null) #lineId: lineId,
        if (ue != null) #ue: ue,
        if (semester != null) #semester: semester,
        if (year != null) #year: year,
        if (modifiable != null) #modifiable: modifiable
      }));
  @override
  Enumeration $make(CopyWithData data) => Enumeration.mappableConsctruct(
      title: data.get(#title, or: $value.title),
      author: data.get(#author, or: $value.author),
      date: data.get(#date, or: $value.date),
      position: data.get(#position, or: $value.position),
      value: data.get(#value, or: $value.value),
      values: data.get(#values, or: $value.values),
      comment: data.get(#comment, or: $value.comment),
      theId: data.get(#theId, or: $value.theId),
      lineId: data.get(#lineId, or: $value.lineId),
      ue: data.get(#ue, or: $value.ue),
      semester: data.get(#semester, or: $value.semester),
      year: data.get(#year, or: $value.year),
      modifiable: data.get(#modifiable, or: $value.modifiable));

  @override
  EnumerationCopyWith<$R2, Enumeration, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EnumerationCopyWithImpl($value, $cast, t);
}
