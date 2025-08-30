// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../home_cubit.dart';

class HomeStatusMapper extends EnumMapper<HomeStatus> {
  HomeStatusMapper._();

  static HomeStatusMapper? _instance;
  static HomeStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeStatusMapper._());
    }
    return _instance!;
  }

  static HomeStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  HomeStatus decode(dynamic value) {
    switch (value) {
      case r'initial':
        return HomeStatus.initial;
      case r'updateScreen':
        return HomeStatus.updateScreen;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(HomeStatus self) {
    switch (self) {
      case HomeStatus.initial:
        return r'initial';
      case HomeStatus.updateScreen:
        return r'updateScreen';
    }
  }
}

extension HomeStatusMapperExtension on HomeStatus {
  String toValue() {
    HomeStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<HomeStatus>(this) as String;
  }
}

class HomeStateMapper extends ClassMapperBase<HomeState> {
  HomeStateMapper._();

  static HomeStateMapper? _instance;
  static HomeStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeStateMapper._());
      HomeStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeState';

  static HomeStatus _$status(HomeState v) => v.status;
  static const Field<HomeState, HomeStatus> _f$status = Field(
    'status',
    _$status,
  );
  static int _$selectedIndex(HomeState v) => v.selectedIndex;
  static const Field<HomeState, int> _f$selectedIndex = Field(
    'selectedIndex',
    _$selectedIndex,
    opt: true,
    def: 0,
  );
  static bool _$showSecondaryScreens(HomeState v) => v.showSecondaryScreens;
  static const Field<HomeState, bool> _f$showSecondaryScreens = Field(
    'showSecondaryScreens',
    _$showSecondaryScreens,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<HomeState> fields = const {
    #status: _f$status,
    #selectedIndex: _f$selectedIndex,
    #showSecondaryScreens: _f$showSecondaryScreens,
  };

  static HomeState _instantiate(DecodingData data) {
    return HomeState(
      status: data.dec(_f$status),
      selectedIndex: data.dec(_f$selectedIndex),
      showSecondaryScreens: data.dec(_f$showSecondaryScreens),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HomeState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeState>(map);
  }

  static HomeState fromJson(String json) {
    return ensureInitialized().decodeJson<HomeState>(json);
  }
}

mixin HomeStateMappable {
  String toJson() {
    return HomeStateMapper.ensureInitialized().encodeJson<HomeState>(
      this as HomeState,
    );
  }

  Map<String, dynamic> toMap() {
    return HomeStateMapper.ensureInitialized().encodeMap<HomeState>(
      this as HomeState,
    );
  }

  HomeStateCopyWith<HomeState, HomeState, HomeState> get copyWith =>
      _HomeStateCopyWithImpl<HomeState, HomeState>(
        this as HomeState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HomeStateMapper.ensureInitialized().stringifyValue(
      this as HomeState,
    );
  }

  @override
  bool operator ==(Object other) {
    return HomeStateMapper.ensureInitialized().equalsValue(
      this as HomeState,
      other,
    );
  }

  @override
  int get hashCode {
    return HomeStateMapper.ensureInitialized().hashValue(this as HomeState);
  }
}

extension HomeStateValueCopy<$R, $Out> on ObjectCopyWith<$R, HomeState, $Out> {
  HomeStateCopyWith<$R, HomeState, $Out> get $asHomeState =>
      $base.as((v, t, t2) => _HomeStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HomeStateCopyWith<$R, $In extends HomeState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({HomeStatus? status, int? selectedIndex, bool? showSecondaryScreens});
  HomeStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HomeStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeState, $Out>
    implements HomeStateCopyWith<$R, HomeState, $Out> {
  _HomeStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeState> $mapper =
      HomeStateMapper.ensureInitialized();
  @override
  $R call({
    HomeStatus? status,
    int? selectedIndex,
    bool? showSecondaryScreens,
  }) => $apply(
    FieldCopyWithData({
      if (status != null) #status: status,
      if (selectedIndex != null) #selectedIndex: selectedIndex,
      if (showSecondaryScreens != null)
        #showSecondaryScreens: showSecondaryScreens,
    }),
  );
  @override
  HomeState $make(CopyWithData data) => HomeState(
    status: data.get(#status, or: $value.status),
    selectedIndex: data.get(#selectedIndex, or: $value.selectedIndex),
    showSecondaryScreens: data.get(
      #showSecondaryScreens,
      or: $value.showSecondaryScreens,
    ),
  );

  @override
  HomeStateCopyWith<$R2, HomeState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HomeStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

