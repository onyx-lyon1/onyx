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
    cardTheme: const CardTheme(
        color: Color.fromARGB(
            255, 40, 40, 60)), // Fond du titre en haut de l'écran
    cardColor: const Color.fromARGB(
        255, 40, 40, 60), // Fond des sous-éléments de la page
    secondaryHeaderColor: Color.fromARGB(255, 2, 36, 68), // N'est pas utilisé
    primaryColor:
        const Color.fromARGB(255, 80, 120, 255), // Couleur des boutons
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color.fromARGB(255, 140, 251, 255), // N'est pas important
      selectionColor: const Color.fromARGB(255, 140, 251, 255).withOpacity(0.7),
    ),
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(
          255, 30, 30, 50), // Navigation entre les pages en bas de l'écran
      unselectedItemColor: Color.fromARGB(255, 120, 120, 120),
      selectedItemColor: Color.fromARGB(255, 80, 120, 255),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      bodyLarge: TextStyle(color: Color.fromARGB(255, 211, 211, 211)),
      bodyMedium: TextStyle(color: Color.fromARGB(255, 211, 211, 211)),
    ),
    colorScheme: const ColorScheme.dark(
      background: Color.fromARGB(255, 20, 20, 30), // Fond de l'écran
      primary: Color.fromARGB(255, 80, 120,
          255), // Pour certains éléments comme la couleur d'un texte défilant
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
        selectedItemColor: Color.fromARGB(255, 74, 166, 236)),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color.fromARGB(255, 76, 79, 106)),
      bodyLarge: TextStyle(color: Color.fromARGB(255, 76, 79, 106)),
      bodyMedium: TextStyle(color: Color.fromARGB(255, 76, 79, 106)),
    ),
    colorScheme: const ColorScheme.light(
      background: Color.fromARGB(255, 204, 226, 255),
      primary: Color.fromARGB(255, 74, 166, 236),
    ),
  );

  ThemeData ultrakillTheme = ThemeData(
    useMaterial3: true,
    cardTheme: const CardTheme(color: Color.fromARGB(255, 30, 30, 30)),
    cardColor: const Color.fromARGB(255, 30, 30, 30),
    secondaryHeaderColor: Color.fromARGB(40, 255, 255, 255),
    primaryColor: const Color.fromARGB(255, 255, 87, 34), // Rouge vif
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color.fromARGB(255, 255, 87, 34), // Rouge vif
      selectionColor: const Color.fromARGB(255, 255, 87, 34).withOpacity(0.7),
    ),
    brightness: Brightness.dark, // Thème sombre pour un aspect futuriste
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 40, 40, 40), // Fond sombre
      unselectedItemColor: Color.fromARGB(255, 120, 120, 120), // Gris foncé
      selectedItemColor: Color.fromARGB(255, 255, 87, 34), // Rouge vif
    ),
    textTheme: const TextTheme(
      labelLarge:
          TextStyle(color: Color.fromARGB(255, 255, 255, 255)), // Texte blanc
      bodyLarge:
          TextStyle(color: Color.fromARGB(255, 200, 200, 200)), // Gris clair
      bodyMedium:
          TextStyle(color: Color.fromARGB(255, 200, 200, 200)), // Gris clair
    ),
    colorScheme: const ColorScheme.dark(
      background: Color.fromARGB(255, 20, 20, 20), // Fond très sombre
      primary: Color.fromARGB(255, 255, 87, 34), // Rouge vif
    ),
  );

  ThemeData badappleTheme = ThemeData(
    useMaterial3: true,
    cardTheme: const CardTheme(
        color: Color.fromARGB(
            255, 20, 20, 20)), // Fond du titre en haut de l'écran
    cardColor: const Color.fromARGB(
        255, 20, 20, 20), // Fond des sous-éléments de la page
    primaryColor: Color.fromARGB(230, 255, 255, 255), // Couleur des boutons
    secondaryHeaderColor: Color.fromARGB(255, 255, 255, 255),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor:
          const Color.fromARGB(255, 255, 255, 255), // N'est pas important
      selectionColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
    ),
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(
          255, 10, 10, 10), // Navigation entre les pages en bas de l'écran
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
      background: Color.fromARGB(255, 10, 10, 10), // Fond de l'écran
      primary: Color.fromARGB(255, 200, 200, 200), // Couleur secondaire
    ),
  );

  ThemeData moonlightTheme = ThemeData(
    useMaterial3: true,
    cardTheme: const CardTheme(
        color: Color.fromARGB(
            255, 35, 40, 50)), // Fond du titre en haut de l'écran
    cardColor: const Color.fromARGB(
        255, 35, 40, 50), // Fond des sous-éléments de la page
    primaryColor:
        const Color.fromARGB(255, 140, 180, 200), // Couleur des boutons
    textSelectionTheme: TextSelectionThemeData(
      cursorColor:
          const Color.fromARGB(255, 140, 180, 200), // N'est pas important
      selectionColor: const Color.fromARGB(255, 140, 180, 200).withOpacity(0.7),
    ),
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(
          255, 25, 30, 35), // Navigation entre les pages en bas de l'écran
      unselectedItemColor: Color.fromARGB(255, 80, 80, 80),
      selectedItemColor: Color.fromARGB(255, 140, 180, 200),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color.fromARGB(255, 200, 200, 220)),
      bodyLarge: TextStyle(color: Color.fromARGB(255, 180, 180, 180)),
      bodyMedium: TextStyle(color: Color.fromARGB(255, 180, 180, 180)),
    ),
    colorScheme: const ColorScheme.dark(
      background: Color.fromARGB(255, 20, 25, 30), // Fond de l'écran
      primary: Color.fromARGB(255, 140, 180,
          200), // Pour certains éléments comme la couleur d'un texte défilant
    ),
  );

  ThemeData stardewValleyTheme = ThemeData(
    useMaterial3: true,
    cardTheme: const CardTheme(
        color: Color.fromARGB(
            255, 220, 240, 200)), // Fond du titre en haut de l'écran
    cardColor: const Color.fromARGB(
        255, 220, 240, 200), // Fond des sous-éléments de la page
    primaryColor: Color.fromARGB(255, 74, 212, 74), // Couleur des boutons
    secondaryHeaderColor: Color.fromARGB(255, 253, 248, 201),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor:
          const Color.fromARGB(255, 255, 200, 50), // N'est pas important
      selectionColor: const Color.fromARGB(255, 255, 200, 50).withOpacity(0.7),
    ),
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(
          255, 200, 220, 160), // Navigation entre les pages en bas de l'écran
      unselectedItemColor: Color.fromARGB(255, 83, 95, 77),
      selectedItemColor: Color.fromARGB(255, 74, 212, 74),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Color.fromARGB(255, 76, 79, 106)),
      bodyLarge: TextStyle(color: Color.fromARGB(255, 76, 79, 106)),
      bodyMedium: TextStyle(color: Color.fromARGB(255, 76, 79, 106)),
    ),
    colorScheme: const ColorScheme.light(
      background: Color.fromARGB(255, 198, 226, 143),
      primary: Color.fromARGB(255, 34, 139, 34),
    ),
  );
}

List<ThemeInfo> themesPreset = [
  ThemeInfo('Dark Default', OnyxTheme().darkTheme),
  ThemeInfo('Light Default', OnyxTheme().lightTheme),
  ThemeInfo('Nichi Hachi', OnyxTheme().nichihachiTheme),
  ThemeInfo('Blue Sky', OnyxTheme().blueSkyTheme),
  ThemeInfo('ULTRAKILL', OnyxTheme().ultrakillTheme),
  ThemeInfo('Stardew Valley', OnyxTheme().stardewValleyTheme),
  ThemeInfo('Bad Apple', OnyxTheme().badappleTheme),
  ThemeInfo('Moon Light', OnyxTheme().moonlightTheme),
];

List<ThemeInfo> themesPresetDark = themesPreset
    .where((themeInfo) => themeInfo.theme.brightness == Brightness.dark)
    .toList();

List<ThemeInfo> themesPresetLight = themesPreset
    .where((themeInfo) => themeInfo.theme.brightness == Brightness.light)
    .toList();
