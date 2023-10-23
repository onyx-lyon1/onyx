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
      Field('author', _$author, opt: true, def: "");
  static DateTime? _$date(TeachingUnitElement v) => v.date;
  static const Field<TeachingUnitElement, DateTime> _f$date =
      Field('date', _$date, opt: true);
  static double _$position(TeachingUnitElement v) => v.position;
  static const Field<TeachingUnitElement, double> _f$position =
      Field('position', _$position, opt: true, def: 0);

  @override
  final Map<Symbol, Field<TeachingUnitElement, dynamic>> fields = const {
    #title: _f$title,
    #author: _f$author,
    #date: _f$date,
    #position: _f$position,
  };

  static TeachingUnitElement _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('TeachingUnitElement');
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
  String toJson();
  Map<String, dynamic> toMap();
  TeachingUnitElementCopyWith<TeachingUnitElement, TeachingUnitElement,
      TeachingUnitElement> get copyWith;
}

abstract class TeachingUnitElementCopyWith<$R, $In extends TeachingUnitElement,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? author, DateTime? date, double? position});
  TeachingUnitElementCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}
