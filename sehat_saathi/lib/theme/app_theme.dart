import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary colors representing Pakistan's flag colors with a modern tech twist
  static const Color primaryGreen = Color(0xFF006600); // Darker Pakistan Green
  static const Color lightGreen = Color(0xFFE8F5E9);
  static const Color accentGreen = Color(0xFF4CAF50);
  static const Color surfaceWhite = Colors.white;
  static const Color textDark = Color(0xFF1E1E1E);
  static const Color textLight = Color(0xFF757575);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: lightGreen,
      colorScheme: ColorScheme.light(
        primary: primaryGreen,
        secondary: accentGreen,
        surface: surfaceWhite,
      ),
      textTheme: GoogleFonts.latoTextTheme().copyWith(
        displayLarge: GoogleFonts.lato(color: textDark, fontWeight: FontWeight.bold),
        titleLarge: GoogleFonts.lato(color: textDark, fontWeight: FontWeight.bold),
        bodyLarge: GoogleFonts.lato(color: textDark),
        bodyMedium: GoogleFonts.lato(color: textDark),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryGreen,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.lato(
          color: surfaceWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: surfaceWhite),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: surfaceWhite,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
