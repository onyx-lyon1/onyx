// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'examen_model.dart';

class ExamenModelMapper extends ClassMapperBase<ExamenModel> {
  ExamenModelMapper._();

  static ExamenModelMapper? _instance;
  static ExamenModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExamenModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ExamenModel';

  static String _$title(ExamenModel v) => v.title;
  static const Field<ExamenModel, String> _f$title = Field('title', _$title);
  static String _$codeName(ExamenModel v) => v.codeName;
  static const Field<ExamenModel, String> _f$codeName =
      Field('codeName', _$codeName);
  static DateTime _$date(ExamenModel v) => v.date;
  static const Field<ExamenModel, DateTime> _f$date = Field('date', _$date);
  static Duration _$duration(ExamenModel v) => v.duration;
  static const Field<ExamenModel, Duration> _f$duration =
      Field('duration', _$duration);
  static String _$location(ExamenModel v) => v.location;
  static const Field<ExamenModel, String> _f$location =
      Field('location', _$location);
  static int _$place(ExamenModel v) => v.place;
  static const Field<ExamenModel, int> _f$place = Field('place', _$place);

  @override
  final MappableFields<ExamenModel> fields = const {
    #title: _f$title,
    #codeName: _f$codeName,
    #date: _f$date,
    #duration: _f$duration,
    #location: _f$location,
    #place: _f$place,
  };

  static ExamenModel _instantiate(DecodingData data) {
    return ExamenModel(
        data.dec(_f$title),
        data.dec(_f$codeName),
        data.dec(_f$date),
        data.dec(_f$duration),
        data.dec(_f$location),
        data.dec(_f$place));
  }

  @override
  final Function instantiate = _instantiate;

  static ExamenModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ExamenModel>(map);
  }

  static ExamenModel fromJson(String json) {
    return ensureInitialized().decodeJson<ExamenModel>(json);
  }
}

mixin ExamenModelMappable {
  String toJson() {
    return ExamenModelMapper.ensureInitialized()
        .encodeJson<ExamenModel>(this as ExamenModel);
  }

  Map<String, dynamic> toMap() {
    return ExamenModelMapper.ensureInitialized()
        .encodeMap<ExamenModel>(this as ExamenModel);
  }

  ExamenModelCopyWith<ExamenModel, ExamenModel, ExamenModel> get copyWith =>
      _ExamenModelCopyWithImpl(this as ExamenModel, $identity, $identity);
  @override
  String toString() {
    return ExamenModelMapper.ensureInitialized()
        .stringifyValue(this as ExamenModel);
  }

  @override
  bool operator ==(Object other) {
    return ExamenModelMapper.ensureInitialized()
        .equalsValue(this as ExamenModel, other);
  }

  @override
  int get hashCode {
    return ExamenModelMapper.ensureInitialized().hashValue(this as ExamenModel);
  }
}

extension ExamenModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ExamenModel, $Out> {
  ExamenModelCopyWith<$R, ExamenModel, $Out> get $asExamenModel =>
      $base.as((v, t, t2) => _ExamenModelCopyWithImpl(v, t, t2));
}

abstract class ExamenModelCopyWith<$R, $In extends ExamenModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? title,
      String? codeName,
      DateTime? date,
      Duration? duration,
      String? location,
      int? place});
  ExamenModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ExamenModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ExamenModel, $Out>
    implements ExamenModelCopyWith<$R, ExamenModel, $Out> {
  _ExamenModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ExamenModel> $mapper =
      ExamenModelMapper.ensureInitialized();
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
  ExamenModel $make(CopyWithData data) => ExamenModel(
      data.get(#title, or: $value.title),
      data.get(#codeName, or: $value.codeName),
      data.get(#date, or: $value.date),
      data.get(#duration, or: $value.duration),
      data.get(#location, or: $value.location),
      data.get(#place, or: $value.place));

  @override
  ExamenModelCopyWith<$R2, ExamenModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ExamenModelCopyWithImpl($value, $cast, t);
}
