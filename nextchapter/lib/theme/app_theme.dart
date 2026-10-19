import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Цветовая палитра: тёплые бежевые и светло-коричневые оттенки.
class AppColors {
  static const background = Color(0xFFFAF7F2);
  static const surface = Colors.white;
  static const primary = Color(0xFF6F5B49);
  static const accent = Color(0xFFC8A27A);
  static const chip = Color(0xFFF0EBE4);
  static const border = Color(0xFFE2D9CE);
  static const ink = Color(0xFF2B2420);
  static const muted = Color(0xFF8A7D72);
  static const heart = Color(0xFFB5523B);
  static const star = Color(0xFFD9A441);
  static const shadow = Color(0x1F000000);
}

class AppTheme {
  /// Общая форма для всех карточек в приложении.
  static const cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );

  static ThemeData get light {
    final base = ThemeData.light().textTheme;

    // Заголовки — шрифт с засечками (Lora), основной текст — Inter.
    final textTheme = base.copyWith(
      headlineMedium: GoogleFonts.lora(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),
      titleLarge: GoogleFonts.lora(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        height: 1.5,
        color: AppColors.ink,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        height: 1.4,
        color: AppColors.muted,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.accent,
        surface: AppColors.background,
        onSurface: AppColors.ink,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: GoogleFonts.lora(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
