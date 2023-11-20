import 'package:onyx/screens/settings/settings_export.dart';
import 'package:flutter/material.dart';

class OnyxTheme {
  static ThemeData darkTheme = ThemeData(
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
      bodySmall: TextStyle(color: Colors.black),
    ),
    colorScheme: const ColorScheme.dark(
      background: Color(0xff434c5e),
      primary: Color(0xffd08770),
    ),
  );

  static ThemeData lightTheme = ThemeData(
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
      bodySmall: TextStyle(color: Colors.white),
    ),
    colorScheme: const ColorScheme.light(
      background: Color(0xffd8dee9),
      primary: Color(0xffd08770),
    ),
  );

  static ThemeData nichihachiTheme = ThemeData(
    useMaterial3: true,
    cardTheme: const CardTheme(color: Color.fromARGB(255, 40, 40, 60)),
    cardColor: const Color.fromARGB(255, 40, 40, 60),
    secondaryHeaderColor: const Color.fromARGB(255, 2, 36, 68),
    primaryColor: const Color.fromARGB(255, 80, 120, 255),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color.fromARGB(255, 140, 251, 255),
      selectionColor: const Color.fromARGB(255, 140, 251, 255).withOpacity(0.7),
    ),
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 30, 30, 50),
      unselectedItemColor: Color.fromARGB(255, 120, 120, 120),
      selectedItemColor: Color.fromARGB(255, 80, 120, 255),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      bodyLarge: TextStyle(color: Color.fromARGB(255, 211, 211, 211)),
      bodyMedium: TextStyle(color: Color.fromARGB(255, 211, 211, 211)),
      bodySmall: TextStyle(color: Colors.black),
    ),
    colorScheme: const ColorScheme.dark(
      background: Color.fromARGB(255, 20, 20, 30),
      primary: Color.fromARGB(255, 80, 120, 255),
    ),
  );

  static ThemeData blueSkyTheme = ThemeData(
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
        selectedItemColor: Color.fromARGB(255, 74, 166, 236)),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color.fromARGB(255, 76, 79, 106)),
      bodyLarge: TextStyle(color: Color.fromARGB(255, 76, 79, 106)),
      bodyMedium: TextStyle(color: Color.fromARGB(255, 76, 79, 106)),
      bodySmall: TextStyle(color: Colors.white),
    ),
    colorScheme: const ColorScheme.light(
      background: Color.fromARGB(255, 204, 226, 255),
      primary: Color.fromARGB(255, 74, 166, 236),
    ),
  );

  static ThemeData ultrakillTheme = ThemeData(
    useMaterial3: true,
    cardTheme: const CardTheme(color: Color.fromARGB(255, 30, 30, 30)),
    cardColor: const Color.fromARGB(255, 30, 30, 30),
    secondaryHeaderColor: const Color.fromARGB(40, 255, 255, 255),
    primaryColor: const Color.fromARGB(255, 255, 87, 34),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color.fromARGB(255, 255, 87, 34),
      selectionColor: const Color.fromARGB(255, 255, 87, 34).withOpacity(0.7),
    ),
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 40, 40, 40),
      unselectedItemColor: Color.fromARGB(255, 120, 120, 120),
      selectedItemColor: Color.fromARGB(255, 255, 87, 34),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      bodyLarge: TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
      bodyMedium: TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
      bodySmall: TextStyle(color: Colors.black),
    ),
    colorScheme: const ColorScheme.dark(
      background: Color.fromARGB(255, 20, 20, 20),
      primary: Color.fromARGB(255, 255, 87, 34),
    ),
  );

  static ThemeData badappleTheme = ThemeData(
    useMaterial3: true,
    cardTheme: const CardTheme(color: Color.fromARGB(255, 20, 20, 20)),
    cardColor: const Color.fromARGB(255, 20, 20, 20),
    primaryColor: const Color.fromARGB(230, 255, 255, 255),
    secondaryHeaderColor: const Color.fromARGB(255, 255, 255, 255),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color.fromARGB(255, 255, 255, 255),
      selectionColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
    ),
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 10, 10, 10),
      unselectedItemColor: Color.fromARGB(255, 100, 100, 100),
      selectedItemColor: Color.fromARGB(255, 255, 255, 255),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      bodyLarge: TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
      bodyMedium: TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
      bodySmall: TextStyle(color: Colors.black),
    ),
    colorScheme: const ColorScheme.dark(
      background: Color.fromARGB(255, 10, 10, 10),
      primary: Color.fromARGB(255, 200, 200, 200),
    ),
  );

  static ThemeData moonlightTheme = ThemeData(
    useMaterial3: true,
    cardTheme: const CardTheme(color: Color.fromARGB(255, 35, 40, 50)),
    cardColor: const Color.fromARGB(255, 35, 40, 50),
    primaryColor: const Color.fromARGB(255, 140, 180, 200),
    secondaryHeaderColor: const Color.fromARGB(40, 255, 255, 255),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color.fromARGB(255, 140, 180, 200),
      selectionColor: const Color.fromARGB(255, 140, 180, 200).withOpacity(0.7),
    ),
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 25, 30, 35),
      unselectedItemColor: Color.fromARGB(255, 80, 80, 80),
      selectedItemColor: Color.fromARGB(255, 140, 180, 200),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color.fromARGB(255, 200, 200, 220)),
      bodyLarge: TextStyle(color: Color.fromARGB(255, 180, 180, 180)),
      bodyMedium: TextStyle(color: Color.fromARGB(255, 180, 180, 180)),
      bodySmall: TextStyle(color: Colors.black),
    ),
    colorScheme: const ColorScheme.dark(
      background: Color.fromARGB(255, 20, 25, 30),
      primary: Color.fromARGB(255, 140, 180, 200),
    ),
  );

  static ThemeData stardewValleyTheme = ThemeData(
    useMaterial3: true,
    cardTheme: const CardTheme(color: Color.fromARGB(255, 220, 240, 200)),
    cardColor: const Color.fromARGB(255, 220, 240, 200),
    primaryColor: const Color.fromARGB(255, 74, 212, 74),
    secondaryHeaderColor: const Color.fromARGB(255, 253, 248, 201),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color.fromARGB(255, 255, 200, 50),
      selectionColor: const Color.fromARGB(255, 255, 200, 50).withOpacity(0.7),
    ),
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 200, 220, 160),
      unselectedItemColor: Color.fromARGB(255, 83, 95, 77),
      selectedItemColor: Color.fromARGB(255, 74, 212, 74),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color.fromARGB(255, 76, 79, 106)),
      bodyLarge: TextStyle(color: Color.fromARGB(255, 76, 79, 106)),
      bodyMedium: TextStyle(color: Color.fromARGB(255, 76, 79, 106)),
      bodySmall: TextStyle(color: Colors.white),
    ),
    colorScheme: const ColorScheme.light(
      background: Color.fromARGB(255, 198, 226, 143),
      primary: Color.fromARGB(255, 34, 139, 34),
    ),
  );

  static List<ThemeInfo> themesPreset = [
    ThemeInfo('Dark Default', OnyxTheme.darkTheme),
    ThemeInfo('Light Default', OnyxTheme.lightTheme),
    ThemeInfo('Nichi Hachi', OnyxTheme.nichihachiTheme),
    ThemeInfo('Blue Sky', OnyxTheme.blueSkyTheme),
    ThemeInfo('ULTRAKILL', OnyxTheme.ultrakillTheme),
    ThemeInfo('Stardew Valley', OnyxTheme.stardewValleyTheme),
    ThemeInfo('Bad Apple', OnyxTheme.badappleTheme),
    ThemeInfo('Moon Light', OnyxTheme.moonlightTheme),
  ];

  static List<ThemeInfo> themesPresetDark = themesPreset
      .where((themeInfo) => themeInfo.theme.brightness == Brightness.dark)
      .toList();

  static List<ThemeInfo> themesPresetLight = themesPreset
      .where((themeInfo) => themeInfo.theme.brightness == Brightness.light)
      .toList();
}
