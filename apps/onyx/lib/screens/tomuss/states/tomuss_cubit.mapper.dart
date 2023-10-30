// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'tomuss_cubit.dart';

class TomussStatusMapper extends EnumMapper<TomussStatus> {
  TomussStatusMapper._();

  static TomussStatusMapper? _instance;
  static TomussStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TomussStatusMapper._());
    }
    return _instance!;
  }

  static TomussStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TomussStatus decode(dynamic value) {
    switch (value) {
      case 000:
        return TomussStatus.initial;
      case 100:
        return TomussStatus.loading;
      case 200:
        return TomussStatus.cacheReady;
      case 300:
        return TomussStatus.ready;
      case 400:
        return TomussStatus.error;
      case 500:
        return TomussStatus.updated;
      case 600:
        return TomussStatus.timeout;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TomussStatus self) {
    switch (self) {
      case TomussStatus.initial:
        return 000;
      case TomussStatus.loading:
        return 100;
      case TomussStatus.cacheReady:
        return 200;
      case TomussStatus.ready:
        return 300;
      case TomussStatus.error:
        return 400;
      case TomussStatus.updated:
        return 500;
      case TomussStatus.timeout:
        return 600;
    }
  }
}

extension TomussStatusMapperExtension on TomussStatus {
  dynamic toValue() {
    TomussStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TomussStatus>(this);
  }
}

class TomussStateMapper extends ClassMapperBase<TomussState> {
  TomussStateMapper._();

  static TomussStateMapper? _instance;
  static TomussStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TomussStateMapper._());
      TomussStatusMapper.ensureInitialized();
      SemesterMapper.ensureInitialized();
      _t$_R0Mapper.ensureInitialized();
      TeachingUnitMapper.ensureInitialized();
      TeachingUnitElementMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TomussState';

  static TomussStatus _$status(TomussState v) => v.status;
  static const Field<TomussState, TomussStatus> _f$status =
      Field('status', _$status, opt: true, def: TomussStatus.initial);
  static List<Semester> _$semesters(TomussState v) => v.semesters;
  static const Field<TomussState, List<Semester>> _f$semesters =
      Field('semesters', _$semesters, opt: true, def: const []);
  static int _$currentSemesterIndex(TomussState v) => v.currentSemesterIndex;
  static const Field<TomussState, int> _f$currentSemesterIndex =
      Field('currentSemesterIndex', _$currentSemesterIndex, opt: true, def: 0);
  static Duration? _$timeout(TomussState v) => v.timeout;
  static const Field<TomussState, Duration> _f$timeout =
      Field('timeout', _$timeout, opt: true);
  static List<_t$_R0<TeachingUnit, TeachingUnitElement>> _$newElements(
          TomussState v) =>
      v.newElements;
  static const Field<TomussState,
          List<_t$_R0<TeachingUnit, TeachingUnitElement>>> _f$newElements =
      Field('newElements', _$newElements, opt: true, def: const []);

  @override
  final Map<Symbol, Field<TomussState, dynamic>> fields = const {
    #status: _f$status,
    #semesters: _f$semesters,
    #currentSemesterIndex: _f$currentSemesterIndex,
    #timeout: _f$timeout,
    #newElements: _f$newElements,
  };

  static TomussState _instantiate(DecodingData data) {
    return TomussState(
        status: data.dec(_f$status),
        semesters: data.dec(_f$semesters),
        currentSemesterIndex: data.dec(_f$currentSemesterIndex),
        timeout: data.dec(_f$timeout),
        newElements: data.dec(_f$newElements));
  }

  @override
  final Function instantiate = _instantiate;

  static TomussState fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TomussState>(map);
  }

  static TomussState deserialize(String json) {
    return ensureInitialized().decodeJson<TomussState>(json);
  }
}

mixin TomussStateMappable {
  String serialize() {
    return TomussStateMapper.ensureInitialized()
        .encodeJson<TomussState>(this as TomussState);
  }

  Map<String, dynamic> toJson() {
    return TomussStateMapper.ensureInitialized()
        .encodeMap<TomussState>(this as TomussState);
  }

  TomussStateCopyWith<TomussState, TomussState, TomussState> get copyWith =>
      _TomussStateCopyWithImpl(this as TomussState, $identity, $identity);
  @override
  String toString() {
    return TomussStateMapper.ensureInitialized()
        .stringifyValue(this as TomussState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TomussStateMapper.ensureInitialized()
                .isValueEqual(this as TomussState, other));
  }

  @override
  int get hashCode {
    return TomussStateMapper.ensureInitialized().hashValue(this as TomussState);
  }
}

