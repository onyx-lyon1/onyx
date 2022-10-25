part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SettingsReset extends SettingsEvent {}
class SettingsLoad extends SettingsEvent {}
class SettingsModify extends SettingsEvent {
  final SettingsModel settings;
  SettingsModify(this.settings);
}
