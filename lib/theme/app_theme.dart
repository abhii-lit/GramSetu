import 'package:flutter/material.dart';

class AppTheme {
  // ===== Color Palette =====
  static const Color primaryGreen = Color(0xFF1B8E3E);
  static const Color lightGreen = Color(0xFFE6F4EA);
  static const Color background = Color(0xFFF7F9FC);
  static const Color accent = Color(0xFF43A047);
  static const Color textDark = Color(0xFF212121);
  static const Color textLight = Color(0xFF757575);

  // ===== Theme Data =====
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: background,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      primary: primaryGreen,
      secondary: accent,
      background: background,
    ),

    // AppBar styling
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),

    // Text styling
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontWeight: FontWeight.bold,
        color: textDark,
        fontSize: 20,
      ),
      bodyLarge: TextStyle(
        color: textDark,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: textDark,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: textLight,
        fontSize: 12,
      ),
    ),

    // Button styling
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
