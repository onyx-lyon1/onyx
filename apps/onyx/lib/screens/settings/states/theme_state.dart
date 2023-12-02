part of 'theme_cubit.dart';

enum ThemeStateStatus { init, loaded, updated, error }

class ThemeState extends Equatable {
  final ThemeStateStatus status;
  final ThemeSettingsModel? themesSettings;

  const ThemeState({
    this.status = ThemeStateStatus.init,
    this.themesSettings,
  });

  // Define a copyWith method for creating a new instance with modified properties
  ThemeState copyWith({
    ThemeStateStatus? status,
    ThemeMode? themeMode,
    ThemeSettingsModel? themesSettings,
  }) {
    return ThemeState(
      status: status ?? this.status,
      themesSettings: themesSettings ?? this.themesSettings,
    );
  }

  @override
  List<Object?> get props => [
        status,
        themesSettings,
      ];

  @override
  bool? get stringify => true;

  ThemeData? get theme {
    if (themesSettings!.themeMode.toThemeMode == ThemeMode.dark) {
      return darkTheme;
    } else {
      return lightTheme;
    }
  }

  ThemeData? get darkTheme {
    return (themesSettings != null)
        ? _getTheme(themesSettings!.darkThemeSelected)
        : null;
  }

  ThemeData? get lightTheme => (themesSettings != null)
      ? _getTheme(themesSettings!.lightThemeSelected)
      : null;

  ThemeData? _getTheme(String themeName) {
    int indexThemesCreated = themesSettings!.themesCreated
        .indexWhere((element) => element.name == themeName);
    int indexThemesPreset = themesSettings!.themesPreset
        .indexWhere((element) => element.name == themeName);
    if (indexThemesCreated != -1) {
      return themesSettings!.themesCreated[indexThemesCreated].theme;
    } else if (indexThemesPreset != -1) {
      return themesSettings!.themesPreset[indexThemesPreset].theme;
    } else {
      return null;
    }
  }
}
