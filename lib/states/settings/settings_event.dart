part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SettingsReset extends SettingsEvent {}
class SettingsLoad extends SettingsEvent {}
// ignore: must_be_immutable
class SettingsModify extends SettingsEvent {
  SettingsModel settings;
  SettingsModify(this.settings);
}
