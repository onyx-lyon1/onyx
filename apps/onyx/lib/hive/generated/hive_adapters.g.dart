// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class SettingsModelAdapter extends TypeAdapter<SettingsModel> {
  @override
  final typeId = 7;

  @override
  SettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsModel(
      biometricAuth: fields[16] == null ? false : fields[16] as bool,
      forceGreen: fields[1] == null ? false : fields[1] as bool,
      newGradeNotification: fields[3] == null ? true : fields[3] as bool,
      showHiddenUE: fields[4] == null ? false : fields[4] as bool,
      fetchAgendaAuto: fields[5] == null ? true : fields[5] as bool,
      showMiniCalendar: fields[6] == null ? true : fields[6] as bool,
      calendarUpdateNotification: fields[7] == null ? true : fields[7] as bool,
      agendaIds:
          fields[27] == null ? const [] : (fields[27] as List).cast<int>(),
      newMailNotification: fields[9] == null ? true : fields[9] as bool,
      blockTrackers: fields[10] == null ? true : fields[10] as bool,
      forcedMailTheme: fields[11] == null ? true : fields[11] as bool,
      shownAgendaPopup: fields[18] == null ? false : fields[18] as bool,
      enabledFunctionalities: fields[12] == null
          ? defaultEnabledFunctionalities
          : (fields[12] as List).cast<Functionalities>(),
      disabledFunctionalities: fields[13] == null
          ? defaultDisabledFunctionalities
          : (fields[13] as List).cast<Functionalities>(),
      recentGradeDuration: fields[14] == null ? 7 : (fields[14] as num).toInt(),
      firstLogin: fields[15] == null ? true : fields[15] as bool,
      mock: fields[17] == null ? false : fields[17] as bool,
      agendaWeekLength: fields[19] == null ? 5 : (fields[19] as num).toInt(),
      agendaWeekReference: fields[20] == null ? 0 : (fields[20] as num).toInt(),
      agendaDisabledDays:
          fields[21] == null ? const [6, 7] : (fields[21] as List).cast<int>(),
      agendaPageTopToBottom: fields[22] == null ? false : fields[22] as bool,
      agendaWeekRerenceAlignement:
          fields[23] == null ? 0 : (fields[23] as num).toInt(),
      colloscopeOverrideStudentId:
          fields[25] == null ? -1 : (fields[25] as num).toInt(),
      colloscopeOverrideYearId:
          fields[26] == null ? 0 : (fields[26] as num).toInt(),
      colloscopeEnabled: fields[28] as bool?,
      agendaId: (fields[8] as num?)?.toInt(),
      examenAddToAgenda: fields[29] == null ? true : fields[29] as bool,
      language: fields[30] as String?,
      izlyNotification: fields[31] == null ? true : fields[31] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer
      ..writeByte(29)
      ..writeByte(1)
      ..write(obj.forceGreen)
      ..writeByte(3)
      ..write(obj.newGradeNotification)
      ..writeByte(4)
      ..write(obj.showHiddenUE)
      ..writeByte(5)
      ..write(obj.fetchAgendaAuto)
      ..writeByte(6)
      ..write(obj.showMiniCalendar)
      ..writeByte(7)
      ..write(obj.calendarUpdateNotification)
      ..writeByte(8)
      ..write(obj.agendaId)
      ..writeByte(9)
      ..write(obj.newMailNotification)
      ..writeByte(10)
      ..write(obj.blockTrackers)
      ..writeByte(11)
      ..write(obj.forcedMailTheme)
      ..writeByte(12)
      ..write(obj.enabledFunctionalities)
      ..writeByte(13)
      ..write(obj.disabledFunctionalities)
      ..writeByte(14)
      ..write(obj.recentGradeDuration)
      ..writeByte(15)
      ..write(obj.firstLogin)
      ..writeByte(16)
      ..write(obj.biometricAuth)
      ..writeByte(17)
      ..write(obj.mock)
      ..writeByte(18)
      ..write(obj.shownAgendaPopup)
      ..writeByte(19)
      ..write(obj.agendaWeekLength)
      ..writeByte(20)
      ..write(obj.agendaWeekReference)
      ..writeByte(21)
      ..write(obj.agendaDisabledDays)
      ..writeByte(22)
      ..write(obj.agendaPageTopToBottom)
      ..writeByte(23)
      ..write(obj.agendaWeekRerenceAlignement)
      ..writeByte(25)
      ..write(obj.colloscopeOverrideStudentId)
      ..writeByte(26)
      ..write(obj.colloscopeOverrideYearId)
      ..writeByte(27)
      ..write(obj.agendaIds)
      ..writeByte(28)
      ..write(obj.colloscopeEnabled)
      ..writeByte(29)
      ..write(obj.examenAddToAgenda)
      ..writeByte(30)
      ..write(obj.language)
      ..writeByte(31)
      ..write(obj.izlyNotification);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThemeModeEnumAdapter extends TypeAdapter<ThemeModeEnum> {
  @override
  final typeId = 8;

  @override
  ThemeModeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeModeEnum.system;
      case 1:
        return ThemeModeEnum.dark;
      case 2:
        return ThemeModeEnum.light;
      default:
        return ThemeModeEnum.system;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeModeEnum obj) {
    switch (obj) {
      case ThemeModeEnum.system:
        writer.writeByte(0);
      case ThemeModeEnum.dark:
        writer.writeByte(1);
      case ThemeModeEnum.light:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeModeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FunctionalitiesAdapter extends TypeAdapter<Functionalities> {
  @override
  final typeId = 18;

  @override
  Functionalities read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Functionalities.tomuss;
      case 1:
        return Functionalities.agenda;
      case 2:
        return Functionalities.mail;
      case 3:
        return Functionalities.map;
      case 4:
        return Functionalities.izly;
      case 5:
        return Functionalities.settings;
      case 6:
        return Functionalities.examen;
      default:
        return Functionalities.tomuss;
    }
  }

  @override
  void write(BinaryWriter writer, Functionalities obj) {
    switch (obj) {
      case Functionalities.tomuss:
        writer.writeByte(0);
      case Functionalities.agenda:
        writer.writeByte(1);
      case Functionalities.mail:
        writer.writeByte(2);
      case Functionalities.map:
        writer.writeByte(3);
      case Functionalities.izly:
        writer.writeByte(4);
      case Functionalities.settings:
        writer.writeByte(5);
      case Functionalities.examen:
        writer.writeByte(6);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FunctionalitiesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThemeSettingsModelAdapter extends TypeAdapter<ThemeSettingsModel> {
  @override
  final typeId = 42;

  @override
  ThemeSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThemeSettingsModel(
      themesCreated:
          fields[6] == null ? const [] : (fields[6] as List).cast<ThemeModel>(),
      darkThemeSelected:
          fields[1] == null ? 'Dark Default' : fields[1] as String,
      lightThemeSelected:
          fields[2] == null ? 'Light Default' : fields[2] as String,
      favoriteThemes:
          fields[8] == null ? const [] : (fields[8] as List).cast<ThemeModel>(),
      themeMode:
          fields[4] == null ? ThemeModeEnum.system : fields[4] as ThemeModeEnum,
      autoSwitchTheme: fields[5] == null ? true : fields[5] as bool,
      themesCreatedString: fields[0] as String?,
      favoriteThemesString: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ThemeSettingsModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.themesCreatedString)
      ..writeByte(1)
      ..write(obj.darkThemeSelected)
      ..writeByte(2)
      ..write(obj.lightThemeSelected)
      ..writeByte(3)
      ..write(obj.favoriteThemesString)
      ..writeByte(4)
      ..write(obj.themeMode)
      ..writeByte(5)
      ..write(obj.autoSwitchTheme)
      ..writeByte(6)
      ..write(obj.themesCreated)
      ..writeByte(8)
      ..write(obj.favoriteThemes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
