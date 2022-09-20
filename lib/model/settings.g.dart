// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsModelAdapter extends TypeAdapter<SettingsModel> {
  @override
  final int typeId = 2;

  @override
  SettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsModel()
      ..keepMeLoggedIn = fields[0] as bool
      ..forceGreen = fields[1] as bool
      ..darkMode = fields[2] as bool
      ..newGradeNotification = fields[3] as bool
      ..showHiddenUE = fields[4] as bool
      ..fetchAgendaAuto = fields[5] as bool
      ..showMiniCalendar = fields[6] as bool
      ..agendaURL = fields[7] as String
      ..newMailNotification = fields[8] as bool
      ..blockTrackers = fields[9] as bool;
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.keepMeLoggedIn)
      ..writeByte(1)
      ..write(obj.forceGreen)
      ..writeByte(2)
      ..write(obj.darkMode)
      ..writeByte(3)
      ..write(obj.newGradeNotification)
      ..writeByte(4)
      ..write(obj.showHiddenUE)
      ..writeByte(5)
      ..write(obj.fetchAgendaAuto)
      ..writeByte(6)
      ..write(obj.showMiniCalendar)
      ..writeByte(7)
      ..write(obj.agendaURL)
      ..writeByte(8)
      ..write(obj.newMailNotification)
      ..writeByte(9)
      ..write(obj.blockTrackers);
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
