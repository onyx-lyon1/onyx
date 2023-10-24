// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'menu_crous.dart';

class MenuTypeMapper extends EnumMapper<MenuType> {
  MenuTypeMapper._();

  static MenuTypeMapper? _instance;
  static MenuTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MenuTypeMapper._());
    }
    return _instance!;
  }

  static MenuType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  MenuType decode(dynamic value) {
    switch (value) {
      case 000:
        return MenuType.matin;
      case 100:
        return MenuType.midi;
      case 200:
        return MenuType.soir;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(MenuType self) {
    switch (self) {
      case MenuType.matin:
        return 000;
      case MenuType.midi:
        return 100;
      case MenuType.soir:
        return 200;
    }
  }
}

extension MenuTypeMapperExtension on MenuType {
  dynamic toValue() {
    MenuTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<MenuType>(this);
  }
}

class MenuCrousMapper extends ClassMapperBase<MenuCrous> {
  MenuCrousMapper._();

  static MenuCrousMapper? _instance;
  static MenuCrousMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MenuCrousMapper._());
      MenuTypeMapper.ensureInitialized();
      PlatCrousMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MenuCrous';

  static DateTime _$date(MenuCrous v) => v.date;
  static const Field<MenuCrous, DateTime> _f$date = Field('date', _$date);
  static MenuType _$type(MenuCrous v) => v.type;
  static const Field<MenuCrous, MenuType> _f$type = Field('type', _$type);
  static List<PlatCrous> _$plats(MenuCrous v) => v.plats;
  static const Field<MenuCrous, List<PlatCrous>> _f$plats =
      Field('plats', _$plats);

  @override
  final Map<Symbol, Field<MenuCrous, dynamic>> fields = const {
    #date: _f$date,
    #type: _f$type,
    #plats: _f$plats,
  };

  static MenuCrous _instantiate(DecodingData data) {
    return MenuCrous(
        date: data.dec(_f$date),
        type: data.dec(_f$type),
        plats: data.dec(_f$plats));
  }

  @override
  final Function instantiate = _instantiate;

  static MenuCrous fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MenuCrous>(map);
  }

  static MenuCrous fromJson(String json) {
    return ensureInitialized().decodeJson<MenuCrous>(json);
  }
}

mixin MenuCrousMappable {
  String toJson() {
    return MenuCrousMapper.ensureInitialized()
        .encodeJson<MenuCrous>(this as MenuCrous);
  }

  Map<String, dynamic> toMap() {
    return MenuCrousMapper.ensureInitialized()
        .encodeMap<MenuCrous>(this as MenuCrous);
  }

  MenuCrousCopyWith<MenuCrous, MenuCrous, MenuCrous> get copyWith =>
      _MenuCrousCopyWithImpl(this as MenuCrous, $identity, $identity);
  @override
  String toString() {
    return MenuCrousMapper.ensureInitialized()
        .stringifyValue(this as MenuCrous);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MenuCrousMapper.ensureInitialized()
                .isValueEqual(this as MenuCrous, other));
  }

  @override
  int get hashCode {
    return MenuCrousMapper.ensureInitialized().hashValue(this as MenuCrous);
  }
}

extension MenuCrousValueCopy<$R, $Out> on ObjectCopyWith<$R, MenuCrous, $Out> {
  MenuCrousCopyWith<$R, MenuCrous, $Out> get $asMenuCrous =>
      $base.as((v, t, t2) => _MenuCrousCopyWithImpl(v, t, t2));
}

