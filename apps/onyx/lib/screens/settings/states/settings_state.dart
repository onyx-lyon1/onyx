part of 'settings_cubit.dart';

sealed class SettingsState {
  const SettingsState();
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

final class SettingsReady extends SettingsState with EquatableMixin {
  const SettingsReady({required this.settings, this.collapseAll = false});

  final SettingsModel settings;
  final bool collapseAll;

  SettingsReady copyWith({SettingsModel? settings, bool? collapseAll}) {
    return SettingsReady(
      settings: settings ?? this.settings,
      collapseAll: collapseAll ?? this.collapseAll,
    );
  }

  @override
  List<Object?> get props => [settings, collapseAll];

  @override
  bool? get stringify => true;
}
