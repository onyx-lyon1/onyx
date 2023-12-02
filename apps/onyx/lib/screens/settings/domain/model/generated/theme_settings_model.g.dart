// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../theme_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeSettingsModelAdapter extends TypeAdapter<ThemeSettingsModel> {
  @override
  final int typeId = 42;

  @override
  ThemeSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThemeSettingsModel(
      darkThemeSelected: fields[1] as String,
      lightThemeSelected: fields[2] as String,
      themeMode: fields[4] as ThemeModeEnum,
      autoSwitchTheme: fields[5] as bool,
      themesCreatedString: fields[0] as String?,
      favoriteThemesString: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ThemeSettingsModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.darkThemeSelected)
      ..writeByte(2)
      ..write(obj.lightThemeSelected)
      ..writeByte(4)
      ..write(obj.themeMode)
      ..writeByte(5)
      ..write(obj.autoSwitchTheme)
      ..writeByte(0)
      ..write(obj.themesCreatedString)
      ..writeByte(3)
      ..write(obj.favoriteThemesString);
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
