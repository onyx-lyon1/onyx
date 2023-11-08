import 'package:onyx/screens/settings/settings_export.dart';
import 'package:flutter/material.dart';

class OnyxTheme {
  ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    cardTheme: const CardTheme(color: Color(0xff4c566a)),
    cardColor: const Color(0xff4c566a),
    secondaryHeaderColor: const Color(0xff2f343f),
    primaryColor: const Color(0xffd08770),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color(0xffd08770),
      selectionColor: const Color(0xffd08770).withOpacity(0.7),
    ),
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff4c566a),
      unselectedItemColor: Color(0xffffffff),
      selectedItemColor: Color(0xffd08770),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color(0xffffffff)),
      bodyLarge: TextStyle(color: Color(0xffd8dee9)),
      bodyMedium: TextStyle(color: Color(0xffc2c8d2)),
    ),
    colorScheme: const ColorScheme.dark(
      background: Color(0xff434c5e),
      primary: Color(0xffd08770),
    ),
  );

  ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    cardTheme: const CardTheme(color: Color(0xffe5e9f0)),
    cardColor: const Color(0xffe5e9f0),
    primaryColor: const Color(0xffd08770),
    secondaryHeaderColor: const Color(0xffe5e9f0),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color(0xffd08770),
      selectionColor: const Color(0xffd08770).withOpacity(0.7),
    ),
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xffd8dee9),
      unselectedItemColor: Color(0xff4c566a),
      selectedItemColor: Color(0xffd08770),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color(0xff4c566a)),
      bodyLarge: TextStyle(color: Color(0xff4c566a)),
      bodyMedium: TextStyle(color: Color(0xff4c566a)),
    ),
    colorScheme: const ColorScheme.light(
      background: Color(0xffd8dee9),
      primary: Color(0xffd08770),
    ),
  );

  ThemeData nichihachiTheme = ThemeData(
    useMaterial3: true,
    cardTheme: const CardTheme(color: Color.fromARGB(255, 204, 226, 255)),
    cardColor: const Color.fromARGB(255, 204, 226, 255),
    secondaryHeaderColor: const Color.fromARGB(255, 255, 255, 255),
    primaryColor: const Color.fromARGB(255, 122, 198, 255),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color.fromARGB(255, 255, 123, 98),
      selectionColor: const Color.fromARGB(255, 255, 123, 98).withOpacity(0.7),
    ),
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 223, 234, 255),
      unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
      selectedItemColor: Color.fromARGB(255, 122, 198, 255),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      bodyLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      bodyMedium: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    ),
    colorScheme: const ColorScheme.dark(
      background: Color.fromARGB(255, 255, 255, 255),
      primary: Color.fromARGB(255, 122, 198, 255),
    ),
  );

  ThemeData blueSkyTheme = ThemeData(
    useMaterial3: true,
    cardTheme: const CardTheme(color: Color.fromARGB(255, 220, 240, 255)),
    cardColor: const Color.fromARGB(255, 220, 240, 255),
    secondaryHeaderColor: const Color.fromARGB(255, 255, 255, 255),
    primaryColor: const Color.fromARGB(255, 122, 198, 255),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color.fromARGB(255, 255, 123, 98),
      selectionColor: const Color.fromARGB(255, 255, 123, 98).withOpacity(0.7),
    ),
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(255, 223, 234, 255),
        unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
        selectedItemColor: Color.fromARGB(255, 122, 198, 255)),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      bodyLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      bodyMedium: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    ),
    colorScheme: const ColorScheme.light(
      background: Color.fromARGB(255, 204, 226, 255),
      primary: Color.fromARGB(255, 122, 198, 255),
    ),
  );
}

List<ThemeInfo> themesPreset = [
  ThemeInfo('Dark Default', OnyxTheme().darkTheme),
  ThemeInfo('Light Default', OnyxTheme().lightTheme),
  ThemeInfo('Nichi Hachi', OnyxTheme().nichihachiTheme),
  ThemeInfo('Blue Sky', OnyxTheme().blueSkyTheme),
];

List<ThemeInfo> themesPresetDark = themesPreset
    .where((themeInfo) => themeInfo.theme.brightness == Brightness.dark)
    .toList();

List<ThemeInfo> themesPresetLight = themesPreset
    .where((themeInfo) => themeInfo.theme.brightness == Brightness.light)
    .toList();
