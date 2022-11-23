part of 'settings_cubit.dart';

enum SettingsStatus { initial, loading, ready, error }

class SettingsState {
  final SettingsStatus status;
  final SettingsModel settings;

  SettingsState({
    this.status = SettingsStatus.initial,
    required this.settings,
  });

  SettingsState copyWith({
    SettingsStatus? status,
    SettingsModel? settings,
  }) {
    return SettingsState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
    );
  }
}
