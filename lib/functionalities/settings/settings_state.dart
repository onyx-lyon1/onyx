part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}
class SettingsReady extends SettingsState {}
class SettingsLoading extends SettingsState {}


