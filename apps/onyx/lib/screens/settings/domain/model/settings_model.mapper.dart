// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings_model.dart';

class SettingsModelMapper extends ClassMapperBase<SettingsModel> {
  SettingsModelMapper._();

  static SettingsModelMapper? _instance;
  static SettingsModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsModelMapper._());
      ThemeModeEnumMapper.ensureInitialized();
      FunctionalitiesMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsModel';

  static bool _$biometricAuth(SettingsModel v) => v.biometricAuth;
  static const Field<SettingsModel, bool> _f$biometricAuth =
      Field('biometricAuth', _$biometricAuth, opt: true, def: false);
  static bool _$forceGreen(SettingsModel v) => v.forceGreen;
  static const Field<SettingsModel, bool> _f$forceGreen =
      Field('forceGreen', _$forceGreen, opt: true, def: false);
  static ThemeModeEnum _$themeMode(SettingsModel v) => v.themeMode;
  static const Field<SettingsModel, ThemeModeEnum> _f$themeMode =
      Field('themeMode', _$themeMode, opt: true, def: ThemeModeEnum.system);
  static bool _$newGradeNotification(SettingsModel v) => v.newGradeNotification;
  static const Field<SettingsModel, bool> _f$newGradeNotification = Field(
      'newGradeNotification', _$newGradeNotification,
      opt: true, def: true);
  static bool _$showHiddenUE(SettingsModel v) => v.showHiddenUE;
  static const Field<SettingsModel, bool> _f$showHiddenUE =
      Field('showHiddenUE', _$showHiddenUE, opt: true, def: false);
  static bool _$fetchAgendaAuto(SettingsModel v) => v.fetchAgendaAuto;
  static const Field<SettingsModel, bool> _f$fetchAgendaAuto =
      Field('fetchAgendaAuto', _$fetchAgendaAuto, opt: true, def: true);
  static bool _$showMiniCalendar(SettingsModel v) => v.showMiniCalendar;
  static const Field<SettingsModel, bool> _f$showMiniCalendar =
      Field('showMiniCalendar', _$showMiniCalendar, opt: true, def: true);
  static bool _$calendarUpdateNotification(SettingsModel v) =>
      v.calendarUpdateNotification;
  static const Field<SettingsModel, bool> _f$calendarUpdateNotification = Field(
      'calendarUpdateNotification', _$calendarUpdateNotification,
      opt: true, def: true);
  static int? _$agendaId(SettingsModel v) => v.agendaId;
  static const Field<SettingsModel, int> _f$agendaId =
      Field('agendaId', _$agendaId, opt: true);
  static bool _$newMailNotification(SettingsModel v) => v.newMailNotification;
  static const Field<SettingsModel, bool> _f$newMailNotification =
      Field('newMailNotification', _$newMailNotification, opt: true, def: true);
  static bool _$blockTrackers(SettingsModel v) => v.blockTrackers;
  static const Field<SettingsModel, bool> _f$blockTrackers =
      Field('blockTrackers', _$blockTrackers, opt: true, def: true);
  static bool _$forcedMailTheme(SettingsModel v) => v.forcedMailTheme;
  static const Field<SettingsModel, bool> _f$forcedMailTheme =
      Field('forcedMailTheme', _$forcedMailTheme, opt: true, def: true);
  static bool _$shownAgendaPopup(SettingsModel v) => v.shownAgendaPopup;
  static const Field<SettingsModel, bool> _f$shownAgendaPopup =
      Field('shownAgendaPopup', _$shownAgendaPopup, opt: true, def: false);
  static List<Functionalities> _$enabledFunctionalities(SettingsModel v) =>
      v.enabledFunctionalities;
  static const Field<SettingsModel, List<Functionalities>>
      _f$enabledFunctionalities = Field(
          'enabledFunctionalities', _$enabledFunctionalities,
          opt: true,
          def: const [
        Functionalities.tomuss,
        Functionalities.agenda,
        Functionalities.mail,
        Functionalities.settings,
        Functionalities.izly,
        Functionalities.map
      ]);
  static List<Functionalities> _$disabledFunctionalities(SettingsModel v) =>
      v.disabledFunctionalities;
  static const Field<SettingsModel, List<Functionalities>>
      _f$disabledFunctionalities = Field(
          'disabledFunctionalities', _$disabledFunctionalities,
          opt: true, def: const []);
  static int _$recentGradeDuration(SettingsModel v) => v.recentGradeDuration;
  static const Field<SettingsModel, int> _f$recentGradeDuration =
      Field('recentGradeDuration', _$recentGradeDuration, opt: true, def: 7);
  static bool _$firstLogin(SettingsModel v) => v.firstLogin;
  static const Field<SettingsModel, bool> _f$firstLogin =
      Field('firstLogin', _$firstLogin, opt: true, def: true);
  static bool _$mock(SettingsModel v) => v.mock;
  static const Field<SettingsModel, bool> _f$mock =
      Field('mock', _$mock, opt: true, def: false);
  static int _$agendaWeekLength(SettingsModel v) => v.agendaWeekLength;
  static const Field<SettingsModel, int> _f$agendaWeekLength =
      Field('agendaWeekLength', _$agendaWeekLength, opt: true, def: 5);
  static int _$agendaWeekReference(SettingsModel v) => v.agendaWeekReference;
  static const Field<SettingsModel, int> _f$agendaWeekReference =
      Field('agendaWeekReference', _$agendaWeekReference, opt: true, def: 0);
  static List<int> _$agendaDisabledDays(SettingsModel v) =>
      v.agendaDisabledDays;
  static const Field<SettingsModel, List<int>> _f$agendaDisabledDays = Field(
      'agendaDisabledDays', _$agendaDisabledDays,
      opt: true, def: const [6, 7]);
  static bool _$agendaPageTopToBottom(SettingsModel v) =>
      v.agendaPageTopToBottom;
  static const Field<SettingsModel, bool> _f$agendaPageTopToBottom = Field(
      'agendaPageTopToBottom', _$agendaPageTopToBottom,
      opt: true, def: false);
  static int _$agendaWeekRerenceAlignement(SettingsModel v) =>
      v.agendaWeekRerenceAlignement;
  static const Field<SettingsModel, int> _f$agendaWeekRerenceAlignement = Field(
      'agendaWeekRerenceAlignement', _$agendaWeekRerenceAlignement,
      opt: true, def: 0);

  @override
  final Map<Symbol, Field<SettingsModel, dynamic>> fields = const {
    #biometricAuth: _f$biometricAuth,
    #forceGreen: _f$forceGreen,
    #themeMode: _f$themeMode,
    #newGradeNotification: _f$newGradeNotification,
    #showHiddenUE: _f$showHiddenUE,
    #fetchAgendaAuto: _f$fetchAgendaAuto,
    #showMiniCalendar: _f$showMiniCalendar,
    #calendarUpdateNotification: _f$calendarUpdateNotification,
    #agendaId: _f$agendaId,
    #newMailNotification: _f$newMailNotification,
    #blockTrackers: _f$blockTrackers,
    #forcedMailTheme: _f$forcedMailTheme,
    #shownAgendaPopup: _f$shownAgendaPopup,
    #enabledFunctionalities: _f$enabledFunctionalities,
    #disabledFunctionalities: _f$disabledFunctionalities,
    #recentGradeDuration: _f$recentGradeDuration,
    #firstLogin: _f$firstLogin,
    #mock: _f$mock,
    #agendaWeekLength: _f$agendaWeekLength,
    #agendaWeekReference: _f$agendaWeekReference,
    #agendaDisabledDays: _f$agendaDisabledDays,
    #agendaPageTopToBottom: _f$agendaPageTopToBottom,
    #agendaWeekRerenceAlignement: _f$agendaWeekRerenceAlignement,
  };

  static SettingsModel _instantiate(DecodingData data) {
    return SettingsModel(
        biometricAuth: data.dec(_f$biometricAuth),
        forceGreen: data.dec(_f$forceGreen),
        themeMode: data.dec(_f$themeMode),
        newGradeNotification: data.dec(_f$newGradeNotification),
        showHiddenUE: data.dec(_f$showHiddenUE),
        fetchAgendaAuto: data.dec(_f$fetchAgendaAuto),
        showMiniCalendar: data.dec(_f$showMiniCalendar),
        calendarUpdateNotification: data.dec(_f$calendarUpdateNotification),
        agendaId: data.dec(_f$agendaId),
        newMailNotification: data.dec(_f$newMailNotification),
        blockTrackers: data.dec(_f$blockTrackers),
        forcedMailTheme: data.dec(_f$forcedMailTheme),
        shownAgendaPopup: data.dec(_f$shownAgendaPopup),
        enabledFunctionalities: data.dec(_f$enabledFunctionalities),
        disabledFunctionalities: data.dec(_f$disabledFunctionalities),
        recentGradeDuration: data.dec(_f$recentGradeDuration),
        firstLogin: data.dec(_f$firstLogin),
        mock: data.dec(_f$mock),
        agendaWeekLength: data.dec(_f$agendaWeekLength),
        agendaWeekReference: data.dec(_f$agendaWeekReference),
        agendaDisabledDays: data.dec(_f$agendaDisabledDays),
        agendaPageTopToBottom: data.dec(_f$agendaPageTopToBottom),
        agendaWeekRerenceAlignement: data.dec(_f$agendaWeekRerenceAlignement));
  }

  @override
  final Function instantiate = _instantiate;

  static SettingsModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SettingsModel>(map);
  }

  static SettingsModel fromJson(String json) {
    return ensureInitialized().decodeJson<SettingsModel>(json);
  }
}

