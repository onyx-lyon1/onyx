// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../theme_settings_model.dart';

class ThemeSettingsModelMapper extends ClassMapperBase<ThemeSettingsModel> {
  ThemeSettingsModelMapper._();

  static ThemeSettingsModelMapper? _instance;
  static ThemeSettingsModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ThemeSettingsModelMapper._());
      ThemeModeEnumMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ThemeSettingsModel';

  static String _$darkThemeSelected(ThemeSettingsModel v) =>
      v.darkThemeSelected;
  static const Field<ThemeSettingsModel, String> _f$darkThemeSelected = Field(
    'darkThemeSelected',
    _$darkThemeSelected,
    opt: true,
    def: 'Dark Default',
  );
  static String _$lightThemeSelected(ThemeSettingsModel v) =>
      v.lightThemeSelected;
  static const Field<ThemeSettingsModel, String> _f$lightThemeSelected = Field(
    'lightThemeSelected',
    _$lightThemeSelected,
    opt: true,
    def: 'Light Default',
  );
  static ThemeModeEnum _$themeMode(ThemeSettingsModel v) => v.themeMode;
  static const Field<ThemeSettingsModel, ThemeModeEnum> _f$themeMode = Field(
    'themeMode',
    _$themeMode,
    opt: true,
    def: ThemeModeEnum.system,
  );
  static bool _$autoSwitchTheme(ThemeSettingsModel v) => v.autoSwitchTheme;
  static const Field<ThemeSettingsModel, bool> _f$autoSwitchTheme = Field(
    'autoSwitchTheme',
    _$autoSwitchTheme,
    opt: true,
    def: true,
  );
  static String _$themesCreatedString(ThemeSettingsModel v) =>
      v.themesCreatedString;
  static const Field<ThemeSettingsModel, String> _f$themesCreatedString = Field(
    'themesCreatedString',
    _$themesCreatedString,
    opt: true,
  );
  static String _$favoriteThemesString(ThemeSettingsModel v) =>
      v.favoriteThemesString;
  static const Field<ThemeSettingsModel, String> _f$favoriteThemesString =
      Field('favoriteThemesString', _$favoriteThemesString, opt: true);
  static List<ThemeModel> _$lightThemesCreated(ThemeSettingsModel v) =>
      v.lightThemesCreated;
  static const Field<ThemeSettingsModel, List<ThemeModel>>
  _f$lightThemesCreated = Field(
    'lightThemesCreated',
    _$lightThemesCreated,
    mode: FieldMode.member,
  );
  static List<ThemeModel> _$darkThemesCreated(ThemeSettingsModel v) =>
      v.darkThemesCreated;
  static const Field<ThemeSettingsModel, List<ThemeModel>>
  _f$darkThemesCreated = Field(
    'darkThemesCreated',
    _$darkThemesCreated,
    mode: FieldMode.member,
  );
  static List<ThemeModel> _$lightThemesPreset(ThemeSettingsModel v) =>
      v.lightThemesPreset;
  static const Field<ThemeSettingsModel, List<ThemeModel>>
  _f$lightThemesPreset = Field(
    'lightThemesPreset',
    _$lightThemesPreset,
    mode: FieldMode.member,
  );
  static List<ThemeModel> _$darkThemesPreset(ThemeSettingsModel v) =>
      v.darkThemesPreset;
  static const Field<ThemeSettingsModel, List<ThemeModel>> _f$darkThemesPreset =
      Field('darkThemesPreset', _$darkThemesPreset, mode: FieldMode.member);

  @override
  final MappableFields<ThemeSettingsModel> fields = const {
    #darkThemeSelected: _f$darkThemeSelected,
    #lightThemeSelected: _f$lightThemeSelected,
    #themeMode: _f$themeMode,
    #autoSwitchTheme: _f$autoSwitchTheme,
    #themesCreatedString: _f$themesCreatedString,
    #favoriteThemesString: _f$favoriteThemesString,
    #lightThemesCreated: _f$lightThemesCreated,
    #darkThemesCreated: _f$darkThemesCreated,
    #lightThemesPreset: _f$lightThemesPreset,
    #darkThemesPreset: _f$darkThemesPreset,
  };
  @override
  final Iterable<String> ignore = const [
    'themesCreated',
    'favoriteThemes',
    'themesPreset',
  ];

  static ThemeSettingsModel _instantiate(DecodingData data) {
    return ThemeSettingsModel(
      darkThemeSelected: data.dec(_f$darkThemeSelected),
      lightThemeSelected: data.dec(_f$lightThemeSelected),
      themeMode: data.dec(_f$themeMode),
      autoSwitchTheme: data.dec(_f$autoSwitchTheme),
      themesCreatedString: data.dec(_f$themesCreatedString),
      favoriteThemesString: data.dec(_f$favoriteThemesString),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ThemeSettingsModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ThemeSettingsModel>(map);
  }

  static ThemeSettingsModel fromJson(String json) {
    return ensureInitialized().decodeJson<ThemeSettingsModel>(json);
  }
}

