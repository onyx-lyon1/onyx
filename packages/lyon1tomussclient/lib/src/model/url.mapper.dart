// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'url.dart';

class URLMapper extends SubClassMapperBase<URL> {
  URLMapper._();

  static URLMapper? _instance;
  static URLMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = URLMapper._());
      TeachingUnitElementMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'URL';

  static String _$title(URL v) => v.title;
  static const Field<URL, String> _f$title =
      Field('title', _$title, opt: true, def: "");
  static String _$author(URL v) => v.author;
  static const Field<URL, String> _f$author =
      Field('author', _$author, opt: true, def: "");
  static DateTime? _$date(URL v) => v.date;
  static const Field<URL, DateTime> _f$date = Field('date', _$date, opt: true);
  static double _$position(URL v) => v.position;
  static const Field<URL, double> _f$position =
      Field('position', _$position, opt: true, def: 0);
  static String _$value(URL v) => v.value;
  static const Field<URL, String> _f$value =
      Field('value', _$value, opt: true, def: "");

  @override
  final Map<Symbol, Field<URL, dynamic>> fields = const {
    #title: _f$title,
    #author: _f$author,
    #date: _f$date,
    #position: _f$position,
    #value: _f$value,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'URL';
  @override
  late final ClassMapperBase superMapper =
      TeachingUnitElementMapper.ensureInitialized();

  static URL _instantiate(DecodingData data) {
    return URL.mappableConstruct(
        title: data.dec(_f$title),
        author: data.dec(_f$author),
        date: data.dec(_f$date),
        position: data.dec(_f$position),
        value: data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static URL fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<URL>(map);
  }

  static URL fromJson(String json) {
    return ensureInitialized().decodeJson<URL>(json);
  }
}

mixin URLMappable {
  String toJson() {
    return URLMapper.ensureInitialized().encodeJson<URL>(this as URL);
  }

  Map<String, dynamic> toMap() {
    return URLMapper.ensureInitialized().encodeMap<URL>(this as URL);
  }

  URLCopyWith<URL, URL, URL> get copyWith =>
      _URLCopyWithImpl(this as URL, $identity, $identity);
  @override
  String toString() {
    return URLMapper.ensureInitialized().stringifyValue(this as URL);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            URLMapper.ensureInitialized().isValueEqual(this as URL, other));
  }

  @override
  int get hashCode {
    return URLMapper.ensureInitialized().hashValue(this as URL);
  }
}

extension URLValueCopy<$R, $Out> on ObjectCopyWith<$R, URL, $Out> {
  URLCopyWith<$R, URL, $Out> get $asURL =>
      $base.as((v, t, t2) => _URLCopyWithImpl(v, t, t2));
}

abstract class URLCopyWith<$R, $In extends URL, $Out>
    implements TeachingUnitElementCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? title,
      String? author,
      DateTime? date,
      double? position,
      String? value});
  URLCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _URLCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, URL, $Out>
    implements URLCopyWith<$R, URL, $Out> {
  _URLCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<URL> $mapper = URLMapper.ensureInitialized();
  @override
  $R call(
          {String? title,
          String? author,
          Object? date = $none,
          double? position,
          String? value}) =>
      $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (author != null) #author: author,
        if (date != $none) #date: date,
        if (position != null) #position: position,
        if (value != null) #value: value
      }));
  @override
  URL $make(CopyWithData data) => URL.mappableConstruct(
      title: data.get(#title, or: $value.title),
      author: data.get(#author, or: $value.author),
      date: data.get(#date, or: $value.date),
      position: data.get(#position, or: $value.position),
      value: data.get(#value, or: $value.value));

  @override
  URLCopyWith<$R2, URL, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _URLCopyWithImpl($value, $cast, t);
}
