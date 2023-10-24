// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'tomuss_text.dart';

class TomussTextMapper extends SubClassMapperBase<TomussText> {
  TomussTextMapper._();

  static TomussTextMapper? _instance;
  static TomussTextMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TomussTextMapper._());
      TeachingUnitElementMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TomussText';

  static String _$title(TomussText v) => v.title;
  static const Field<TomussText, String> _f$title =
      Field('title', _$title, opt: true, def: "");
  static String _$author(TomussText v) => v.author;
  static const Field<TomussText, String> _f$author =
      Field('author', _$author, opt: true, def: "");
  static DateTime? _$date(TomussText v) => v.date;
  static const Field<TomussText, DateTime> _f$date =
      Field('date', _$date, opt: true);
  static double _$position(TomussText v) => v.position;
  static const Field<TomussText, double> _f$position =
      Field('position', _$position, opt: true, def: 0);
  static String _$value(TomussText v) => v.value;
  static const Field<TomussText, String> _f$value =
      Field('value', _$value, opt: true, def: "");
  static String _$comment(TomussText v) => v.comment;
  static const Field<TomussText, String> _f$comment =
      Field('comment', _$comment, opt: true, def: "");
  static bool _$isValidText(TomussText v) => v.isValidText;
  static const Field<TomussText, bool> _f$isValidText =
      Field('isValidText', _$isValidText, opt: true, def: false);
  static bool _$isHidden(TomussText v) => v.isHidden;
  static const Field<TomussText, bool> _f$isHidden =
      Field('isHidden', _$isHidden, opt: true, def: false);
  static String _$theId(TomussText v) => v.theId;
  static const Field<TomussText, String> _f$theId =
      Field('theId', _$theId, opt: true, def: "");

  @override
  final Map<Symbol, Field<TomussText, dynamic>> fields = const {
    #title: _f$title,
    #author: _f$author,
    #date: _f$date,
    #position: _f$position,
    #value: _f$value,
    #comment: _f$comment,
    #isValidText: _f$isValidText,
    #isHidden: _f$isHidden,
    #theId: _f$theId,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TomussText';
  @override
  late final ClassMapperBase superMapper =
      TeachingUnitElementMapper.ensureInitialized();

  static TomussText _instantiate(DecodingData data) {
    return TomussText.mappableConstruct(
        title: data.dec(_f$title),
        author: data.dec(_f$author),
        date: data.dec(_f$date),
        position: data.dec(_f$position),
        value: data.dec(_f$value),
        comment: data.dec(_f$comment),
        isValidText: data.dec(_f$isValidText),
        isHidden: data.dec(_f$isHidden),
        theId: data.dec(_f$theId));
  }

  @override
  final Function instantiate = _instantiate;

  static TomussText fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TomussText>(map);
  }

  static TomussText fromJson(String json) {
    return ensureInitialized().decodeJson<TomussText>(json);
  }
}

mixin TomussTextMappable {
  String toJson() {
    return TomussTextMapper.ensureInitialized()
        .encodeJson<TomussText>(this as TomussText);
  }

  Map<String, dynamic> toMap() {
    return TomussTextMapper.ensureInitialized()
        .encodeMap<TomussText>(this as TomussText);
  }

  TomussTextCopyWith<TomussText, TomussText, TomussText> get copyWith =>
      _TomussTextCopyWithImpl(this as TomussText, $identity, $identity);
  @override
  String toString() {
    return TomussTextMapper.ensureInitialized()
        .stringifyValue(this as TomussText);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TomussTextMapper.ensureInitialized()
                .isValueEqual(this as TomussText, other));
  }

  @override
  int get hashCode {
    return TomussTextMapper.ensureInitialized().hashValue(this as TomussText);
  }
}

extension TomussTextValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TomussText, $Out> {
  TomussTextCopyWith<$R, TomussText, $Out> get $asTomussText =>
      $base.as((v, t, t2) => _TomussTextCopyWithImpl(v, t, t2));
}

abstract class TomussTextCopyWith<$R, $In extends TomussText, $Out>
    implements TeachingUnitElementCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? title,
      String? author,
      DateTime? date,
      double? position,
      String? value,
      String? comment,
      bool? isValidText,
      bool? isHidden,
      String? theId});
  TomussTextCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TomussTextCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TomussText, $Out>
    implements TomussTextCopyWith<$R, TomussText, $Out> {
  _TomussTextCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TomussText> $mapper =
      TomussTextMapper.ensureInitialized();
  @override
  $R call(
          {String? title,
          String? author,
          Object? date = $none,
          double? position,
          String? value,
          String? comment,
          bool? isValidText,
          bool? isHidden,
          String? theId}) =>
      $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (author != null) #author: author,
        if (date != $none) #date: date,
        if (position != null) #position: position,
        if (value != null) #value: value,
        if (comment != null) #comment: comment,
        if (isValidText != null) #isValidText: isValidText,
        if (isHidden != null) #isHidden: isHidden,
        if (theId != null) #theId: theId
      }));
  @override
  TomussText $make(CopyWithData data) => TomussText.mappableConstruct(
      title: data.get(#title, or: $value.title),
      author: data.get(#author, or: $value.author),
      date: data.get(#date, or: $value.date),
      position: data.get(#position, or: $value.position),
      value: data.get(#value, or: $value.value),
      comment: data.get(#comment, or: $value.comment),
      isValidText: data.get(#isValidText, or: $value.isValidText),
      isHidden: data.get(#isHidden, or: $value.isHidden),
      theId: data.get(#theId, or: $value.theId));

  @override
  TomussTextCopyWith<$R2, TomussText, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TomussTextCopyWithImpl($value, $cast, t);
}
