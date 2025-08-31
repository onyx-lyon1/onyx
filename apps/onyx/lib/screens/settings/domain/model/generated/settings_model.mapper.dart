// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../settings_model.dart';

class SettingsModelMapper extends ClassMapperBase<SettingsModel> {
  SettingsModelMapper._();

  static SettingsModelMapper? _instance;
  static SettingsModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsModelMapper._());
      FunctionalitiesMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsModel';

  static bool _$biometricAuth(SettingsModel v) => v.biometricAuth;
  static const Field<SettingsModel, bool> _f$biometricAuth = Field(
    'biometricAuth',
    _$biometricAuth,
    opt: true,
    def: false,
  );
  static bool _$forceGreen(SettingsModel v) => v.forceGreen;
  static const Field<SettingsModel, bool> _f$forceGreen = Field(
    'forceGreen',
    _$forceGreen,
    opt: true,
    def: false,
  );
  static bool _$newGradeNotification(SettingsModel v) => v.newGradeNotification;
  static const Field<SettingsModel, bool> _f$newGradeNotification = Field(
    'newGradeNotification',
    _$newGradeNotification,
    opt: true,
    def: true,
  );
  static bool _$showHiddenUE(SettingsModel v) => v.showHiddenUE;
  static const Field<SettingsModel, bool> _f$showHiddenUE = Field(
    'showHiddenUE',
    _$showHiddenUE,
    opt: true,
    def: false,
  );
  static bool _$fetchAgendaAuto(SettingsModel v) => v.fetchAgendaAuto;
  static const Field<SettingsModel, bool> _f$fetchAgendaAuto = Field(
    'fetchAgendaAuto',
    _$fetchAgendaAuto,
    opt: true,
    def: true,
  );
  static bool _$showMiniCalendar(SettingsModel v) => v.showMiniCalendar;
  static const Field<SettingsModel, bool> _f$showMiniCalendar = Field(
    'showMiniCalendar',
    _$showMiniCalendar,
    opt: true,
    def: true,
  );
  static bool _$calendarUpdateNotification(SettingsModel v) =>
      v.calendarUpdateNotification;
  static const Field<SettingsModel, bool> _f$calendarUpdateNotification = Field(
    'calendarUpdateNotification',
    _$calendarUpdateNotification,
    opt: true,
    def: true,
  );
  static List<int> _$agendaIds(SettingsModel v) => v.agendaIds;
  static const Field<SettingsModel, List<int>> _f$agendaIds = Field(
    'agendaIds',
    _$agendaIds,
    opt: true,
    def: const [],
  );
  static bool _$newMailNotification(SettingsModel v) => v.newMailNotification;
  static const Field<SettingsModel, bool> _f$newMailNotification = Field(
    'newMailNotification',
    _$newMailNotification,
    opt: true,
    def: true,
  );
  static bool _$blockTrackers(SettingsModel v) => v.blockTrackers;
  static const Field<SettingsModel, bool> _f$blockTrackers = Field(
    'blockTrackers',
    _$blockTrackers,
    opt: true,
    def: true,
  );
  static bool _$forcedMailTheme(SettingsModel v) => v.forcedMailTheme;
  static const Field<SettingsModel, bool> _f$forcedMailTheme = Field(
    'forcedMailTheme',
    _$forcedMailTheme,
    opt: true,
    def: true,
  );
  static bool _$shownAgendaPopup(SettingsModel v) => v.shownAgendaPopup;
  static const Field<SettingsModel, bool> _f$shownAgendaPopup = Field(
    'shownAgendaPopup',
    _$shownAgendaPopup,
    opt: true,
    def: false,
  );
  static List<Functionalities> _$enabledFunctionalities(SettingsModel v) =>
      v.enabledFunctionalities;
  static const Field<SettingsModel, List<Functionalities>>
  _f$enabledFunctionalities = Field(
    'enabledFunctionalities',
    _$enabledFunctionalities,
    opt: true,
    def: defaultEnabledFunctionalities,
  );
  static List<Functionalities> _$disabledFunctionalities(SettingsModel v) =>
      v.disabledFunctionalities;
  static const Field<SettingsModel, List<Functionalities>>
  _f$disabledFunctionalities = Field(
    'disabledFunctionalities',
    _$disabledFunctionalities,
    opt: true,
    def: defaultDisabledFunctionalities,
  );
  static int _$recentGradeDuration(SettingsModel v) => v.recentGradeDuration;
  static const Field<SettingsModel, int> _f$recentGradeDuration = Field(
    'recentGradeDuration',
    _$recentGradeDuration,
    opt: true,
    def: 7,
  );
  static bool _$firstLogin(SettingsModel v) => v.firstLogin;
  static const Field<SettingsModel, bool> _f$firstLogin = Field(
    'firstLogin',
    _$firstLogin,
    opt: true,
    def: true,
  );
  static bool _$mock(SettingsModel v) => v.mock;
  static const Field<SettingsModel, bool> _f$mock = Field(
    'mock',
    _$mock,
    opt: true,
    def: false,
  );
  static int _$agendaWeekLength(SettingsModel v) => v.agendaWeekLength;
  static const Field<SettingsModel, int> _f$agendaWeekLength = Field(
    'agendaWeekLength',
    _$agendaWeekLength,
    opt: true,
    def: 5,
  );
  static int _$agendaWeekReference(SettingsModel v) => v.agendaWeekReference;
  static const Field<SettingsModel, int> _f$agendaWeekReference = Field(
    'agendaWeekReference',
    _$agendaWeekReference,
    opt: true,
    def: 0,
  );
  static List<int> _$agendaDisabledDays(SettingsModel v) =>
      v.agendaDisabledDays;
  static const Field<SettingsModel, List<int>> _f$agendaDisabledDays = Field(
    'agendaDisabledDays',
    _$agendaDisabledDays,
    opt: true,
    def: const [6, 7],
  );
  static bool _$agendaPageTopToBottom(SettingsModel v) =>
      v.agendaPageTopToBottom;
  static const Field<SettingsModel, bool> _f$agendaPageTopToBottom = Field(
    'agendaPageTopToBottom',
    _$agendaPageTopToBottom,
    opt: true,
    def: false,
  );
  static int _$agendaWeekRerenceAlignement(SettingsModel v) =>
      v.agendaWeekRerenceAlignement;
  static const Field<SettingsModel, int> _f$agendaWeekRerenceAlignement = Field(
    'agendaWeekRerenceAlignement',
    _$agendaWeekRerenceAlignement,
    opt: true,
    def: 0,
  );
  static int _$colloscopeOverrideStudentId(SettingsModel v) =>
      v.colloscopeOverrideStudentId;
  static const Field<SettingsModel, int> _f$colloscopeOverrideStudentId = Field(
    'colloscopeOverrideStudentId',
    _$colloscopeOverrideStudentId,
    opt: true,
    def: -1,
  );
  static int _$colloscopeOverrideYearId(SettingsModel v) =>
      v.colloscopeOverrideYearId;
  static const Field<SettingsModel, int> _f$colloscopeOverrideYearId = Field(
    'colloscopeOverrideYearId',
    _$colloscopeOverrideYearId,
    opt: true,
    def: 0,
  );
  static bool? _$colloscopeEnabled(SettingsModel v) => v.colloscopeEnabled;
  static const Field<SettingsModel, bool> _f$colloscopeEnabled = Field(
    'colloscopeEnabled',
    _$colloscopeEnabled,
    opt: true,
  );
  static int? _$agendaId(SettingsModel v) => v.agendaId;
  static const Field<SettingsModel, int> _f$agendaId = Field(
    'agendaId',
    _$agendaId,
    opt: true,
  );
  static bool _$examenAddToAgenda(SettingsModel v) => v.examenAddToAgenda;
  static const Field<SettingsModel, bool> _f$examenAddToAgenda = Field(
    'examenAddToAgenda',
    _$examenAddToAgenda,
    opt: true,
    def: true,
  );
  static String? _$language(SettingsModel v) => v.language;
  static const Field<SettingsModel, String> _f$language = Field(
    'language',
    _$language,
    opt: true,
  );
  static bool _$izlyNotification(SettingsModel v) => v.izlyNotification;
  static const Field<SettingsModel, bool> _f$izlyNotification = Field(
    'izlyNotification',
    _$izlyNotification,
    opt: true,
    def: true,
  );

  @override
  final MappableFields<SettingsModel> fields = const {
    #biometricAuth: _f$biometricAuth,
    #forceGreen: _f$forceGreen,
    #newGradeNotification: _f$newGradeNotification,
    #showHiddenUE: _f$showHiddenUE,
    #fetchAgendaAuto: _f$fetchAgendaAuto,
    #showMiniCalendar: _f$showMiniCalendar,
    #calendarUpdateNotification: _f$calendarUpdateNotification,
    #agendaIds: _f$agendaIds,
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
    #colloscopeOverrideStudentId: _f$colloscopeOverrideStudentId,
    #colloscopeOverrideYearId: _f$colloscopeOverrideYearId,
    #colloscopeEnabled: _f$colloscopeEnabled,
    #agendaId: _f$agendaId,
    #examenAddToAgenda: _f$examenAddToAgenda,
    #language: _f$language,
    #izlyNotification: _f$izlyNotification,
  };

  static SettingsModel _instantiate(DecodingData data) {
    return SettingsModel(
      biometricAuth: data.dec(_f$biometricAuth),
      forceGreen: data.dec(_f$forceGreen),
      newGradeNotification: data.dec(_f$newGradeNotification),
      showHiddenUE: data.dec(_f$showHiddenUE),
      fetchAgendaAuto: data.dec(_f$fetchAgendaAuto),
      showMiniCalendar: data.dec(_f$showMiniCalendar),
      calendarUpdateNotification: data.dec(_f$calendarUpdateNotification),
      agendaIds: data.dec(_f$agendaIds),
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
      agendaWeekRerenceAlignement: data.dec(_f$agendaWeekRerenceAlignement),
      colloscopeOverrideStudentId: data.dec(_f$colloscopeOverrideStudentId),
      colloscopeOverrideYearId: data.dec(_f$colloscopeOverrideYearId),
      colloscopeEnabled: data.dec(_f$colloscopeEnabled),
      agendaId: data.dec(_f$agendaId),
      examenAddToAgenda: data.dec(_f$examenAddToAgenda),
      language: data.dec(_f$language),
      izlyNotification: data.dec(_f$izlyNotification),
    );
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
    return SettingsModelMapper.ensureInitialized().encodeJson<SettingsModel>(
      this as SettingsModel,
    );
  }

  Map<String, dynamic> toMap() {
    return SettingsModelMapper.ensureInitialized().encodeMap<SettingsModel>(
      this as SettingsModel,
    );
  }

  SettingsModelCopyWith<SettingsModel, SettingsModel, SettingsModel>
  get copyWith => _SettingsModelCopyWithImpl<SettingsModel, SettingsModel>(
    this as SettingsModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return SettingsModelMapper.ensureInitialized().stringifyValue(
      this as SettingsModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return SettingsModelMapper.ensureInitialized().equalsValue(
      this as SettingsModel,
      other,
    );
  }

  @override
  int get hashCode {
    return SettingsModelMapper.ensureInitialized().hashValue(
      this as SettingsModel,
    );
  }
}

