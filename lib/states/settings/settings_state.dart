part of 'settings_bloc.dart';



@immutable
abstract class SettingsState {
  const SettingsState(this.settings);
  final SettingsModel settings;
}

class SettingsInitial extends SettingsState {
  const SettingsInitial(settings) : super(settings);
}
class SettingsReady extends SettingsState {
  const SettingsReady(settings) : super(settings);
}
class SettingsLoading extends SettingsState {
  const SettingsLoading(settings) : super(settings);
}


