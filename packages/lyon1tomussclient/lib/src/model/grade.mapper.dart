// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'grade.dart';

class GradeMapper extends SubClassMapperBase<Grade> {
  GradeMapper._();

  static GradeMapper? _instance;
  static GradeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GradeMapper._());
      TeachingUnitElementMapper.ensureInitialized().addSubMapper(_instance!);
      GradeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Grade';

  static String _$title(Grade v) => v.title;
  static const Field<Grade, String> _f$title =
      Field('title', _$title, opt: true, def: "");
  static String _$author(Grade v) => v.author;
  static const Field<Grade, String> _f$author =
      Field('author', _$author, opt: true, def: "");
  static DateTime? _$date(Grade v) => v.date;
  static const Field<Grade, DateTime> _f$date =
      Field('date', _$date, opt: true);
  static double _$position(Grade v) => v.position;
  static const Field<Grade, double> _f$position =
      Field('position', _$position, opt: true, def: 0);
  static double _$numerator(Grade v) => v.numerator;
  static const Field<Grade, double> _f$numerator =
      Field('numerator', _$numerator, opt: true, def: 0.0);
  static double _$denominator(Grade v) => v.denominator;
  static const Field<Grade, double> _f$denominator =
      Field('denominator', _$denominator, opt: true, def: 20.0);
  static int _$rank(Grade v) => v.rank;
  static const Field<Grade, int> _f$rank =
      Field('rank', _$rank, opt: true, def: -1);
  static double _$average(Grade v) => v.average;
  static const Field<Grade, double> _f$average =
      Field('average', _$average, opt: true, def: 10.0);
  static double _$mediane(Grade v) => v.mediane;
  static const Field<Grade, double> _f$mediane =
      Field('mediane', _$mediane, opt: true, def: 10.0);
  static bool _$isValid(Grade v) => v.isValid;
  static const Field<Grade, bool> _f$isValid =
      Field('isValid', _$isValid, opt: true, def: false);
  static int _$groupeSize(Grade v) => v.groupeSize;
  static const Field<Grade, int> _f$groupeSize =
      Field('groupeSize', _$groupeSize, opt: true, def: -1);
  static List<Grade> _$children(Grade v) => v.children;
  static const Field<Grade, List<Grade>> _f$children =
      Field('children', _$children, opt: true, def: const []);
  static double _$coef(Grade v) => v.coef;
  static const Field<Grade, double> _f$coef =
      Field('coef', _$coef, opt: true, def: 1.0);

  @override
  final Map<Symbol, Field<Grade, dynamic>> fields = const {
    #title: _f$title,
    #author: _f$author,
    #date: _f$date,
    #position: _f$position,
    #numerator: _f$numerator,
    #denominator: _f$denominator,
    #rank: _f$rank,
    #average: _f$average,
    #mediane: _f$mediane,
    #isValid: _f$isValid,
    #groupeSize: _f$groupeSize,
    #children: _f$children,
    #coef: _f$coef,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'Grade';
  @override
  late final ClassMapperBase superMapper =
      TeachingUnitElementMapper.ensureInitialized();

  static Grade _instantiate(DecodingData data) {
    return Grade.mappableConstruct(
        title: data.dec(_f$title),
        author: data.dec(_f$author),
        date: data.dec(_f$date),
        position: data.dec(_f$position),
        numerator: data.dec(_f$numerator),
        denominator: data.dec(_f$denominator),
        rank: data.dec(_f$rank),
        average: data.dec(_f$average),
        mediane: data.dec(_f$mediane),
        isValid: data.dec(_f$isValid),
        groupeSize: data.dec(_f$groupeSize),
        children: data.dec(_f$children),
        coef: data.dec(_f$coef));
  }

  @override
  final Function instantiate = _instantiate;

  static Grade fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Grade>(map);
  }

  static Grade fromJson(String json) {
    return ensureInitialized().decodeJson<Grade>(json);
  }
}

mixin GradeMappable {
  String toJson() {
    return GradeMapper.ensureInitialized().encodeJson<Grade>(this as Grade);
  }

  Map<String, dynamic> toMap() {
    return GradeMapper.ensureInitialized().encodeMap<Grade>(this as Grade);
  }

  GradeCopyWith<Grade, Grade, Grade> get copyWith =>
      _GradeCopyWithImpl(this as Grade, $identity, $identity);
  @override
  String toString() {
    return GradeMapper.ensureInitialized().stringifyValue(this as Grade);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            GradeMapper.ensureInitialized().isValueEqual(this as Grade, other));
  }

  @override
  int get hashCode {
    return GradeMapper.ensureInitialized().hashValue(this as Grade);
  }
}

extension GradeValueCopy<$R, $Out> on ObjectCopyWith<$R, Grade, $Out> {
  GradeCopyWith<$R, Grade, $Out> get $asGrade =>
      $base.as((v, t, t2) => _GradeCopyWithImpl(v, t, t2));
}

abstract class GradeCopyWith<$R, $In extends Grade, $Out>
    implements TeachingUnitElementCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Grade, GradeCopyWith<$R, Grade, Grade>> get children;
  @override
  $R call(
      {String? title,
      String? author,
      DateTime? date,
      double? position,
      double? numerator,
      double? denominator,
      int? rank,
      double? average,
      double? mediane,
      bool? isValid,
      int? groupeSize,
      List<Grade>? children,
      double? coef});
  GradeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GradeCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Grade, $Out>
    implements GradeCopyWith<$R, Grade, $Out> {
  _GradeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Grade> $mapper = GradeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Grade, GradeCopyWith<$R, Grade, Grade>> get children =>
      ListCopyWith($value.children, (v, t) => v.copyWith.$chain(t),
          (v) => call(children: v));
  @override
  $R call(
          {String? title,
          String? author,
          Object? date = $none,
          double? position,
          double? numerator,
          double? denominator,
          int? rank,
          double? average,
          double? mediane,
          bool? isValid,
          int? groupeSize,
          List<Grade>? children,
          double? coef}) =>
      $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (author != null) #author: author,
        if (date != $none) #date: date,
        if (position != null) #position: position,
        if (numerator != null) #numerator: numerator,
        if (denominator != null) #denominator: denominator,
        if (rank != null) #rank: rank,
        if (average != null) #average: average,
        if (mediane != null) #mediane: mediane,
        if (isValid != null) #isValid: isValid,
        if (groupeSize != null) #groupeSize: groupeSize,
        if (children != null) #children: children,
        if (coef != null) #coef: coef
      }));
  @override
  Grade $make(CopyWithData data) => Grade.mappableConstruct(
      title: data.get(#title, or: $value.title),
      author: data.get(#author, or: $value.author),
      date: data.get(#date, or: $value.date),
      position: data.get(#position, or: $value.position),
      numerator: data.get(#numerator, or: $value.numerator),
      denominator: data.get(#denominator, or: $value.denominator),
      rank: data.get(#rank, or: $value.rank),
      average: data.get(#average, or: $value.average),
      mediane: data.get(#mediane, or: $value.mediane),
      isValid: data.get(#isValid, or: $value.isValid),
      groupeSize: data.get(#groupeSize, or: $value.groupeSize),
      children: data.get(#children, or: $value.children),
      coef: data.get(#coef, or: $value.coef));

  @override
  GradeCopyWith<$R2, Grade, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GradeCopyWithImpl($value, $cast, t);
}
