import 'package:flutter/material.dart';

class AppThemes {
  // Light theme with lavender/pink palette
  static final ThemeData light = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFB39DDB), // lavender
      secondary: Color(0xFFF48FB1), // soft pink
    ),
    scaffoldBackgroundColor: Colors.white,
    cardTheme: const CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.all(8),
      elevation: 2,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16.0),
      bodyMedium: TextStyle(fontSize: 14.0),
      bodySmall: TextStyle(fontSize: 12.0),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  // Dark theme – same hues adjusted for dark background
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF9575CD), // deeper lavender
      secondary: Color(0xFFF48FB1), // pink stays same
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardTheme: const CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.all(8),
      elevation: 2,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16.0),
      bodyMedium: TextStyle(fontSize: 14.0),
      bodySmall: TextStyle(fontSize: 12.0),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
