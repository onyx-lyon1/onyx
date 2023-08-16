import 'package:flutter/material.dart';

class OnyxTheme {
  static ThemeData darkTheme() {
    return ThemeData(
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
  }

  static ThemeData lighTheme() {
    return ThemeData(
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
  }
}
