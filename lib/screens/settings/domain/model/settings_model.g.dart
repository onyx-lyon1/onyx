// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsModelAdapter extends TypeAdapter<SettingsModel> {
  @override
  final int typeId = 7;

  @override
  SettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsModel(
      keepMeLoggedIn: fields[0] as bool,
      forceGreen: fields[1] as bool,
      themeMode: fields[2] as ThemeModeEnum,
      newGradeNotification: fields[3] as bool,
      showHiddenUE: fields[4] as bool,
      fetchAgendaAuto: fields[5] as bool,
      showMiniCalendar: fields[6] as bool,
      calendarUpdateNotification: fields[7] as bool,
      agendaId: fields[8] as int?,
      newMailNotification: fields[9] as bool,
      blockTrackers: fields[10] as bool,
      darkerMail: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.keepMeLoggedIn)
      ..writeByte(1)
      ..write(obj.forceGreen)
      ..writeByte(2)
      ..write(obj.themeMode)
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
      ..write(obj.darkerMail);
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