abstract class MenuCrousCopyWith<$R, $In extends MenuCrous, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, PlatCrous, PlatCrousCopyWith<$R, PlatCrous, PlatCrous>>
      get plats;
  $R call({DateTime? date, MenuType? type, List<PlatCrous>? plats});
  MenuCrousCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MenuCrousCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MenuCrous, $Out>
    implements MenuCrousCopyWith<$R, MenuCrous, $Out> {
  _MenuCrousCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MenuCrous> $mapper =
      MenuCrousMapper.ensureInitialized();
  @override
  ListCopyWith<$R, PlatCrous, PlatCrousCopyWith<$R, PlatCrous, PlatCrous>>
      get plats => ListCopyWith(
          $value.plats, (v, t) => v.copyWith.$chain(t), (v) => call(plats: v));
  @override
  $R call({DateTime? date, MenuType? type, List<PlatCrous>? plats}) =>
      $apply(FieldCopyWithData({
        if (date != null) #date: date,
        if (type != null) #type: type,
        if (plats != null) #plats: plats
      }));
  @override
  MenuCrous $make(CopyWithData data) => MenuCrous(
      date: data.get(#date, or: $value.date),
      type: data.get(#type, or: $value.type),
      plats: data.get(#plats, or: $value.plats));

  @override
  MenuCrousCopyWith<$R2, MenuCrous, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MenuCrousCopyWithImpl($value, $cast, t);
}

class PlatCrousMapper extends ClassMapperBase<PlatCrous> {
  PlatCrousMapper._();

  static PlatCrousMapper? _instance;
  static PlatCrousMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlatCrousMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PlatCrous';

  static String _$name(PlatCrous v) => v.name;
  static const Field<PlatCrous, String> _f$name = Field('name', _$name);
  static List<String> _$variants(PlatCrous v) => v.variants;
  static const Field<PlatCrous, List<String>> _f$variants =
      Field('variants', _$variants);

  @override
  final Map<Symbol, Field<PlatCrous, dynamic>> fields = const {
    #name: _f$name,
    #variants: _f$variants,
  };

  static PlatCrous _instantiate(DecodingData data) {
    return PlatCrous(name: data.dec(_f$name), variants: data.dec(_f$variants));
  }

  @override
  final Function instantiate = _instantiate;

  static PlatCrous fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PlatCrous>(map);
  }

  static PlatCrous fromJson(String json) {
    return ensureInitialized().decodeJson<PlatCrous>(json);
  }
}

mixin PlatCrousMappable {
  String toJson() {
    return PlatCrousMapper.ensureInitialized()
        .encodeJson<PlatCrous>(this as PlatCrous);
  }

  Map<String, dynamic> toMap() {
    return PlatCrousMapper.ensureInitialized()
        .encodeMap<PlatCrous>(this as PlatCrous);
  }

  PlatCrousCopyWith<PlatCrous, PlatCrous, PlatCrous> get copyWith =>
      _PlatCrousCopyWithImpl(this as PlatCrous, $identity, $identity);
  @override
  String toString() {
    return PlatCrousMapper.ensureInitialized()
        .stringifyValue(this as PlatCrous);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            PlatCrousMapper.ensureInitialized()
                .isValueEqual(this as PlatCrous, other));
  }

  @override
  int get hashCode {
    return PlatCrousMapper.ensureInitialized().hashValue(this as PlatCrous);
  }
}

extension PlatCrousValueCopy<$R, $Out> on ObjectCopyWith<$R, PlatCrous, $Out> {
  PlatCrousCopyWith<$R, PlatCrous, $Out> get $asPlatCrous =>
      $base.as((v, t, t2) => _PlatCrousCopyWithImpl(v, t, t2));
}

abstract class PlatCrousCopyWith<$R, $In extends PlatCrous, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get variants;
  $R call({String? name, List<String>? variants});
  PlatCrousCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PlatCrousCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PlatCrous, $Out>
    implements PlatCrousCopyWith<$R, PlatCrous, $Out> {
  _PlatCrousCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PlatCrous> $mapper =
      PlatCrousMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get variants =>
      ListCopyWith($value.variants, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(variants: v));
  @override
  $R call({String? name, List<String>? variants}) => $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (variants != null) #variants: variants
      }));
  @override
  PlatCrous $make(CopyWithData data) => PlatCrous(
      name: data.get(#name, or: $value.name),
      variants: data.get(#variants, or: $value.variants));

  @override
  PlatCrousCopyWith<$R2, PlatCrous, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PlatCrousCopyWithImpl($value, $cast, t);
}
