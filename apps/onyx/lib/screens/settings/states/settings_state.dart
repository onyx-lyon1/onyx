part of 'settings_cubit.dart';

enum SettingsStatus { initial, loading, ready, error }

class SettingsState {
  final SettingsStatus status;
  final SettingsModel settings;
  final bool collapseAll;

  SettingsState({
    this.status = SettingsStatus.initial,
    this.collapseAll = false,
    required this.settings,
  });

  SettingsState copyWith({
    SettingsStatus? status,
    SettingsModel? settings,
    bool? collapseAll,
  }) {
    return SettingsState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      collapseAll: collapseAll ?? false,
    );
  }

  @override
  String toString() {
    return 'SettingsState{status: $status, settings: $settings, collapseAll: $collapseAll}';
  }
}