extension TomussStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TomussState, $Out> {
  TomussStateCopyWith<$R, TomussState, $Out> get $asTomussState =>
      $base.as((v, t, t2) => _TomussStateCopyWithImpl(v, t, t2));
}

abstract class TomussStateCopyWith<$R, $In extends TomussState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Semester, SemesterCopyWith<$R, Semester, Semester>>
      get semesters;
  ListCopyWith<
      $R,
      _t$_R0<TeachingUnit, TeachingUnitElement>,
      ObjectCopyWith<$R, _t$_R0<TeachingUnit, TeachingUnitElement>,
          _t$_R0<TeachingUnit, TeachingUnitElement>>> get newElements;
  $R call(
      {TomussStatus? status,
      List<Semester>? semesters,
      int? currentSemesterIndex,
      Duration? timeout,
      List<_t$_R0<TeachingUnit, TeachingUnitElement>>? newElements});
  TomussStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TomussStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TomussState, $Out>
    implements TomussStateCopyWith<$R, TomussState, $Out> {
  _TomussStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TomussState> $mapper =
      TomussStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Semester, SemesterCopyWith<$R, Semester, Semester>>
      get semesters => ListCopyWith($value.semesters,
          (v, t) => v.copyWith.$chain(t), (v) => call(semesters: v));
  @override
  ListCopyWith<
      $R,
      _t$_R0<TeachingUnit, TeachingUnitElement>,
      ObjectCopyWith<$R, _t$_R0<TeachingUnit, TeachingUnitElement>,
          _t$_R0<TeachingUnit, TeachingUnitElement>>> get newElements =>
      ListCopyWith(
          $value.newElements,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(newElements: v));
  @override
  $R call(
          {TomussStatus? status,
          List<Semester>? semesters,
          int? currentSemesterIndex,
          Object? timeout = $none,
          List<_t$_R0<TeachingUnit, TeachingUnitElement>>? newElements}) =>
      $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (semesters != null) #semesters: semesters,
        if (currentSemesterIndex != null)
          #currentSemesterIndex: currentSemesterIndex,
        if (timeout != $none) #timeout: timeout,
        if (newElements != null) #newElements: newElements
      }));
  @override
  TomussState $make(CopyWithData data) => TomussState(
      status: data.get(#status, or: $value.status),
      semesters: data.get(#semesters, or: $value.semesters),
      currentSemesterIndex:
          data.get(#currentSemesterIndex, or: $value.currentSemesterIndex),
      timeout: data.get(#timeout, or: $value.timeout),
      newElements: data.get(#newElements, or: $value.newElements));

  @override
  TomussStateCopyWith<$R2, TomussState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TomussStateCopyWithImpl($value, $cast, t);
}

typedef _t$_R0<A, B> = ({A teachingUnit, B teachingUnitElement});

class _t$_R0Mapper extends RecordMapperBase<_t$_R0> {
  static _t$_R0Mapper? _instance;
  _t$_R0Mapper._();

  static _t$_R0Mapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = _t$_R0Mapper._());
      MapperBase.addType(
          <A, B>(f) => f<({A teachingUnit, B teachingUnitElement})>());
    }
    return _instance!;
  }

  static dynamic _$teachingUnit(_t$_R0 v) => v.teachingUnit;
  static dynamic _arg$teachingUnit<A, B>(f) => f<A>();
  static const Field<_t$_R0, dynamic> _f$teachingUnit =
      Field('teachingUnit', _$teachingUnit, arg: _arg$teachingUnit);
  static dynamic _$teachingUnitElement(_t$_R0 v) => v.teachingUnitElement;
  static dynamic _arg$teachingUnitElement<A, B>(f) => f<B>();
  static const Field<_t$_R0, dynamic> _f$teachingUnitElement = Field(
      'teachingUnitElement', _$teachingUnitElement,
      arg: _arg$teachingUnitElement);

  @override
  final Map<Symbol, Field<_t$_R0, dynamic>> fields = const {
    #teachingUnit: _f$teachingUnit,
    #teachingUnitElement: _f$teachingUnitElement,
  };

  @override
  Function get typeFactory => <A, B>(f) => f<_t$_R0<A, B>>();

  static _t$_R0<A, B> _instantiate<A, B>(DecodingData<_t$_R0> data) {
    return (
      teachingUnit: data.dec(_f$teachingUnit),
      teachingUnitElement: data.dec(_f$teachingUnitElement)
    );
  }

  @override
  final Function instantiate = _instantiate;

  static _t$_R0<A, B> fromJson<A, B>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<_t$_R0<A, B>>(map);
  }

  static _t$_R0<A, B> deserialize<A, B>(String json) {
    return ensureInitialized().decodeJson<_t$_R0<A, B>>(json);
  }
}
