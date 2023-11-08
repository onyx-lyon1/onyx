part of 'theme_cubit.dart';

enum ThemeStateStatus { init, loaded, updated }

class ThemeState extends Equatable {
  final ThemeStateStatus status;
  final ThemeData? darkTheme;
  final ThemeData? lightTheme;
  final ThemeMode? themeMode;

  const ThemeState(
      {this.status = ThemeStateStatus.init,
      this.lightTheme,
      this.darkTheme,
      this.themeMode});

  // Define a copyWith method for creating a new instance with modified properties
  ThemeState copyWith({
    ThemeStateStatus? state,
    ThemeData? darkTheme,
    ThemeData? lightTheme,
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      status: state ?? this.status,
      darkTheme: darkTheme ?? this.darkTheme,
      lightTheme: lightTheme ?? this.lightTheme,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [status, darkTheme, lightTheme, themeMode];

  @override
  bool? get stringify => true;
}
