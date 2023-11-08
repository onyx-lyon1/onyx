// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../theme_mode_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemesUserDataAdapter extends TypeAdapter<ThemesUserData> {
  @override
  final int typeId = 42;

  @override
  ThemesUserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThemesUserData()
      ..themesCreated = (fields[0] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList()
      ..darkThemeSelected = fields[1] as String
      ..lightThemeSelected = fields[2] as String
      ..favoriteThemes = (fields[3] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList();
  }

  @override
  void write(BinaryWriter writer, ThemesUserData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.themesCreated)
      ..writeByte(1)
      ..write(obj.darkThemeSelected)
      ..writeByte(2)
      ..write(obj.lightThemeSelected)
      ..writeByte(3)
      ..write(obj.favoriteThemes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemesUserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThemeModeEnumAdapter extends TypeAdapter<ThemeModeEnum> {
  @override
  final int typeId = 8;

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
        break;
      case ThemeModeEnum.dark:
        writer.writeByte(1);
        break;
      case ThemeModeEnum.light:
        writer.writeByte(2);
        break;
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
