// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'teaching_unit_element.dart';

class TeachingUnitElementMapper extends ClassMapperBase<TeachingUnitElement> {
  TeachingUnitElementMapper._();

  static TeachingUnitElementMapper? _instance;
  static TeachingUnitElementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeachingUnitElementMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TeachingUnitElement';

  static String _$title(TeachingUnitElement v) => v.title;
  static const Field<TeachingUnitElement, String> _f$title =
      Field('title', _$title, opt: true, def: "");
  static String _$author(TeachingUnitElement v) => v.author;
  static const Field<TeachingUnitElement, String> _f$author =
      Field('author', _$author);
  static DateTime? _$date(TeachingUnitElement v) => v.date;
  static const Field<TeachingUnitElement, DateTime> _f$date =
      Field('date', _$date);
  static double _$position(TeachingUnitElement v) => v.position;
  static const Field<TeachingUnitElement, double> _f$position =
      Field('position', _$position);

  @override
  final Map<Symbol, Field<TeachingUnitElement, dynamic>> fields = const {
    #title: _f$title,
    #author: _f$author,
    #date: _f$date,
    #position: _f$position,
  };

  static TeachingUnitElement _instantiate(DecodingData data) {
    return TeachingUnitElement.mappableContruct(
        title: data.dec(_f$title),
        author: data.dec(_f$author),
        date: data.dec(_f$date),
        position: data.dec(_f$position));
  }

  @override
  final Function instantiate = _instantiate;

  static TeachingUnitElement fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeachingUnitElement>(map);
  }

  static TeachingUnitElement fromJson(String json) {
    return ensureInitialized().decodeJson<TeachingUnitElement>(json);
  }
}

mixin TeachingUnitElementMappable {
  String toJson() {
    return TeachingUnitElementMapper.ensureInitialized()
        .encodeJson<TeachingUnitElement>(this as TeachingUnitElement);
  }

  Map<String, dynamic> toMap() {
    return TeachingUnitElementMapper.ensureInitialized()
        .encodeMap<TeachingUnitElement>(this as TeachingUnitElement);
  }

  TeachingUnitElementCopyWith<TeachingUnitElement, TeachingUnitElement,
          TeachingUnitElement>
      get copyWith => _TeachingUnitElementCopyWithImpl(
          this as TeachingUnitElement, $identity, $identity);
  @override
  String toString() {
    return TeachingUnitElementMapper.ensureInitialized()
        .stringifyValue(this as TeachingUnitElement);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TeachingUnitElementMapper.ensureInitialized()
                .isValueEqual(this as TeachingUnitElement, other));
  }

  @override
  int get hashCode {
    return TeachingUnitElementMapper.ensureInitialized()
        .hashValue(this as TeachingUnitElement);
  }
}

extension TeachingUnitElementValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TeachingUnitElement, $Out> {
  TeachingUnitElementCopyWith<$R, TeachingUnitElement, $Out>
      get $asTeachingUnitElement =>
          $base.as((v, t, t2) => _TeachingUnitElementCopyWithImpl(v, t, t2));
}

abstract class TeachingUnitElementCopyWith<$R, $In extends TeachingUnitElement,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? author, DateTime? date, double? position});
  TeachingUnitElementCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TeachingUnitElementCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeachingUnitElement, $Out>
    implements TeachingUnitElementCopyWith<$R, TeachingUnitElement, $Out> {
  _TeachingUnitElementCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeachingUnitElement> $mapper =
      TeachingUnitElementMapper.ensureInitialized();
  @override
  $R call(
          {String? title,
          String? author,
          Object? date = $none,
          double? position}) =>
      $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (author != null) #author: author,
        if (date != $none) #date: date,
        if (position != null) #position: position
      }));
  @override
  TeachingUnitElement $make(CopyWithData data) =>
      TeachingUnitElement.mappableContruct(
          title: data.get(#title, or: $value.title),
          author: data.get(#author, or: $value.author),
          date: data.get(#date, or: $value.date),
          position: data.get(#position, or: $value.position));

  @override
  TeachingUnitElementCopyWith<$R2, TeachingUnitElement, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TeachingUnitElementCopyWithImpl($value, $cast, t);
}
