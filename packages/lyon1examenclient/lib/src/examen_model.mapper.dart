// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
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

  static String? _$title(ExamenModel v) => v.title;
  static const Field<ExamenModel, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
    def: '',
  );
  static String _$codeName(ExamenModel v) => v.codeName;
  static const Field<ExamenModel, String> _f$codeName = Field(
    'codeName',
    _$codeName,
    opt: true,
    def: '',
  );
  static DateTime? _$date(ExamenModel v) => v.date;
  static const Field<ExamenModel, DateTime> _f$date = Field(
    'date',
    _$date,
    opt: true,
  );
  static Duration? _$duration(ExamenModel v) => v.duration;
  static const Field<ExamenModel, Duration> _f$duration = Field(
    'duration',
    _$duration,
    opt: true,
    def: const Duration(hours: 2),
  );
  static String? _$location(ExamenModel v) => v.location;
  static const Field<ExamenModel, String> _f$location = Field(
    'location',
    _$location,
    opt: true,
    def: '',
  );
  static int? _$place(ExamenModel v) => v.place;
  static const Field<ExamenModel, int> _f$place = Field(
    'place',
    _$place,
    opt: true,
    def: 0,
  );

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
      title: data.dec(_f$title),
      codeName: data.dec(_f$codeName),
      date: data.dec(_f$date),
      duration: data.dec(_f$duration),
      location: data.dec(_f$location),
      place: data.dec(_f$place),
    );
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
    return ExamenModelMapper.ensureInitialized().encodeJson<ExamenModel>(
      this as ExamenModel,
    );
  }

  Map<String, dynamic> toMap() {
    return ExamenModelMapper.ensureInitialized().encodeMap<ExamenModel>(
      this as ExamenModel,
    );
  }

  ExamenModelCopyWith<ExamenModel, ExamenModel, ExamenModel> get copyWith =>
      _ExamenModelCopyWithImpl<ExamenModel, ExamenModel>(
        this as ExamenModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ExamenModelMapper.ensureInitialized().stringifyValue(
      this as ExamenModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ExamenModelMapper.ensureInitialized().equalsValue(
      this as ExamenModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ExamenModelMapper.ensureInitialized().hashValue(this as ExamenModel);
  }
}

extension ExamenModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ExamenModel, $Out> {
  ExamenModelCopyWith<$R, ExamenModel, $Out> get $asExamenModel =>
      $base.as((v, t, t2) => _ExamenModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ExamenModelCopyWith<$R, $In extends ExamenModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? title,
    String? codeName,
    DateTime? date,
    Duration? duration,
    String? location,
    int? place,
  });
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
  $R call({
    Object? title = $none,
    String? codeName,
    Object? date = $none,
    Object? duration = $none,
    Object? location = $none,
    Object? place = $none,
  }) =>
      $apply(
        FieldCopyWithData({
          if (title != $none) #title: title,
          if (codeName != null) #codeName: codeName,
          if (date != $none) #date: date,
          if (duration != $none) #duration: duration,
          if (location != $none) #location: location,
          if (place != $none) #place: place,
        }),
      );
  @override
  ExamenModel $make(CopyWithData data) => ExamenModel(
        title: data.get(#title, or: $value.title),
        codeName: data.get(#codeName, or: $value.codeName),
        date: data.get(#date, or: $value.date),
        duration: data.get(#duration, or: $value.duration),
        location: data.get(#location, or: $value.location),
        place: data.get(#place, or: $value.place),
      );

  @override
  ExamenModelCopyWith<$R2, ExamenModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) =>
      _ExamenModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