extension SettingsModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SettingsModel, $Out> {
  SettingsModelCopyWith<$R, SettingsModel, $Out> get $asSettingsModel =>
      $base.as((v, t, t2) => _SettingsModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SettingsModelCopyWith<$R, $In extends SettingsModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get agendaIds;
  ListCopyWith<
    $R,
    Functionalities,
    ObjectCopyWith<$R, Functionalities, Functionalities>
  >
  get enabledFunctionalities;
  ListCopyWith<
    $R,
    Functionalities,
    ObjectCopyWith<$R, Functionalities, Functionalities>
  >
  get disabledFunctionalities;
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get agendaDisabledDays;
  $R call({
    bool? biometricAuth,
    bool? forceGreen,
    bool? newGradeNotification,
    bool? showHiddenUE,
    bool? fetchAgendaAuto,
    bool? showMiniCalendar,
    bool? calendarUpdateNotification,
    List<int>? agendaIds,
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
    int? agendaWeekRerenceAlignement,
    int? colloscopeOverrideStudentId,
    int? colloscopeOverrideYearId,
    bool? colloscopeEnabled,
    int? agendaId,
    bool? examenAddToAgenda,
    String? language,
    bool? izlyNotification,
  });
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
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get agendaIds =>
      ListCopyWith(
        $value.agendaIds,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(agendaIds: v),
      );
  @override
  ListCopyWith<
    $R,
    Functionalities,
    ObjectCopyWith<$R, Functionalities, Functionalities>
  >
  get enabledFunctionalities => ListCopyWith(
    $value.enabledFunctionalities,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(enabledFunctionalities: v),
  );
  @override
  ListCopyWith<
    $R,
    Functionalities,
    ObjectCopyWith<$R, Functionalities, Functionalities>
  >
  get disabledFunctionalities => ListCopyWith(
    $value.disabledFunctionalities,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(disabledFunctionalities: v),
  );
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get agendaDisabledDays =>
      ListCopyWith(
        $value.agendaDisabledDays,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(agendaDisabledDays: v),
      );
  @override
  $R call({
    bool? biometricAuth,
    bool? forceGreen,
    bool? newGradeNotification,
    bool? showHiddenUE,
    bool? fetchAgendaAuto,
    bool? showMiniCalendar,
    bool? calendarUpdateNotification,
    List<int>? agendaIds,
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
    int? agendaWeekRerenceAlignement,
    int? colloscopeOverrideStudentId,
    int? colloscopeOverrideYearId,
    Object? colloscopeEnabled = $none,
    Object? agendaId = $none,
    bool? examenAddToAgenda,
    Object? language = $none,
    bool? izlyNotification,
  }) => $apply(
    FieldCopyWithData({
      if (biometricAuth != null) #biometricAuth: biometricAuth,
      if (forceGreen != null) #forceGreen: forceGreen,
      if (newGradeNotification != null)
        #newGradeNotification: newGradeNotification,
      if (showHiddenUE != null) #showHiddenUE: showHiddenUE,
      if (fetchAgendaAuto != null) #fetchAgendaAuto: fetchAgendaAuto,
      if (showMiniCalendar != null) #showMiniCalendar: showMiniCalendar,
      if (calendarUpdateNotification != null)
        #calendarUpdateNotification: calendarUpdateNotification,
      if (agendaIds != null) #agendaIds: agendaIds,
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
        #agendaWeekRerenceAlignement: agendaWeekRerenceAlignement,
      if (colloscopeOverrideStudentId != null)
        #colloscopeOverrideStudentId: colloscopeOverrideStudentId,
      if (colloscopeOverrideYearId != null)
        #colloscopeOverrideYearId: colloscopeOverrideYearId,
      if (colloscopeEnabled != $none) #colloscopeEnabled: colloscopeEnabled,
      if (agendaId != $none) #agendaId: agendaId,
      if (examenAddToAgenda != null) #examenAddToAgenda: examenAddToAgenda,
      if (language != $none) #language: language,
      if (izlyNotification != null) #izlyNotification: izlyNotification,
    }),
  );
  @override
  SettingsModel $make(CopyWithData data) => SettingsModel(
    biometricAuth: data.get(#biometricAuth, or: $value.biometricAuth),
    forceGreen: data.get(#forceGreen, or: $value.forceGreen),
    newGradeNotification: data.get(
      #newGradeNotification,
      or: $value.newGradeNotification,
    ),
    showHiddenUE: data.get(#showHiddenUE, or: $value.showHiddenUE),
    fetchAgendaAuto: data.get(#fetchAgendaAuto, or: $value.fetchAgendaAuto),
    showMiniCalendar: data.get(#showMiniCalendar, or: $value.showMiniCalendar),
    calendarUpdateNotification: data.get(
      #calendarUpdateNotification,
      or: $value.calendarUpdateNotification,
    ),
    agendaIds: data.get(#agendaIds, or: $value.agendaIds),
    newMailNotification: data.get(
      #newMailNotification,
      or: $value.newMailNotification,
    ),
    blockTrackers: data.get(#blockTrackers, or: $value.blockTrackers),
    forcedMailTheme: data.get(#forcedMailTheme, or: $value.forcedMailTheme),
    shownAgendaPopup: data.get(#shownAgendaPopup, or: $value.shownAgendaPopup),
    enabledFunctionalities: data.get(
      #enabledFunctionalities,
      or: $value.enabledFunctionalities,
    ),
    disabledFunctionalities: data.get(
      #disabledFunctionalities,
      or: $value.disabledFunctionalities,
    ),
    recentGradeDuration: data.get(
      #recentGradeDuration,
      or: $value.recentGradeDuration,
    ),
    firstLogin: data.get(#firstLogin, or: $value.firstLogin),
    mock: data.get(#mock, or: $value.mock),
    agendaWeekLength: data.get(#agendaWeekLength, or: $value.agendaWeekLength),
    agendaWeekReference: data.get(
      #agendaWeekReference,
      or: $value.agendaWeekReference,
    ),
    agendaDisabledDays: data.get(
      #agendaDisabledDays,
      or: $value.agendaDisabledDays,
    ),
    agendaPageTopToBottom: data.get(
      #agendaPageTopToBottom,
      or: $value.agendaPageTopToBottom,
    ),
    agendaWeekRerenceAlignement: data.get(
      #agendaWeekRerenceAlignement,
      or: $value.agendaWeekRerenceAlignement,
    ),
    colloscopeOverrideStudentId: data.get(
      #colloscopeOverrideStudentId,
      or: $value.colloscopeOverrideStudentId,
    ),
    colloscopeOverrideYearId: data.get(
      #colloscopeOverrideYearId,
      or: $value.colloscopeOverrideYearId,
    ),
    colloscopeEnabled: data.get(
      #colloscopeEnabled,
      or: $value.colloscopeEnabled,
    ),
    agendaId: data.get(#agendaId, or: $value.agendaId),
    examenAddToAgenda: data.get(
      #examenAddToAgenda,
      or: $value.examenAddToAgenda,
    ),
    language: data.get(#language, or: $value.language),
    izlyNotification: data.get(#izlyNotification, or: $value.izlyNotification),
  );

  @override
  SettingsModelCopyWith<$R2, SettingsModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SettingsModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

