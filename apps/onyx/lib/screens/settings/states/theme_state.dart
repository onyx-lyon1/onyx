part of 'theme_cubit.dart';

enum ThemeStateStatus { init, loaded, updated }

class ThemeState extends Equatable {
  final ThemeStateStatus status;
  final ThemeData? darkTheme;
  final ThemeData? lightTheme;
  final ThemeMode? themeMode;
  final ThemesUserData? themesUserData;

  const ThemeState({
    this.status = ThemeStateStatus.init,
    this.lightTheme,
    this.darkTheme,
    this.themeMode,
    this.themesUserData,
  });

  // Define a copyWith method for creating a new instance with modified properties
  ThemeState copyWith({
    ThemeStateStatus? status,
    ThemeData? darkTheme,
    ThemeData? lightTheme,
    ThemeMode? themeMode,
    ThemesUserData? themesUserData,
  }) {
    return ThemeState(
      status: status ?? this.status,
      darkTheme: darkTheme ?? this.darkTheme,
      lightTheme: lightTheme ?? this.lightTheme,
      themeMode: themeMode ?? this.themeMode,
      themesUserData: themesUserData ?? this.themesUserData,
    );
  }

  @override
  List<Object?> get props =>
      [status, darkTheme, lightTheme, themeMode, themesUserData];

  @override
  bool? get stringify => true;
}
