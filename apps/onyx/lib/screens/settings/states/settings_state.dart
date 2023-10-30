part of 'settings_cubit.dart';

@MappableEnum()
enum SettingsStatus {
  @MappableValue(000)
  initial,
  @MappableValue(100)
  loading,
  @MappableValue(200)
  ready,
  @MappableValue(300)
  error
}

@MappableClass()
class SettingsState with SettingsStateMappable {
  final SettingsStatus status;
  final SettingsModel settings;
  final bool collapseAll;

  SettingsState({
    this.status = SettingsStatus.initial,
    this.collapseAll = false,
    required this.settings,
  });
}