mixin ThemeSettingsModelMappable {
  String toJson() {
    return ThemeSettingsModelMapper.ensureInitialized()
        .encodeJson<ThemeSettingsModel>(this as ThemeSettingsModel);
  }

  Map<String, dynamic> toMap() {
    return ThemeSettingsModelMapper.ensureInitialized()
        .encodeMap<ThemeSettingsModel>(this as ThemeSettingsModel);
  }

  ThemeSettingsModelCopyWith<
    ThemeSettingsModel,
    ThemeSettingsModel,
    ThemeSettingsModel
  >
  get copyWith =>
      _ThemeSettingsModelCopyWithImpl<ThemeSettingsModel, ThemeSettingsModel>(
        this as ThemeSettingsModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ThemeSettingsModelMapper.ensureInitialized().stringifyValue(
      this as ThemeSettingsModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ThemeSettingsModelMapper.ensureInitialized().equalsValue(
      this as ThemeSettingsModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ThemeSettingsModelMapper.ensureInitialized().hashValue(
      this as ThemeSettingsModel,
    );
  }
}

extension ThemeSettingsModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ThemeSettingsModel, $Out> {
  ThemeSettingsModelCopyWith<$R, ThemeSettingsModel, $Out>
  get $asThemeSettingsModel => $base.as(
    (v, t, t2) => _ThemeSettingsModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ThemeSettingsModelCopyWith<
  $R,
  $In extends ThemeSettingsModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ThemeModel, ObjectCopyWith<$R, ThemeModel, ThemeModel>>
  get themesCreated;
  ListCopyWith<$R, ThemeModel, ObjectCopyWith<$R, ThemeModel, ThemeModel>>
  get favoriteThemes;
  $R call({
    List<ThemeModel>? themesCreated,
    String? darkThemeSelected,
    String? lightThemeSelected,
    List<ThemeModel>? favoriteThemes,
    ThemeModeEnum? themeMode,
    bool? autoSwitchTheme,
    String? themesCreatedString,
    String? favoriteThemesString,
  });
  ThemeSettingsModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ThemeSettingsModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ThemeSettingsModel, $Out>
    implements ThemeSettingsModelCopyWith<$R, ThemeSettingsModel, $Out> {
  _ThemeSettingsModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ThemeSettingsModel> $mapper =
      ThemeSettingsModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ThemeModel, ObjectCopyWith<$R, ThemeModel, ThemeModel>>
  get themesCreated => ListCopyWith(
    $value.themesCreated,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(themesCreated: v),
  );
  @override
  ListCopyWith<$R, ThemeModel, ObjectCopyWith<$R, ThemeModel, ThemeModel>>
  get favoriteThemes => ListCopyWith(
    $value.favoriteThemes,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(favoriteThemes: v),
  );
  @override
  $R call({
    List<ThemeModel>? themesCreated,
    String? darkThemeSelected,
    String? lightThemeSelected,
    List<ThemeModel>? favoriteThemes,
    ThemeModeEnum? themeMode,
    bool? autoSwitchTheme,
    Object? themesCreatedString = $none,
    Object? favoriteThemesString = $none,
  }) => $apply(
    FieldCopyWithData({
      if (themesCreated != null) #themesCreated: themesCreated,
      if (darkThemeSelected != null) #darkThemeSelected: darkThemeSelected,
      if (lightThemeSelected != null) #lightThemeSelected: lightThemeSelected,
      if (favoriteThemes != null) #favoriteThemes: favoriteThemes,
      if (themeMode != null) #themeMode: themeMode,
      if (autoSwitchTheme != null) #autoSwitchTheme: autoSwitchTheme,
      if (themesCreatedString != $none)
        #themesCreatedString: themesCreatedString,
      if (favoriteThemesString != $none)
        #favoriteThemesString: favoriteThemesString,
    }),
  );
  @override
  ThemeSettingsModel $make(CopyWithData data) => ThemeSettingsModel(
    themesCreated: data.get(#themesCreated, or: $value.themesCreated),
    darkThemeSelected: data.get(
      #darkThemeSelected,
      or: $value.darkThemeSelected,
    ),
    lightThemeSelected: data.get(
      #lightThemeSelected,
      or: $value.lightThemeSelected,
    ),
    favoriteThemes: data.get(#favoriteThemes, or: $value.favoriteThemes),
    themeMode: data.get(#themeMode, or: $value.themeMode),
    autoSwitchTheme: data.get(#autoSwitchTheme, or: $value.autoSwitchTheme),
    themesCreatedString: data.get(
      #themesCreatedString,
      or: $value.themesCreatedString,
    ),
    favoriteThemesString: data.get(
      #favoriteThemesString,
      or: $value.favoriteThemesString,
    ),
  );

  @override
  ThemeSettingsModelCopyWith<$R2, ThemeSettingsModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ThemeSettingsModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

