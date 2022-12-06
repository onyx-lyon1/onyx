// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

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