mixin SettingsModelMappable {
  String toJson() {
    return SettingsModelMapper.ensureInitialized()
        .encodeJson<SettingsModel>(this as SettingsModel);
  }

  Map<String, dynamic> toMap() {
    return SettingsModelMapper.ensureInitialized()
        .encodeMap<SettingsModel>(this as SettingsModel);
  }

  SettingsModelCopyWith<SettingsModel, SettingsModel, SettingsModel>
      get copyWith => _SettingsModelCopyWithImpl(
          this as SettingsModel, $identity, $identity);
  @override
  String toString() {
    return SettingsModelMapper.ensureInitialized()
        .stringifyValue(this as SettingsModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SettingsModelMapper.ensureInitialized()
                .isValueEqual(this as SettingsModel, other));
  }

  @override
  int get hashCode {
    return SettingsModelMapper.ensureInitialized()
        .hashValue(this as SettingsModel);
  }
}

extension SettingsModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SettingsModel, $Out> {
  SettingsModelCopyWith<$R, SettingsModel, $Out> get $asSettingsModel =>
      $base.as((v, t, t2) => _SettingsModelCopyWithImpl(v, t, t2));
}

abstract class SettingsModelCopyWith<$R, $In extends SettingsModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Functionalities,
          ObjectCopyWith<$R, Functionalities, Functionalities>>
      get enabledFunctionalities;
  ListCopyWith<$R, Functionalities,
          ObjectCopyWith<$R, Functionalities, Functionalities>>
      get disabledFunctionalities;
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get agendaDisabledDays;
  $R call(
      {bool? biometricAuth,
      bool? forceGreen,
      ThemeModeEnum? themeMode,
      bool? newGradeNotification,
      bool? showHiddenUE,
      bool? fetchAgendaAuto,
      bool? showMiniCalendar,
      bool? calendarUpdateNotification,
      int? agendaId,
      bool? newMailNotification,
      bool? blockTrackers,
      bool? forcedMailTheme,
      bool? shownAgendaPopup,
      List<Functionalities>? enabledFunctionalities,
      List<Functionalities>? disabledFunctionalities,
      int? recentGradeDuration,
      bool? firstLogin,
      bool? mock,
      int? agendaWeekLength,
      int? agendaWeekReference,
      List<int>? agendaDisabledDays,
      bool? agendaPageTopToBottom,
      int? agendaWeekRerenceAlignement});
  SettingsModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SettingsModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SettingsModel, $Out>
    implements SettingsModelCopyWith<$R, SettingsModel, $Out> {
  _SettingsModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SettingsModel> $mapper =
      SettingsModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Functionalities,
          ObjectCopyWith<$R, Functionalities, Functionalities>>
      get enabledFunctionalities => ListCopyWith(
          $value.enabledFunctionalities,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(enabledFunctionalities: v));
  @override
  ListCopyWith<$R, Functionalities,
          ObjectCopyWith<$R, Functionalities, Functionalities>>
      get disabledFunctionalities => ListCopyWith(
          $value.disabledFunctionalities,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(disabledFunctionalities: v));
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get agendaDisabledDays =>
      ListCopyWith(
          $value.agendaDisabledDays,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(agendaDisabledDays: v));
  @override
  $R call(
          {bool? biometricAuth,
          bool? forceGreen,
          ThemeModeEnum? themeMode,
          bool? newGradeNotification,
          bool? showHiddenUE,
          bool? fetchAgendaAuto,
          bool? showMiniCalendar,
          bool? calendarUpdateNotification,
          Object? agendaId = $none,
          bool? newMailNotification,
          bool? blockTrackers,
          bool? forcedMailTheme,
          bool? shownAgendaPopup,
          List<Functionalities>? enabledFunctionalities,
          List<Functionalities>? disabledFunctionalities,
          int? recentGradeDuration,
          bool? firstLogin,
          bool? mock,
          int? agendaWeekLength,
          int? agendaWeekReference,
          List<int>? agendaDisabledDays,
          bool? agendaPageTopToBottom,
          int? agendaWeekRerenceAlignement}) =>
      $apply(FieldCopyWithData({
        if (biometricAuth != null) #biometricAuth: biometricAuth,
        if (forceGreen != null) #forceGreen: forceGreen,
        if (themeMode != null) #themeMode: themeMode,
        if (newGradeNotification != null)
          #newGradeNotification: newGradeNotification,
        if (showHiddenUE != null) #showHiddenUE: showHiddenUE,
        if (fetchAgendaAuto != null) #fetchAgendaAuto: fetchAgendaAuto,
        if (showMiniCalendar != null) #showMiniCalendar: showMiniCalendar,
        if (calendarUpdateNotification != null)
          #calendarUpdateNotification: calendarUpdateNotification,
        if (agendaId != $none) #agendaId: agendaId,
        if (newMailNotification != null)
          #newMailNotification: newMailNotification,
        if (blockTrackers != null) #blockTrackers: blockTrackers,
        if (forcedMailTheme != null) #forcedMailTheme: forcedMailTheme,
        if (shownAgendaPopup != null) #shownAgendaPopup: shownAgendaPopup,
        if (enabledFunctionalities != null)
          #enabledFunctionalities: enabledFunctionalities,
        if (disabledFunctionalities != null)
          #disabledFunctionalities: disabledFunctionalities,
        if (recentGradeDuration != null)
          #recentGradeDuration: recentGradeDuration,
        if (firstLogin != null) #firstLogin: firstLogin,
        if (mock != null) #mock: mock,
        if (agendaWeekLength != null) #agendaWeekLength: agendaWeekLength,
        if (agendaWeekReference != null)
          #agendaWeekReference: agendaWeekReference,
        if (agendaDisabledDays != null) #agendaDisabledDays: agendaDisabledDays,
        if (agendaPageTopToBottom != null)
          #agendaPageTopToBottom: agendaPageTopToBottom,
        if (agendaWeekRerenceAlignement != null)
          #agendaWeekRerenceAlignement: agendaWeekRerenceAlignement
      }));
  @override
  SettingsModel $make(CopyWithData data) => SettingsModel(
      biometricAuth: data.get(#biometricAuth, or: $value.biometricAuth),
      forceGreen: data.get(#forceGreen, or: $value.forceGreen),
      themeMode: data.get(#themeMode, or: $value.themeMode),
      newGradeNotification:
          data.get(#newGradeNotification, or: $value.newGradeNotification),
      showHiddenUE: data.get(#showHiddenUE, or: $value.showHiddenUE),
      fetchAgendaAuto: data.get(#fetchAgendaAuto, or: $value.fetchAgendaAuto),
      showMiniCalendar:
          data.get(#showMiniCalendar, or: $value.showMiniCalendar),
      calendarUpdateNotification: data.get(#calendarUpdateNotification,
          or: $value.calendarUpdateNotification),
      agendaId: data.get(#agendaId, or: $value.agendaId),
      newMailNotification:
          data.get(#newMailNotification, or: $value.newMailNotification),
      blockTrackers: data.get(#blockTrackers, or: $value.blockTrackers),
      forcedMailTheme: data.get(#forcedMailTheme, or: $value.forcedMailTheme),
      shownAgendaPopup:
          data.get(#shownAgendaPopup, or: $value.shownAgendaPopup),
      enabledFunctionalities:
          data.get(#enabledFunctionalities, or: $value.enabledFunctionalities),
      disabledFunctionalities: data.get(#disabledFunctionalities,
          or: $value.disabledFunctionalities),
      recentGradeDuration:
          data.get(#recentGradeDuration, or: $value.recentGradeDuration),
      firstLogin: data.get(#firstLogin, or: $value.firstLogin),
      mock: data.get(#mock, or: $value.mock),
      agendaWeekLength:
          data.get(#agendaWeekLength, or: $value.agendaWeekLength),
      agendaWeekReference:
          data.get(#agendaWeekReference, or: $value.agendaWeekReference),
      agendaDisabledDays:
          data.get(#agendaDisabledDays, or: $value.agendaDisabledDays),
      agendaPageTopToBottom:
          data.get(#agendaPageTopToBottom, or: $value.agendaPageTopToBottom),
      agendaWeekRerenceAlignement: data.get(#agendaWeekRerenceAlignement,
          or: $value.agendaWeekRerenceAlignement));

  @override
  SettingsModelCopyWith<$R2, SettingsModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SettingsModelCopyWithImpl($value, $cast, t);
}