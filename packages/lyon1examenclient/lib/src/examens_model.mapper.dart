// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'examens_model.dart';

class ExamensModelMapper extends ClassMapperBase<ExamensModel> {
  ExamensModelMapper._();

  static ExamensModelMapper? _instance;
  static ExamensModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExamensModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ExamensModel';

  static String _$title(ExamensModel v) => v.title;
  static const Field<ExamensModel, String> _f$title = Field('title', _$title);
  static String _$codeName(ExamensModel v) => v.codeName;
  static const Field<ExamensModel, String> _f$codeName =
      Field('codeName', _$codeName);
  static DateTime _$date(ExamensModel v) => v.date;
  static const Field<ExamensModel, DateTime> _f$date = Field('date', _$date);
  static Duration _$duration(ExamensModel v) => v.duration;
  static const Field<ExamensModel, Duration> _f$duration =
      Field('duration', _$duration);
  static String _$location(ExamensModel v) => v.location;
  static const Field<ExamensModel, String> _f$location =
      Field('location', _$location);
  static int _$place(ExamensModel v) => v.place;
  static const Field<ExamensModel, int> _f$place = Field('place', _$place);

  @override
  final MappableFields<ExamensModel> fields = const {
    #title: _f$title,
    #codeName: _f$codeName,
    #date: _f$date,
    #duration: _f$duration,
    #location: _f$location,
    #place: _f$place,
  };

  static ExamensModel _instantiate(DecodingData data) {
    return ExamensModel(
        data.dec(_f$title),
        data.dec(_f$codeName),
        data.dec(_f$date),
        data.dec(_f$duration),
        data.dec(_f$location),
        data.dec(_f$place));
  }

  @override
  final Function instantiate = _instantiate;

  static ExamensModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ExamensModel>(map);
  }

  static ExamensModel fromJson(String json) {
    return ensureInitialized().decodeJson<ExamensModel>(json);
  }
}

mixin ExamensModelMappable {
  String toJson() {
    return ExamensModelMapper.ensureInitialized()
        .encodeJson<ExamensModel>(this as ExamensModel);
  }

  Map<String, dynamic> toMap() {
    return ExamensModelMapper.ensureInitialized()
        .encodeMap<ExamensModel>(this as ExamensModel);
  }

  ExamensModelCopyWith<ExamensModel, ExamensModel, ExamensModel> get copyWith =>
      _ExamensModelCopyWithImpl(this as ExamensModel, $identity, $identity);
  @override
  String toString() {
    return ExamensModelMapper.ensureInitialized()
        .stringifyValue(this as ExamensModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ExamensModelMapper.ensureInitialized()
                .isValueEqual(this as ExamensModel, other));
  }

  @override
  int get hashCode {
    return ExamensModelMapper.ensureInitialized()
        .hashValue(this as ExamensModel);
  }
}

extension ExamensModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ExamensModel, $Out> {
  ExamensModelCopyWith<$R, ExamensModel, $Out> get $asExamensModel =>
      $base.as((v, t, t2) => _ExamensModelCopyWithImpl(v, t, t2));
}

abstract class ExamensModelCopyWith<$R, $In extends ExamensModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? title,
      String? codeName,
      DateTime? date,
      Duration? duration,
      String? location,
      int? place});
  ExamensModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ExamensModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ExamensModel, $Out>
    implements ExamensModelCopyWith<$R, ExamensModel, $Out> {
  _ExamensModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ExamensModel> $mapper =
      ExamensModelMapper.ensureInitialized();
  @override
  $R call(
          {String? title,
          String? codeName,
          DateTime? date,
          Duration? duration,
          String? location,
          int? place}) =>
      $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (codeName != null) #codeName: codeName,
        if (date != null) #date: date,
        if (duration != null) #duration: duration,
        if (location != null) #location: location,
        if (place != null) #place: place
      }));
  @override
  ExamensModel $make(CopyWithData data) => ExamensModel(
      data.get(#title, or: $value.title),
      data.get(#codeName, or: $value.codeName),
      data.get(#date, or: $value.date),
      data.get(#duration, or: $value.duration),
      data.get(#location, or: $value.location),
      data.get(#place, or: $value.place));

  @override
  ExamensModelCopyWith<$R2, ExamensModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ExamensModelCopyWithImpl($value, $cast, t);
}
